class Api::V1::EventsController < Api::V1::ApiController
  def index
    buffet = Buffet.find(params[:buffet_id])

    if buffet.deactive?
      return render status: 404
    end

    events = buffet.events.active
    render status: 200, json: events.as_json(except: [:created_at, :updated_at, :status],
                                             include: { service_options: { only: :name } })
  end

  def available
    event = Event.find(params[:id])

    if event.active?
      begin
        qty_invited = params[:qty_invited].to_i
        return if render_error_for_max_invited(qty_invited, event)
        event_date = params[:event_date].to_date
        return if render_error_for_date(event_date)
      rescue Date::Error => error
        logger.error error
        return render status: 406, json: { error: 'a data informada é inválida' }
      end

      if available?(event_date)
        total_price = calculate_total_price(event, qty_invited, event_date)
        render status: 200, json: { status: true, total_price: total_price }
      else
        render status: 200, json: { status: false, msg: "O evento não pode ser agendado para a data e horário solicitados no Buffet: #{event.buffet.trading_name}. Por favor, escolha uma data e horário disponíveis." }
      end
    else
      render status: 404
    end
  end

  private

  def render_error_for_max_invited(qty_invited, event)
    if qty_invited > event.qty_max
      render status: 406, 
             json: { error: 'a quantidade de convidados é superior a quantidade limite suportada para o Evento' }
      return true
    end
  end

  def render_error_for_date(event_date)
    if event_date <= Date.current
      render status: 406, 
             json: { error: 'a data escolhida para realização do evento já passou!' }
      return true
    end
  end
  
  def available?(event_date)
    order = Order.new(id: SecureRandom.uuid, 
                      event_date: event_date, 
                      status: :pending
                    )

    Order.confirmed_same_date_orders(order).present? ? false : true
  end

  def calculate_total_price(event, qty_invited, event_date)
    base_price = calculate_base_price_per_chosen_day(event, event_date)
    return "não foi possível calcular o preço final" if base_price.nil?

    extra_price_per_people = 0
    if qty_invited > event.qty_min
      extra_people = qty_invited - event.qty_min
      extra_price_per_people = base_price.extra_price_per_person * extra_people
    end
    
    base_price.min_price + extra_price_per_people
  end

  def calculate_base_price_per_chosen_day(event, event_date)
    chosen_category_day = event_date.on_weekend? ? :weekend : :weekdays
    event.base_prices.where('chosen_category_day = ?', BasePrice.chosen_category_days[chosen_category_day]).first
  end
end

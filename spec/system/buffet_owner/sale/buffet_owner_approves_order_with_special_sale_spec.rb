require 'rails_helper'

describe 'Dono de Buffet aprova um pedido em promoção' do
  it 'com sucesso' do
    pix = PaymentMethod.create!(name: 'Pix')
    
    manu = Client.create!(
      name: 'Manu',
      itin: '00189137096',
      email: 'manu@contato.com', 
      password: 'u!Qm926Kz8qupGTPh'
    )

    grenah_gastronomia = BuffetOwner.create!(
      email: 'contato@grenahgastronomia.com', 
      password: 'grenahgastronomia123'
    )

    grenah_buffet = Buffet.create!(        
      trading_name: 'Espaço Grenah | Gastronomia', 
      company_name: 'Espaço Grenah | Gastronomia Ltda.',
      registration_number: '00401207000178', 
      phone: '1430298587', 
      email: 'contato@grenahgastronomia.com', 
      address: 'Rua Azevedo Soares, 633',
      neighborhood: 'Jardim Anália Franco',
      state: 'SP', 
      city: 'Sorocaba', 
      zipcode: '03322000',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    anniversary_event = Event.create!(
      name: 'Festa de Aniversário',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: false,
      buffet: grenah_buffet
    )

    BasePrice.create!(
      min_price: 10_000,
      chosen_category_day: 'weekdays',
      extra_price_per_person: 250,
      extra_price_per_duration: 1000,
      event: anniversary_event
    )

    BasePrice.create!(
      min_price: 14_000,
      chosen_category_day: 'weekend',
      extra_price_per_person: 300,
      extra_price_per_duration: 1500,
      event: anniversary_event
    )

    Sale.create!(
      name: 'Grenah Oferta Especial',
      start_date: 2.days.from_now,
      end_date: 2.weeks.from_now,
      discount_percentage: 50,
      on_weekdays: true,
      on_weekend: true,
      event: anniversary_event,
      buffet: grenah_buffet
    )

    travel_to(3.days.from_now) do
      anniversary_order = Order.create!(
        event_date: Date.today.next_occurring(:sunday), 
        qty_invited: 50, 
        event_details: '#1 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: anniversary_event,
        client: manu,
        status: :approved
      )
      
      login_as grenah_gastronomia, scope: :buffet_owner

      visit root_path
      click_on 'Pedidos'
      click_on "##{anniversary_order.code}"
  
      expect(page).to have_content 'Aprove o Pedido preenchendo os campos, abaixo'
      expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados): R$ 7.000,00'     
    end
  end

  # it 'não deve impactar solicitações passadas'
end
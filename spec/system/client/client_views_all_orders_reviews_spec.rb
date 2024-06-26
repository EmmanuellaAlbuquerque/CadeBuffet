require 'rails_helper'

describe 'Cliente vê todas as avaliações' do
  it 'a partir da tela inicial' do

    pix = PaymentMethod.create!(name: 'Pix')
  
    manu = Client.create!(
      name: 'Manu',
      itin: '00189137096',
      email: 'manu@contato.com', 
      password: 'u!Qm926Kz8qupGTPh'
    )

    ana = Client.create!(
      name: 'Ana',
      itin: '29053152024',
      email: 'ana@example.com', 
      password: 'p@ssw0rd123'
    )    
  
    grenah_gastronomia = BuffetOwner.create!(
      email: 'contato@grenahgastronomia.com', 
      password: 'grenahgastronomia123'
    )
  
    grenah_buffet = Buffet.create!(        
      trading_name: 'Espaço Grenah | Gastronomia', 
      company_name: 'Espaço Grenah | Gastronomia Ltda.',
      registration_number: '00401207000178', 
      phone: '(83) 9 9834-0345', 
      email: 'contato@grenahgastronomia.com', 
      address: 'Rua Azevedo Soares, 633',
      neighborhood: 'Jardim Anália Franco',
      state: 'SP', 
      city: 'Sorocaba', 
      zipcode: '06386-095',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )
  
    wedding_party_event = Event.create!(
      name: 'Festa de Casamento',
      description: 'Uma ocasião de elegância e celebração com todos os familiares e amigos.',
      qty_min: 30,
      qty_max: 100,
      duration: 240,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: true,
      buffet: grenah_buffet
    )

    graduation_event = Event.create!(
      name: 'Festa de Formatura',
      description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
      qty_min: 50,
      qty_max: 100,
      duration: 180,
      menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
      exclusive_location: true,
      buffet: grenah_buffet
    )    
  
    BasePrice.create!(
      min_price: 10_000,
      chosen_category_day: 'weekdays',
      extra_price_per_person: 250,
      extra_price_per_duration: 1000,
      event: wedding_party_event
    )
  
    BasePrice.create!(
      min_price: 14_000,
      chosen_category_day: 'weekend',
      extra_price_per_person: 300,
      extra_price_per_duration: 1500,
      event: wedding_party_event
    )  
  
    wedding_party_event_order_manu = Order.create!(
      event_date: 1.day.from_now, 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: wedding_party_event,
      client: manu,
      status: :confirmed
    )

    graduation_event_order_manu = Order.create!(
      event_date: 1.day.from_now, 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de recepção animada e com pequenos detalhes característicos para os formandos.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: graduation_event,
      client: manu,
      status: :confirmed
    )   
    
    graduation_event_order_ana = Order.create!(
      event_date: 1.day.from_now, 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de recepção animada e com pequenos detalhes característicos para os formandos.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: graduation_event,
      client: ana,
      status: :confirmed
    )     

    wedding_party_event_order_ana = Order.create!(
      event_date: 2.day.from_now, 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: wedding_party_event,
      client: ana,
      status: :confirmed
    )

    manu_order_evaluate = OrderEvaluation.create!(
      order: wedding_party_event_order_manu,
      rating: 5,
      service_opinion: 'Estou muitooo satisfeita com o serviço, nada a reclamar!'
    )

    manu_second_order_evaluate = OrderEvaluation.create!(
      order: graduation_event_order_manu,
      rating: 5,
      service_opinion: '...'
    )

    manu_second_order_evaluate.review_medias.attach(io: File.open(Rails.root.join('db', 'images', 'graduation01.jpg')), filename: 'graduation01.jpg')
    manu_second_order_evaluate.review_medias.attach(io: File.open(Rails.root.join('db', 'images', 'graduation02.jpg')), filename: 'graduation02.jpg')

    ana_second_order_evaluate = OrderEvaluation.create!(
      order: graduation_event_order_ana,
      rating: 3,
      service_opinion: '...'
    )

    travel_to(5.days.from_now)

    ana_order_evaluate = OrderEvaluation.create!(
      order: wedding_party_event_order_ana,
      rating: 2,
      service_opinion: 'Estou extremamente insatisfeita com minha experiência. A qualidade da comida deixou muito a desejar e o atendimento foi deplorável.'
    )    
    
    login_as manu, scope: :client
  
    visit root_path
    click_on 'Espaço Grenah | Gastronomia'
    click_on 'Ver mais avaliações'

    expect(page).to have_content 'Espaço Grenah | Gastronomia'
    expect(page).to have_content 'Avaliações'
    within('section#reviews .card:nth-of-type(1)') do
      expect(page).to have_content 'Ana'
      expect(page).to have_content '⭐ ⭐'
      expect(page).to have_content "#{I18n.l(ana_order_evaluate.created_at.to_date)} às #{ana_order_evaluate.created_at.in_time_zone(I18n.t('time_zone')).strftime('%H:%M')}"
      expect(page).to have_content 'Estou extremamente insatisfeita com minha experiência. A qualidade da comida deixou muito a desejar e o atendimento foi deplorável.'
    end

    within('section#reviews .card:nth-of-type(2)') do
      expect(page).to have_content 'Manu'
      expect(page).to have_content '⭐ ⭐ ⭐ ⭐ ⭐'
      expect(page).to have_content "#{I18n.l(manu_order_evaluate.created_at.to_date)} às #{manu_order_evaluate.created_at.in_time_zone(I18n.t('time_zone')).strftime('%H:%M')}"
      expect(page).to have_content 'Estou muitooo satisfeita com o serviço, nada a reclamar!'
    end

    within('section#reviews .card:nth-of-type(3)') do
      expect(page).to have_content 'Manu'
      expect(page).to have_content '⭐ ⭐ ⭐ ⭐ ⭐'
      expect(page).to have_content "#{I18n.l(manu_second_order_evaluate.created_at.to_date)} às #{manu_second_order_evaluate.created_at.in_time_zone(I18n.t('time_zone')).strftime('%H:%M')}"
      expect(page).to have_content '...'
      expect(page).to have_css("img[alt='Foto (1) do Evento Festa de Formatura realizado para o cliente Manu']")
      expect(page).to have_css('img[src*="graduation01.jpg"]')    
      expect(page).to have_css("img[alt='Foto (2) do Evento Festa de Formatura realizado para o cliente Manu']")
      expect(page).to have_css('img[src*="graduation02.jpg"]')          
    end    

    within('section#reviews .card:nth-of-type(4)') do
      expect(page).to have_content 'Ana'
      expect(page).to have_content '⭐ ⭐ ⭐'
      expect(page).to have_content "#{I18n.l(ana_second_order_evaluate.created_at.to_date)} às #{ana_second_order_evaluate.created_at.in_time_zone(I18n.t('time_zone')).strftime('%H:%M')}"
      expect(page).to have_content '...'
    end
  end
end
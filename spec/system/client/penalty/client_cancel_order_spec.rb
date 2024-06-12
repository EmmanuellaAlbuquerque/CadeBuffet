require 'rails_helper'

describe 'Cliente cancela pedido' do

  it 'no dia previsto para o evento, com sucesso' do
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
      exclusive_location: false,
      buffet: grenah_buffet
    )

    Penalty.create!(
      event: wedding_party_event,
      days_ago: 30,
      value_percentage: 50
    )
    
    Penalty.create!(
      event: wedding_party_event,
      days_ago: 20,
      value_percentage: 60
    )

    Penalty.create!(
      event: wedding_party_event,
      days_ago: 0,
      value_percentage: 100
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
  
    wedding_party_event_order = Order.create!(
      event_date: Date.today.next_occurring(:sunday), 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: wedding_party_event,
      client: manu,
      status: :approved
    )

    OrderPayment.create!(
      extra_tax: 0,
      discount: 0,
      description: 'sem desconto',
      validity_date: 1.week.from_now,
      payment_method: pix,
      order: wedding_party_event_order,
      standard_price: 14_000
    )
    
    login_as manu, scope: :client
  
    travel_to Date.today.next_occurring(:sunday) do
      visit root_path
      click_on 'Meus Pedidos'
      click_on "##{wedding_party_event_order.code}"
      
      expect(page).to have_content 'Multa por cancelamento: R$ 14.000,00'
    end
  end

  it '30 dias antes da data prevista para o evento, com sucesso' do
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
      exclusive_location: false,
      buffet: grenah_buffet
    )

    Penalty.create!(
      event: wedding_party_event,
      days_ago: 30,
      value_percentage: 50
    )
    
    Penalty.create!(
      event: wedding_party_event,
      days_ago: 20,
      value_percentage: 60
    )

    Penalty.create!(
      event: wedding_party_event,
      days_ago: 0,
      value_percentage: 100
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
  
    wedding_party_event_order = Order.create!(
      event_date: 1.month.from_now.next_week(:sunday), 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: wedding_party_event,
      client: manu,
      status: :approved
    )

    OrderPayment.create!(
      extra_tax: 0,
      discount: 0,
      description: 'sem desconto',
      validity_date: 1.week.from_now,
      payment_method: pix,
      order: wedding_party_event_order,
      standard_price: 14_000
    )
    
    login_as manu, scope: :client
  
    travel_to 2.weeks.from_now do
      visit root_path
      click_on 'Meus Pedidos'
      click_on "##{wedding_party_event_order.code}"
      
      expect(page).to have_content 'Multa por cancelamento: R$ 7.000,00'
    end
  end
end
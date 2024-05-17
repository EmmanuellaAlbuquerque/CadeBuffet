require 'rails_helper'

describe 'Cliente confirma pedido' do
  it 'a partir da tela inicial' do
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
      event_date: Date.today.next_occurring(:wednesday), 
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
      discount: 1000,
      description: '10% de desconto para pagamento via Pix',
      validity_date: 1.week.from_now,
      payment_method: pix,
      order: wedding_party_event_order,
      standard_price: 9_000
    )
    
    login_as manu, scope: :client
  
    visit root_path
    click_on 'Meus Pedidos'
    click_on "##{wedding_party_event_order.code}"
    
    expect(page).to have_content 'Status: Aguardando confirmação do cliente'
    expect(page).to have_button 'Confirmar Pedido'
    expect(page).to have_button 'Cancelar Pedido'
  end

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
      event_date: Date.today.next_occurring(:wednesday), 
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
      discount: 1000,
      description: '10% de desconto para pagamento via Pix',
      validity_date: 1.week.from_now,
      payment_method: pix,
      order: wedding_party_event_order,
      standard_price: 9_000
    )
    
    login_as manu, scope: :client
  
    visit root_path
    click_on 'Meus Pedidos'
    click_on "##{wedding_party_event_order.code}"
    click_on 'Confirmar Pedido'
    
    expect(page).to have_content 'Status: Pedido Confirmado'
    expect(page).to have_content 'Pedido confirmado com sucesso!'
  end

  it 'com a data atual maior do que a data-limite para confirmação' do

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
      event_date: Date.today.next_occurring(:wednesday), 
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
      discount: 1000,
      description: '10% de desconto para pagamento via Pix',
      validity_date: Date.tomorrow,
      payment_method: pix,
      order: wedding_party_event_order,
      standard_price: 9_000
    )
    
    login_as manu, scope: :client

    travel_to(2.days.from_now) do
      visit root_path
      click_on 'Meus Pedidos'
      click_on "##{wedding_party_event_order.code}"
      click_on 'Confirmar Pedido'
      
      expect(page).to have_content 'Não foi possível confirmar o pedido. Por favor, entre em contato com o Dono de Buffet para ajustar a data limite ou faça um novo pedido.'
    end
  end

  it 'e Dono de Buffet não pode atualizar o valor do pedido' do
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
  
    BasePrice.create!(
      min_price: 10_000,
      chosen_category_day: 'weekdays',
      extra_price_per_person: 250,
      extra_price_per_duration: 1000,
      event: wedding_party_event
    )
  
    wedding_party_event_order = Order.create!(
      event_date: Date.today.next_occurring(:wednesday), 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: wedding_party_event,
      client: manu,
      status: :confirmed
    )
  
    login_as grenah_gastronomia, scope: :buffet_owner
  
    visit root_path
    click_on 'Pedidos'
    click_on "##{wedding_party_event_order.code}"
    
    expect(page).to have_content 'Status: Pedido Confirmado'
    expect(page).not_to have_button 'Aprovar Pedido'
  end
end

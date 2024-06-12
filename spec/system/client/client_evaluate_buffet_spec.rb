require 'rails_helper'

describe 'Cliente avalia Buffet' do
  it 'caso o evento já tenha sido realizado' do

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
      status: :confirmed
    )
    
    login_as manu, scope: :client
  
    visit root_path
    click_on 'Meus Pedidos'
    click_on "##{wedding_party_event_order.code}"

    expect(page).not_to have_content 'Avalie o Buffet'
  end

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
      event_date: 1.day.from_now, 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: wedding_party_event,
      client: manu,
      status: :confirmed
    )
    
    login_as manu, scope: :client

    travel_to(2.day.from_now)
  
    visit root_path
    click_on 'Meus Pedidos'
    click_on "##{wedding_party_event_order.code}"

    within('#evaluate-order') do
      expect(page).to have_content 'Avalie o Buffet'
      expect(page).to have_field '1'
      expect(page).to have_field '2'
      expect(page).to have_field '3'
      expect(page).to have_field '4'
      expect(page).to have_field '5'
      expect(page).to have_field 'Você está satisfeito com o serviço? (Se desejar, detalhe pontos de melhoras)'
      expect(page).to have_button 'Enviar Avaliação'
    end
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
      event_date: 1.day.from_now, 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: wedding_party_event,
      client: manu,
      status: :confirmed
    )
    
    login_as manu, scope: :client

    travel_to(2.day.from_now)
  
    visit root_path
    click_on 'Meus Pedidos'
    click_on "##{wedding_party_event_order.code}"
    attach_file 'Fotos do Evento (opcional)', Rails.root.join('spec', 'support', 'images', 'sobel_feldman_buffet_template.png')
    choose '5'
    fill_in 'Você está satisfeito com o serviço? (Se desejar, detalhe pontos de melhoras)', with: 'Estou muitooo satisfeita com o serviço, nada a reclamar!'
    click_on 'Enviar Avaliação'

    expect(page).to have_content 'Avaliação salva com sucesso!'
  end
end

require 'rails_helper'

describe 'Um usuário Cliente cadastra um pedido' do
  it 'e deve estar autenticado' do

    pix = PaymentMethod.create!(name: 'Pix')    

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
      zipcode: '06386-095',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: true,
      buffet: grenah_buffet
    )   

    visit root_path
    click_on 'Espaço Grenah | Gastronomia'
    click_on 'Ver mais Detalhes'

    expect(page).to have_content 'Detalhes do Evento Gala de Aniversário de 50 Anos'
    expect(page).not_to have_link 'Fazer pedido'
  end

  it 'a partir da tela inicial, em evento com localidade a escolha do cliente' do

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
      zipcode: '06386-095',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    gala_event = Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: false,
      buffet: grenah_buffet
    )   

    login_as manu

    visit root_path
    click_on 'Espaço Grenah | Gastronomia'
    click_on 'Ver mais Detalhes'
    click_on 'Fazer pedido'

    expect(current_path).to eq new_event_order_path(gala_event.id)
    expect(page).to have_content 'Faça seu Pedido de Evento'
    expect(page).to have_content 'Tipo de Evento: Gala de Aniversário de 50 Anos'
    expect(page).to have_field 'Data do Evento'
    expect(page).to have_field 'Quantidade estimada de convidados'
    expect(page).to have_field 'Detalhes do Evento'
    expect(page).to have_field 'Endereço (Opcional)'
  end

  it 'a partir da tela inicial, em evento com localidade exclusiva' do

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
      zipcode: '06386-095',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    gala_event = Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: true,
      buffet: grenah_buffet
    )   

    login_as manu

    visit root_path
    click_on 'Espaço Grenah | Gastronomia'
    click_on 'Ver mais Detalhes'
    click_on 'Fazer pedido'

    expect(current_path).to eq new_event_order_path(gala_event.id)
    expect(page).to have_content 'Faça seu Pedido de Evento'
    expect(page).to have_content 'Tipo de Evento: Gala de Aniversário de 50 Anos'
    expect(page).to have_field 'Data do Evento'
    expect(page).to have_field 'Quantidade estimada de convidados'
    expect(page).to have_field 'Detalhes do Evento'
    expect(page).not_to have_field 'Endereço (Opcional)'      
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
      zipcode: '06386-095',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    Event.create!(
      name: 'Festa de Aniversário',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: false,
      buffet: grenah_buffet
    )

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('I6K9NDQH')

    login_as manu

    visit root_path
    click_on 'Espaço Grenah | Gastronomia'
    within('#event-1') do
      click_on 'Ver mais Detalhes'
    end
    click_on 'Fazer pedido'

    fill_in 'Data do Evento', with: 1.week.from_now
    fill_in 'Quantidade estimada de convidados', with: 50
    fill_in 'Detalhes do Evento', 
      with: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas, candelabros flutuantes e banners das quatro casas de Hogwarts (Gryffindor, Slytherin, Ravenclaw e Hufflepuff) pendurados nas paredes.'
    fill_in 'Endereço (Opcional)', with: 'Rua Biboca Diagonal, 934'
    click_on 'Enviar Solicitação de Pedido'

    expect(page).to have_content 'Pedido solicitado com sucesso!'
    expect(page).to have_content 'Detalhes do Pedido #I6K9NDQH'
    expect(page).to have_content 'Serviço oferecido pelo Buffet: Espaço Grenah | Gastronomia'
    expect(page).to have_content 'Tipo de Evento: Festa de Aniversário'
    expect(page).to have_content "Data do Evento: #{I18n.l(1.week.from_now.to_date)}"
    expect(page).to have_content 'Quantidade estimada de convidados: 50'
    expect(page).to have_content 'Detalhes do Evento: Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas, candelabros flutuantes e banners das quatro casas de Hogwarts (Gryffindor, Slytherin, Ravenclaw e Hufflepuff) pendurados nas paredes.'
    expect(page).to have_content 'Endereço: Rua Biboca Diagonal, 934'
    expect(page).to have_content 'Status: Aguardando avaliação do buffet'
  end

  it 'em um evento que possui promoção' do
    
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
      zipcode: '06386-095',
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

    sale = Sale.create!(
      name: 'Grenah Oferta Especial',
      start_date: 2.days.from_now,
      end_date: 2.weeks.from_now,
      discount_percentage: 50,
      on_weekdays: true,
      on_weekend: true,
      event: anniversary_event,
      buffet: grenah_buffet
    )
    
    order_payment = OrderPayment.create!(
      extra_tax: 0,
      discount: 0,
      description: '...',
      validity_date: 1.week.from_now,
      payment_method: pix,
      order: anniversary_order,
      standard_price: 14_000 - (14_000 * (sale.discount_percentage/100.0)),
      special_sale: true
    )

    login_as manu, scope: :client

    visit root_path
    click_on 'Meus Pedidos'
    click_on "##{anniversary_order.code}"

    expect(order_payment.standard_price).to eq 7000
    expect(page).to have_content 'Cálculo do Valor Final do Pedido'
    expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados)'
    expect(page).to have_content 'Preço Padrão: R$ 7.000,00 (Em promoção)'
    expect(page).to have_content '+ Taxa Extra: R$ 0,00'
    expect(page).to have_content '- Desconto: R$ 0,00'
    expect(page).to have_content 'Valor final do pedido: R$ 7.000,00'
  end

  it 'com dados incompletos' do

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
      zipcode: '06386-095',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    Event.create!(
      name: 'Festa de Aniversário',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: false,
      buffet: grenah_buffet
    )   

    login_as manu

    visit root_path
    click_on 'Espaço Grenah | Gastronomia'
    within('#event-1') do
      click_on 'Ver mais Detalhes'
    end
    click_on 'Fazer pedido'

    fill_in 'Data do Evento', with: ''
    fill_in 'Quantidade estimada de convidados', with: ''
    fill_in 'Detalhes do Evento', 
      with: ''
    fill_in 'Endereço (Opcional)', with: ''
    click_on 'Enviar Solicitação de Pedido'

    expect(page).to have_content 'Não foi possível solicitar o Pedido de Evento!'
    expect(page).to have_content 'Data do Evento não pode ficar em branco'
    expect(page).to have_content 'Quantidade estimada de convidados não pode ficar em branco'
  end
end

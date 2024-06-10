require 'rails_helper'

describe 'Dono de Buffet edita Evento' do
  it 'e deve estar autenticado' do
    
    pix = PaymentMethod.create!(name: 'Pix')
    parking_service = ServiceOption.create!(name: 'Serviço de Estacionamento')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu')

    buffet = Buffet.create!(
      trading_name: 'Serviço de Bufê do Maicão', 
      company_name: 'Serviço de Bufê do Michaels LTDA.',
      registration_number: '21395428000150', 
      phone: '8393734865', 
      email: 'contato@cateringbymichaels.com',
      address: 'Rua Diógenes Cassimiro do Nascimento', 
      neighborhood: 'Paratibe', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58062338', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix]
    )

    event = Event.create!(
      name: 'Festa de debutante',
      description: 'Esta festa de debutante é um momento mágico e inesquecível.',
      qty_min: 100,
      qty_max: 500,
      duration: 180,
      menu: 'Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère.',
      service_options: [parking_service],
      buffet: buffet
    )

    visit edit_event_path(event.id)
    
    expect(current_path).to eq new_buffet_owner_session_path
  end

  it 'com sucesso' do
    pix = PaymentMethod.create!(name: 'Pix')
    ServiceOption.create!(name: 'Distribuição de Bebidas Alcoólicas')
    parking_service = ServiceOption.create!(name: 'Serviço de Estacionamento')
    ServiceOption.create!(name: 'Serviço de Valet')
    ServiceOption.create!(name: 'Serviço de Decoração')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu')

    buffet = Buffet.create!(
      trading_name: 'Serviço de Bufê do Maicão', 
      company_name: 'Serviço de Bufê do Michaels LTDA.',
      registration_number: '21395428000150', 
      phone: '8393734865', 
      email: 'contato@cateringbymichaels.com',
      address: 'Rua Diógenes Cassimiro do Nascimento', 
      neighborhood: 'Paratibe', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58062338', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix]
    )

    Event.create!(
      name: 'Festa de debutante',
      description: 'Esta festa de debutante é um momento mágico e inesquecível.',
      qty_min: 100,
      qty_max: 500,
      duration: 180,
      menu: 'Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère.',
      service_options: [parking_service],
      buffet: buffet
    )

    images_src = []

    ['sobel_feldman_buffet_template.png', 
    'aquarela_buffet_template.jpg', 
    'placeholder_buffet_image.jpeg'].each do |image_src|
      images_src.push(Rails.root.join('spec', 'support', 'images', image_src))
    end

    login_as maicao, scope: :buffet_owner

    visit root_path
    click_on 'Festa de debutante'
    click_on 'Editar'
    attach_file 'Fotos do Evento', images_src
    fill_in 'Descrição', with: 'Esta festa de debutante é um momento mágico e inesquecível, onde a debutante é apresentada à sociedade em grande estilo. Com uma atmosfera de glamour e sofisticação, a festa oferece uma mistura encantadora de música, dança e momentos emocionantes.'
    fill_in 'Quantidade mínima de pessoas', with: 50
    fill_in 'Duração do Evento', with: 240
    fill_in 'Cardápio', with: 'Entradas: Canapés de salmão defumado com cream cheese, Bolinhos de camarão com molho tártaro. Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère. Sobremesas: Brigadeiros gourmet de diversos sabores. Bebidas: Coquetéis sem álcool, como limonada rosa ou mocktails de frutas tropicais.'
    uncheck 'Localização do Evento'
    uncheck 'Serviço de Estacionamento'
    check 'Serviço de Valet'
    check 'Serviço de Decoração'
    click_on 'Atualizar'

    expect(page).to have_content 'Evento atualizado com sucesso.'
    expect(page).to have_content 'Festa de debutante'
    expect(page).to have_css("img[alt='Foto do Evento Festa de debutante - 1']")
    expect(page).to have_css("img[alt='Foto do Evento Festa de debutante - 2']")
    expect(page).to have_css("img[alt='Foto do Evento Festa de debutante - 3']")
    expect(page).to have_css('img[src*="aquarela_buffet_template.jpg"]')    
    expect(page).to have_css('img[src*="sobel_feldman_buffet_template.png"]')    
    expect(page).to have_css('img[src*="placeholder_buffet_image.jpeg"]')    
    expect(page).to have_content 'Descrição: Esta festa de debutante é um momento mágico e inesquecível, onde a debutante é apresentada à sociedade em grande estilo. Com uma atmosfera de glamour e sofisticação, a festa oferece uma mistura encantadora de música, dança e momentos emocionantes.'
    expect(page).to have_content 'Quantidade mínima de pessoas: 50'
    expect(page).to have_content 'Quantidade máxima de pessoas: 500'
    expect(page).to have_content 'Duração do Evento: 240 (min)'
    expect(page).to have_content 'Localização do Evento: A escolha do cliente'
    expect(page).to have_content 'Cardápio: Entradas: Canapés de salmão defumado com cream cheese, Bolinhos de camarão com molho tártaro. Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère. Sobremesas: Brigadeiros gourmet de diversos sabores. Bebidas: Coquetéis sem álcool, como limonada rosa ou mocktails de frutas tropicais.'
    expect(page).to have_content 'Opções Extras do Serviço:'
    expect(page).to have_content 'Serviço de Valet'
    expect(page).to have_content 'Serviço de Decoração'
  end

  it 'com dados incompletos' do

    pix = PaymentMethod.create!(name: 'Pix')
    ServiceOption.create!(name: 'Distribuição de Bebidas Alcoólicas')
    parking_service = ServiceOption.create!(name: 'Serviço de Estacionamento')
    ServiceOption.create!(name: 'Serviço de Valet')
    ServiceOption.create!(name: 'Serviço de Decoração')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu')

    buffet = Buffet.create!(
      trading_name: 'Serviço de Bufê do Maicão', 
      company_name: 'Serviço de Bufê do Michaels LTDA.',
      registration_number: '21395428000150', 
      phone: '8393734865', 
      email: 'contato@cateringbymichaels.com',
      address: 'Rua Diógenes Cassimiro do Nascimento', 
      neighborhood: 'Paratibe', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58062338', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix]
    )

    Event.create!(
      name: 'Festa de debutante',
      description: 'Esta festa de debutante é um momento mágico e inesquecível.',
      qty_min: 100,
      qty_max: 500,
      duration: 180,
      menu: 'Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère.',
      service_options: [parking_service],
      buffet: buffet
    )

    login_as maicao, scope: :buffet_owner

    visit root_path
    click_on 'Festa de debutante'
    click_on 'Editar'
    fill_in 'Descrição', with: ''
    fill_in 'Quantidade mínima de pessoas', with: ''
    fill_in 'Duração do Evento', with: ''
    click_on 'Atualizar'

    occurrences = all('div.invalid-feedback', text: 'não pode ficar em branco')

    expect(occurrences.count).to eq(3)
    expect(page).to have_content 'Não foi possível atualizar o Evento.'
  end

  it 'caso seja o responsável por ele' do

    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')

    manu = BuffetOwner.create!(
      email: 'manu@gmail.com', 
      password: '9LMPBu!ae4u$CM9%s'
    )      

    maicao = BuffetOwner.create!(
      email: 'maicao@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu'
    )
  
    maicao_buffet = Buffet.create!(
      trading_name: 'Serviço de Bufê do Maicão', 
      company_name: 'Serviço de Bufê do Michaels LTDA.',
      registration_number: '21395428000150', 
      phone: '8393734865', 
      email: 'contato@cateringbymichaels.com',
      address: 'Rua Diógenes Cassimiro do Nascimento', 
      neighborhood: 'Paratibe', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58062338', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix]
    )
  
    maicao_event = Event.create!(
      name: 'Festa de debutante',
      description: 'Esta festa de debutante é um momento mágico e inesquecível.',
      qty_min: 100,
      qty_max: 500,
      duration: 180,
      menu: 'Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère.',
      service_options: [valet_service],
      buffet: maicao_buffet
    )

    Buffet.create!(
      trading_name: 'Serviço de Bufê da Manu', 
      company_name: 'Serviço de Bufê da Manu LTDA.',
      registration_number: '00150213954280', 
      phone: '8393348765', 
      email: 'manu@gmail.com',
      address: 'Rua dos Cartaxos, 144', 
      neighborhood: 'Centro', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58062338', 
      description: 'Uma descrição',
      buffet_owner: manu,
      payment_methods: [pix]
    )

    login_as manu, scope: :buffet_owner
    visit edit_event_path(maicao_event.id)

    expect(current_path).to eq owner_dashboard_path
    expect(page).to have_content 'Você não possui acesso a esse Evento!'
  end  
end
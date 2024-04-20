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
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')
    decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')

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

    login_as maicao, scope: :buffet_owner

    visit root_path
    click_on 'Festa de debutante'
    click_on 'Editar'
    fill_in 'Descrição', with: 'Esta festa de debutante é um momento mágico e inesquecível, onde a debutante é apresentada à sociedade em grande estilo. Com uma atmosfera de glamour e sofisticação, a festa oferece uma mistura encantadora de música, dança e momentos emocionantes.'
    fill_in 'Quantidade mínima de pessoas', with: 50
    fill_in 'Duração Padrão', with: 240
    fill_in 'Cardápio', with: 'Entradas: Canapés de salmão defumado com cream cheese, Bolinhos de camarão com molho tártaro. Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère. Sobremesas: Brigadeiros gourmet de diversos sabores. Bebidas: Coquetéis sem álcool, como limonada rosa ou mocktails de frutas tropicais.'
    uncheck 'Serviço de Estacionamento'
    check 'Serviço de Valet'
    check 'Serviço de Decoração'
    click_on 'Salvar'

    expect(page).to have_content 'Evento atualizado com sucesso.'
    expect(page).to have_content 'Festa de debutante'
    expect(page).to have_content 'Descrição: Esta festa de debutante é um momento mágico e inesquecível, onde a debutante é apresentada à sociedade em grande estilo. Com uma atmosfera de glamour e sofisticação, a festa oferece uma mistura encantadora de música, dança e momentos emocionantes.'
    expect(page).to have_content 'Quantidade mínima de pessoas: 50'
    expect(page).to have_content 'Quantidade máxima de pessoas: 500'
    expect(page).to have_content 'Duração Padrão: 240(min)'
    expect(page).to have_content 'Cardápio: Entradas: Canapés de salmão defumado com cream cheese, Bolinhos de camarão com molho tártaro. Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère. Sobremesas: Brigadeiros gourmet de diversos sabores. Bebidas: Coquetéis sem álcool, como limonada rosa ou mocktails de frutas tropicais.'
    expect(page).to have_content 'Opções Extras do Serviço:'
    expect(page).to have_content 'Serviço de Valet'
    expect(page).to have_content 'Serviço de Decoração'
  end
end
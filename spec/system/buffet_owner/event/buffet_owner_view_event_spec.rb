require 'rails_helper'

describe 'Dono de Buffet acessa seu dashboard' do
  it 'e vê seus eventos cadastrados' do
    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')
    decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')

    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')

    buffet = Buffet.create!(        
    trading_name: 'Buffet Tulipas - Villa Valentim', 
    company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
    registration_number: '12345678000123', 
    phone: ' 1129663900', 
    email: 'contato@buffettulipas.com.br', 
    address: 'Rua Valentim Magalhães, 293',
    neighborhood: ' Alto da Mooca',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '01234567',
    description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
    buffet_owner: buffet_owner,
    payment_methods: [pix])

    Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      service_options: [valet_service, decoration_service],
      buffet: buffet
    )

    Event.create!(
      name: 'Festa de Debutante',
      description: 'Esta festa de debutante é um momento mágico e inesquecível.',
      qty_min: 100,
      qty_max: 500,
      duration: 180,
      menu: 'Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère.',
      service_options: [valet_service, decoration_service],
      buffet: buffet
    )

    login_as buffet_owner, scope: :buffet_owner

    visit root_path

    expect(page).to have_content 'Tipos de Eventos disponíveis no seu Buffet'
    expect(page).to have_content 'Gala de Aniversário de 50 Anos'
    expect(page).to have_content 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.'
    expect(page).to have_content 'Festa de Debutante'
    expect(page).to have_content 'Esta festa de debutante é um momento mágico e inesquecível.'
  end

  it 'e visita um evento específico' do
    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')
    decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')

    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')

    buffet = Buffet.create!(        
    trading_name: 'Buffet Tulipas - Villa Valentim', 
    company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
    registration_number: '12345678000123', 
    phone: ' 1129663900', 
    email: 'contato@buffettulipas.com.br', 
    address: 'Rua Valentim Magalhães, 293',
    neighborhood: ' Alto da Mooca',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '01234567',
    description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
    buffet_owner: buffet_owner,
    payment_methods: [pix])

    Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: false,
      service_options: [valet_service, decoration_service],
      buffet: buffet
    )

    Event.create!(
      name: 'Festa de Debutante',
      description: 'Esta festa de debutante é um momento mágico e inesquecível, onde a debutante é apresentada à sociedade em grande estilo. Com uma atmosfera de glamour e sofisticação, a festa oferece uma mistura encantadora de música, dança e momentos emocionantes.',
      qty_min: 100,
      qty_max: 500,
      duration: 180,
      menu: 'Entradas: Canapés de salmão defumado com cream cheese, Bolinhos de camarão com molho tártaro. Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère. Sobremesas: Brigadeiros gourmet de diversos sabores. Bebidas: Coquetéis sem álcool, como limonada rosa ou mocktails de frutas tropicais.',
      exclusive_location: true,
      service_options: [valet_service, decoration_service],
      buffet: buffet
    )

    login_as buffet_owner, scope: :buffet_owner

    visit root_path
    click_on 'Festa de Debutante'

    expect(page).to have_content 'Festa de Debutante'
    expect(page).to have_content 'Descrição: Esta festa de debutante é um momento mágico e inesquecível, onde a debutante é apresentada à sociedade em grande estilo. Com uma atmosfera de glamour e sofisticação, a festa oferece uma mistura encantadora de música, dança e momentos emocionantes.'
    expect(page).to have_content 'Quantidade mínima de pessoas: 100'
    expect(page).to have_content 'Quantidade máxima de pessoas: 500'
    expect(page).to have_content 'Duração Padrão: 180 (min)'
    expect(page).to have_content 'Cardápio: Entradas: Canapés de salmão defumado com cream cheese, Bolinhos de camarão com molho tártaro. Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère. Sobremesas: Brigadeiros gourmet de diversos sabores. Bebidas: Coquetéis sem álcool, como limonada rosa ou mocktails de frutas tropicais.'
    expect(page).to have_content 'Localização do Evento Exclusiva: Sim'
    expect(page).to have_content 'Opções Extras do Serviço:'
    expect(page).to have_content 'Serviço de Valet'
    expect(page).to have_content 'Serviço de Decoração'
  end
end
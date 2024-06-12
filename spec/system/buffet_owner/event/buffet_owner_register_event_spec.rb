require 'rails_helper'

describe 'Dono de Buffet cadastra tipo de evento' do
  it 'a partir do seu dashboard' do

    pix = PaymentMethod.create!(name: 'Pix')
    ServiceOption.create!(name: 'Serviço de Estacionamento')
    ServiceOption.create!(name: 'Serviço de Valet')
    ServiceOption.create!(name: 'Distribuição de Bebidas Alcoólicas')
    ServiceOption.create!(name: 'Serviço de Decoração')

    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')

    Buffet.create!(        
    trading_name: 'Buffet Tulipas - Villa Valentim', 
    company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
    registration_number: CNPJ.generate(true), 
    phone: '(83) 9 9834-0345', 
    email: 'contato@buffettulipas.com.br', 
    address: 'Rua Valentim Magalhães, 293',
    neighborhood: ' Alto da Mooca',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '06397-410',
    description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
    buffet_owner: buffet_owner,
    payment_methods: [pix])
    
    login_as buffet_owner, scope: :buffet_owner

    visit root_path

    click_on 'Cadastre um Tipo de evento'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Quantidade mínima de pessoas'
    expect(page).to have_field 'Quantidade máxima de pessoas'
    expect(page).to have_field 'Duração do Evento'
    expect(page).to have_content 'Cardápio'
    expect(page).to have_content 'Opções Extras'
    expect(page).to have_field 'Distribuição de Bebidas Alcoólicas'
    expect(page).to have_field 'Serviço de Decoração'
    expect(page).to have_field 'Serviço de Estacionamento'
    expect(page).to have_field 'Serviço de Valet'
    expect(page).to have_button 'Cadastrar'
  end

  it 'com sucesso' do
    pix = PaymentMethod.create!(name: 'Pix')
    ServiceOption.create!(name: 'Distribuição de Bebidas Alcoólicas')
    ServiceOption.create!(name: 'Serviço de Decoração')

    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3'
    )

    Buffet.create!(        
    trading_name: 'Buffet Tulipas - Villa Valentim', 
    company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
    registration_number: CNPJ.generate(true), 
    phone: '(83) 9 9834-0345', 
    email: 'contato@buffettulipas.com.br', 
    address: 'Rua Valentim Magalhães, 293',
    neighborhood: ' Alto da Mooca',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '06397-410',
    description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
    buffet_owner: buffet_owner,
    payment_methods: [pix],
    )
    
    login_as buffet_owner, scope: :buffet_owner
    visit root_path
    click_on 'Cadastre um Tipo de evento'
    attach_file 'Fotos do Evento', Rails.root.join('spec', 'support', 'images', 'sobel_feldman_buffet_template.png')
    fill_in 'Nome', with: 'Festa de debutante'
    fill_in 'Descrição', with: 'Esta festa de debutante é um momento mágico e inesquecível, onde a debutante é apresentada à sociedade em grande estilo. Com uma atmosfera de glamour e sofisticação, a festa oferece uma mistura encantadora de música, dança e momentos emocionantes.'
    fill_in 'Quantidade mínima de pessoas', with: 100
    fill_in 'Quantidade máxima de pessoas', with: 500
    fill_in 'Duração do Evento', with: 180
    fill_in 'Cardápio', with: 'Entradas: Canapés de salmão defumado com cream cheese, Bolinhos de camarão com molho tártaro. Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère. Sobremesas: Brigadeiros gourmet de diversos sabores. Bebidas: Coquetéis sem álcool, como limonada rosa ou mocktails de frutas tropicais.'
    check 'Serviço de Decoração'
    check 'Distribuição de Bebidas Alcoólicas'
    check 'Localização do Evento'
    click_on 'Cadastrar'
    
    expect(page).to have_content 'Evento cadastrado com sucesso.'
    expect(page).to have_content 'Cadastro de preço base pendente'
    expect(page).to have_content 'Festa de debutante'
    expect(page).to have_css("img[alt='Foto do Evento Festa de debutante']")
    expect(page).to have_css('img[src*="sobel_feldman_buffet_template.png"]')
    expect(page).to have_content 'Esta festa de debutante é um momento mágico e inesquecível, onde a debutante é apresentada...'
  end

  it 'com dados incompletos' do

    pix = PaymentMethod.create!(name: 'Pix')
    ServiceOption.create!(name: 'Distribuição de Bebidas Alcoólicas')
    ServiceOption.create!(name: 'Serviço de Decoração')

    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3'
    )

    Buffet.create!(        
    trading_name: 'Buffet Tulipas - Villa Valentim', 
    company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
    registration_number: CNPJ.generate(true), 
    phone: '(83) 9 9834-0345', 
    email: 'contato@buffettulipas.com.br', 
    address: 'Rua Valentim Magalhães, 293',
    neighborhood: ' Alto da Mooca',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '06397-410',
    description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
    buffet_owner: buffet_owner,
    payment_methods: [pix],
    )
    
    login_as buffet_owner, scope: :buffet_owner
    visit root_path
    click_on 'Cadastre um Tipo de evento'
    fill_in 'Nome', with: 'Festa de debutante'
    fill_in 'Descrição', with: 'Esta festa de debutante é um momento mágico e inesquecível, onde a debutante é apresentada à sociedade em grande estilo. Com uma atmosfera de glamour e sofisticação, a festa oferece uma mistura encantadora de música, dança e momentos emocionantes.'
    click_on 'Cadastrar'

    occurrences = all('div.invalid-feedback', text: 'não pode ficar em branco')

    expect(occurrences.count).to eq(4)
    expect(page).to have_content 'Evento não cadastrado'
  end
end

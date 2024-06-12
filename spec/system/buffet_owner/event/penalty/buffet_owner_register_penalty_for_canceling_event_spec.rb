require 'rails_helper'

describe 'Dono de Buffet cadastra multa para cancelamento de evento' do
  # it 'e deve ser o responsável' do

  #   pix = PaymentMethod.create!(name: 'Pix')

  #   fernando_tulipas = BuffetOwner.create!(
  #     email: 'contato@fernandotulipas.com', 
  #     password: 'fernandodastulipas123'
  #   )

  #   caio_cozinha = BuffetOwner.create!(
  #     email: 'contato@caiocozinha.com', 
  #     password: 'caio123'
  #   )

  #   tulipas_buffet = Buffet.create!(        
  #     trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
  #     company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
  #     registration_number: '12345678000123', 
  #     phone: '1129663900', 
  #     email: 'contato@buffettulipas.com.br', 
  #     address: 'Rua Valentim Magalhães, 293',
  #     neighborhood: 'Alto da Mooca',
  #     state: 'SP', 
  #     city: 'São Paulo', 
  #     zipcode: '06397-410',
  #     description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
  #     buffet_owner: fernando_tulipas,
  #     payment_methods: [pix]
  #   )
    
  #   caio_buffet = Buffet.create!(        
  #     trading_name: 'Caio Cozinha & Eventos', 
  #     company_name: 'Caio Cozinha & Eventos Ltda.',
  #     registration_number: '92732949000102', 
  #     phone: '7723633113', 
  #     email: 'contato@caiocozinha.com', 
  #     address: 'Rua Comendador Bernardo Catarino, 89',
  #     neighborhood: 'Centro',
  #     state: 'BA', 
  #     city: 'Salvador', 
  #     zipcode: '06397-600',
  #     description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
  #     buffet_owner: caio_cozinha,
  #     payment_methods: [pix]
  #   )

  #   tulipas_graduation_event = Event.create!(
  #     name: 'Festa de Formatura',
  #     description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
  #     qty_min: 50,
  #     qty_max: 100,
  #     duration: 180,
  #     menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
  #     exclusive_location: true,
  #     buffet: tulipas_buffet
  #   )
    
  #   login_as caio_cozinha, scope: :buffet_owner
  #   get new_penalty_path 
  # end

  it 'a partir do dashboard' do
    
    pix = PaymentMethod.create!(name: 'Pix')

    fernando_tulipas = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

    tulipas_buffet = Buffet.create!(        
      trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
      company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
      registration_number: '12345678000123', 
      phone: '1129663900', 
      email: 'contato@buffettulipas.com.br', 
      address: 'Rua Valentim Magalhães, 293',
      neighborhood: 'Alto da Mooca',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '06397-410',
      description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
      buffet_owner: fernando_tulipas,
      payment_methods: [pix]
    )

    tulipas_graduation_event = Event.create!(
      name: 'Festa de Formatura',
      description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
      qty_min: 50,
      qty_max: 100,
      duration: 180,
      menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
      exclusive_location: true,
      buffet: tulipas_buffet
    )
    
    login_as fernando_tulipas, scope: :buffet_owner
    visit root_path
    click_on 'Festa de Formatura'
    click_on 'Cadastrar Multa'

    expect(page).to have_content 'Cadastre uma Multa para o evento: Festa de Formatura'
    expect(page).to have_field 'Período de antecedência ao evento'
    expect(page).to have_field 'Valor da Multa em (%)'
    expect(page).to have_button 'Cadastrar Multa'
  end

  it 'com sucesso' do
    pix = PaymentMethod.create!(name: 'Pix')

    fernando_tulipas = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

    tulipas_buffet = Buffet.create!(        
      trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
      company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
      registration_number: '12345678000123', 
      phone: '1129663900', 
      email: 'contato@buffettulipas.com.br', 
      address: 'Rua Valentim Magalhães, 293',
      neighborhood: 'Alto da Mooca',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '06397-410',
      description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
      buffet_owner: fernando_tulipas,
      payment_methods: [pix]
    )

    tulipas_graduation_event = Event.create!(
      name: 'Festa de Formatura',
      description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
      qty_min: 50,
      qty_max: 100,
      duration: 180,
      menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
      exclusive_location: true,
      buffet: tulipas_buffet
    )

    login_as fernando_tulipas, scope: :buffet_owner
    visit root_path
    click_on 'Festa de Formatura'
    click_on 'Cadastrar Multa'
    fill_in 'Período de antecedência ao evento (em dias)', with: 30
    fill_in 'Valor da Multa em (%)', with: 50
    click_on 'Cadastrar Multa'

    expect(page).to have_content 'Multa cadastrada com sucesso.'
    expect(page).to have_content 'Multas'
    expect(page).to have_content 'Período de antecedência ao evento (em dias): 30 dias'
    expect(page).to have_content 'Valor da Multa em (%): 50%'
  end
end
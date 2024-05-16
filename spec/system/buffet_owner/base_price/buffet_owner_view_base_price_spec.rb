require 'rails_helper'

describe 'Dono de Buffet acessa um Evento' do
  it 'e vê todos os preços base cadastrados' do
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
    neighborhood: 'Alto da Mooca',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '01234567',
    description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
    buffet_owner: buffet_owner,
    payment_methods: [pix])

    event = Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      service_options: [valet_service, decoration_service],
      buffet: buffet
    )

    BasePrice.create!(
      min_price: 4000,
      chosen_category_day: 'weekend',
      extra_price_per_person: 100,
      extra_price_per_duration: 150,
      event: event
    )

    BasePrice.create!(
      min_price: 3500,
      chosen_category_day: 'weekdays',
      extra_price_per_person: 90,
      extra_price_per_duration: 130,
      event: event
    )

    login_as buffet_owner, scope: :buffet_owner

    visit root_path
    click_on 'Gala de Aniversário de 50 Anos'

    expect(page).to have_content 'Detalhes dos Preço Base'
    expect(page).to have_content 'Durante o fim de semana (Sábado e Domingo)'
    expect(page).to have_content "R$ 4.000,00 (para #{event.qty_min} convidados)"
    expect(page).to have_content 'Durante a semana (De segunda a sexta-feira)'
    expect(page).to have_content "R$ 3.500,00 (para #{event.qty_min} convidados)"    
  end

  it 'e vê um preço base específico' do
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

    event = Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      service_options: [valet_service, decoration_service],
      buffet: buffet
    )

    BasePrice.create!(
      min_price: 4000,
      chosen_category_day: 'weekend',
      extra_price_per_person: 100,
      extra_price_per_duration: 150,
      event: event
    )

    BasePrice.create!(
      min_price: 3500,
      chosen_category_day: 'weekdays',
      extra_price_per_person: 90,
      extra_price_per_duration: 130,
      event: event
    )

    login_as buffet_owner, scope: :buffet_owner

    visit root_path
    click_on 'Gala de Aniversário de 50 Anos'
    click_on 'Durante a semana (De segunda a sexta-feira)'

    expect(page).to have_content 'Durante a semana (De segunda a sexta-feira)'
    expect(page).to have_content 'Preço mínimo: R$ 3.500,00'
    expect(page).to have_content 'Taxa adicional por pessoa: R$ 90'
    expect(page).to have_content 'Taxa adicional por hora extra: R$ 130'
  end
end
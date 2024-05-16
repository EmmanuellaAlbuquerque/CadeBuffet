require 'rails_helper'

describe 'Usuário Dono de Buffet registra preço base de um Evento' do
  it 'e deve estar autenticado' do
    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')

    fernando = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

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
      buffet_owner: fernando,
      payment_methods: [pix]
    )

    event = Event.create!(
      name: 'Casamento',
      description: 'Um dia especial para celebrar o amor e a união.',
      qty_min: 100,
      qty_max: 300,
      duration: 240,
      menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
      service_options: [valet_service],
      buffet: buffet
    )

    visit new_event_base_price_path(event.id)

    expect(current_path).to eq new_buffet_owner_session_path
  end

  it 'a partir do dashboard' do
    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')

    fernando = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

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
      buffet_owner: fernando,
      payment_methods: [pix]
    )

    Event.create!(
      name: 'Casamento',
      description: 'Um dia especial para celebrar o amor e a união.',
      qty_min: 100,
      qty_max: 300,
      duration: 240,
      menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
      service_options: [valet_service],
      buffet: buffet
    )

    login_as fernando, scope: :buffet_owner
    visit root_path
    click_on 'Casamento'
    click_on 'Adicionar Novo Preço Base'

    expect(page).to have_content('Adicione um Novo Preço Base')
    expect(page).to have_content('Durante a semana (De segunda a sexta-feira)')
    expect(page).to have_content('Durante o fim de semana (Sábado e Domingo)')
    expect(page).to have_field('Preço mínimo')
    expect(page).to have_field('Taxa adicional por pessoa')
    expect(page).to have_field('Taxa adicional por hora extra')
  end

  it 'com sucesso' do

    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')

    fernando = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

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
      buffet_owner: fernando,
      payment_methods: [pix]
    )

    event = Event.create!(
      name: 'Casamento',
      description: 'Um dia especial para celebrar o amor e a união.',
      qty_min: 50,
      qty_max: 300,
      duration: 240,
      menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
      service_options: [valet_service],
      buffet: buffet
    )

    login_as fernando, scope: :buffet_owner
    visit root_path
    click_on 'Casamento'
    click_on 'Adicionar Novo Preço Base'
    choose(option: 'weekend')
    fill_in 'Preço mínimo', with: '2000'
    fill_in 'Taxa adicional por pessoa', with: '70'
    fill_in 'Taxa adicional por hora extra', with: '100'
    click_on 'Salvar'

    expect(page).to have_content 'Preço Base cadastrado com sucesso.'
    expect(page).to have_content 'Durante o fim de semana (Sábado e Domingo)'
    expect(page).to have_content "R$ 2.000,00 (para #{event.qty_min} convidados)"
  end  

  it 'com período duplicado' do

    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')

    fernando = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

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
      buffet_owner: fernando,
      payment_methods: [pix]
    )

    event = Event.create!(
      name: 'Casamento',
      description: 'Um dia especial para celebrar o amor e a união.',
      qty_min: 50,
      qty_max: 300,
      duration: 240,
      menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
      service_options: [valet_service],
      buffet: buffet
    )

    BasePrice.create!(
      min_price: 4000,
      chosen_category_day: 'weekend',
      extra_price_per_person: 100,
      extra_price_per_duration: 150,
      event: event
    )

    login_as fernando, scope: :buffet_owner
    visit root_path
    click_on 'Casamento'
    click_on 'Adicionar Novo Preço Base'
    choose(option: 'weekend')
    fill_in 'Preço mínimo', with: '2000'
    fill_in 'Taxa adicional por pessoa', with: '70'
    fill_in 'Taxa adicional por hora extra', with: '100'
    click_on 'Salvar'

    expect(page).to have_content 'Você já cadastrou a Precificação durante esse Período.'
    expect(current_path).to eq event_base_prices_path(event_id: event.id)
  end

  it 'com dados incompletos' do

    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')

    fernando = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

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
      buffet_owner: fernando,
      payment_methods: [pix]
    )

    Event.create!(
      name: 'Casamento',
      description: 'Um dia especial para celebrar o amor e a união.',
      qty_min: 50,
      qty_max: 300,
      duration: 240,
      menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
      service_options: [valet_service],
      buffet: buffet
    )

    login_as fernando, scope: :buffet_owner
    visit root_path
    click_on 'Casamento'
    click_on 'Adicionar Novo Preço Base'
    choose(option: 'weekend')
    fill_in 'Taxa adicional por pessoa', with: '70'
    click_on 'Salvar'

    expect(page).to have_content 'Preço Base não cadastrado.'
    occurrences = all('div.invalid-feedback', text: 'não pode ficar em branco')
    expect(occurrences.count).to eq(2)
    expect(page).to have_content 'Preço mínimo não pode ficar em branco e não é um número'
    expect(page).to have_content 'Taxa adicional por hora extra não pode ficar em branco e não é um número'      
  end  
end
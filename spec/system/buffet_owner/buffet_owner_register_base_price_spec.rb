require 'rails_helper'

describe 'Usuário Dono de Buffet registra preço base de um Evento' do
  it 'e deve estar autenticado' do

    visit new_base_price_path

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
end
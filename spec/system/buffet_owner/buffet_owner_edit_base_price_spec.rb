require 'rails_helper'

describe 'Usuário Dono de Buffet edita um preço base' do

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

    base_price = EventBasePrice.create!(
      min_price: 4000,
      chosen_category_day: 'weekend',
      extra_price_per_person: 100,
      extra_price_per_duration: 150,
      event: event
    )

    login_as fernando, scope: :buffet_owner
    visit root_path
    click_on 'Casamento'
    click_on 'Durante o fim de semana (Sábado e Domingo)'
    click_on 'Editar'
    fill_in 'Preço mínimo', with: '3500'
    fill_in 'Taxa adicional por pessoa', with: '70'
    fill_in 'Taxa adicional por hora extra', with: '100'
    click_on 'Salvar'

    expect(page).to have_content 'Preço base atualizado com sucesso.'
    expect(page).to have_content 'R$ 3500'
    expect(current_path).to eq event_base_price_path(event_id: event.id, id: base_price.id)
  end  
end
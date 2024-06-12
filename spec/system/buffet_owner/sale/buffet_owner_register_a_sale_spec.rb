require 'rails_helper'

describe 'Dono de Buffet registra uma promoção' do
  it 'a partir do dashboard' do
    pix = PaymentMethod.create!(name: 'Pix')

    caio_cozinha = BuffetOwner.create!(
      email: 'contato@caiocozinha.com', 
      password: 'caio123'
    )    

    Buffet.create!(        
      trading_name: 'Caio Cozinha & Eventos', 
      company_name: 'Caio Cozinha & Eventos Ltda.',
      registration_number: '92732949000102', 
      phone: '7723633113', 
      email: 'contato@caiocozinha.com', 
      address: 'Rua Comendador Bernardo Catarino, 89',
      neighborhood: 'Centro',
      state: 'BA', 
      city: 'Salvador', 
      zipcode: '06397-600',
      description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
      buffet_owner: caio_cozinha,
      payment_methods: [pix]
    )

    login_as caio_cozinha, scope: :buffet_owner

    visit root_path
    click_on 'Cadastrar Promoção'

    expect(current_path).to eq new_sale_path
  end

  it 'com sucesso' do
    pix = PaymentMethod.create!(name: 'Pix')

    caio_cozinha = BuffetOwner.create!(
      email: 'contato@caiocozinha.com', 
      password: 'caio123'
    )    

    caio_buffet = Buffet.create!(        
      trading_name: 'Caio Cozinha & Eventos', 
      company_name: 'Caio Cozinha & Eventos Ltda.',
      registration_number: '92732949000102', 
      phone: '7723633113', 
      email: 'contato@caiocozinha.com', 
      address: 'Rua Comendador Bernardo Catarino, 89',
      neighborhood: 'Centro',
      state: 'BA', 
      city: 'Salvador', 
      zipcode: '06397-600',
      description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
      buffet_owner: caio_cozinha,
      payment_methods: [pix]
    )

    Event.create!(
      name: 'Festa de Formatura',
      description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
      qty_min: 50,
      qty_max: 100,
      duration: 180,
      menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
      buffet: caio_buffet
    )

    Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      buffet: caio_buffet
    )

    login_as caio_cozinha, scope: :buffet_owner

    visit root_path
    click_on 'Cadastrar Promoção'
    fill_in 'Nome', with: 'Promoção Express'
    select 'Festa de Formatura', from: 'Evento'
    fill_in 'Data de Início', with: 1.day.from_now
    fill_in 'Data de Fim', with: 2.day.from_now
    fill_in 'Porcentagem de Desconto (%)', with: 50
    check 'a semana'
    check 'o final de semana'
    click_on 'Cadastrar'

    expect(page).to have_content 'Promoção Express'
    expect(current_path).to eq buffet_sales_path(caio_buffet)
    expect(page).to have_content 'Promoção Express'
    expect(page).to have_content "Data de Início: #{I18n.l(1.day.from_now.to_date)}"
    expect(page).to have_content "Data de Fim: #{I18n.l(2.day.from_now.to_date)}"
    expect(page).to have_content 'Válido durante:'
    expect(page).to have_content 'a semana: Sim'
    expect(page).to have_content 'o final de semana: Sim'
  end
end
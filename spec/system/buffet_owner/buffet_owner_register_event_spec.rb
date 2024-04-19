require 'rails_helper'

describe 'Dono de Buffet cadastra tipo de evento' do
  it 'a partir do seu dashboard' do

    pix = PaymentMethod.find_by(name: 'Pix')

    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')

    Buffet.create!(        
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
    
    login_as buffet_owner, scope: :buffet_owner

    visit root_path

    click_on 'Cadastre um tipo de evento'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Quantidade mínima de pessoas'
    expect(page).to have_field 'Quantidade máxima de pessoas'
    expect(page).to have_field 'Duração Padrão'
    expect(page).to have_content 'Cardápio'
    # expect(page).to have_content 'Opções Extras'
    # expect(page).to have_field 'Bebidas Alcoólicas'
    # expect(page).to have_field 'Decoração'
    # expect(page).to have_field 'Serviço de Estacionamento'
    # expect(page).to have_field 'Serviço de Valet'
    expect(page).to have_button 'Salvar'
  end
end
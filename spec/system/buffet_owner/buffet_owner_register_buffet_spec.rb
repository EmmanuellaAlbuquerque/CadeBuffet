require 'rails_helper'

describe 'Dono de Buffet cadastra Buffet pela primeira vez' do
  it 'e deve estar autenticado' do
    
    visit root_path
    
    expect(page).to have_link 'Faça seu Login'
    expect(page).not_to have_button 'Sair'
  end

  it 'e deve ser redirecionado para a página de Cadastro de um Buffet' do
    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')
    
    login_as buffet_owner, scope: :buffet_owner
    visit root_path

    expect(current_path).to eq new_buffets_path
  end

  it 'com sucesso' do
    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')
    
    login_as buffet_owner, scope: :buffet_owner
    visit root_path

    fill_in 'Nome Fantasia', with: 'Wolfgang Puck Catering'
    fill_in 'Razão Social', with: 'Wolfgang Puck Catering Ltd.'
    fill_in 'CNPJ', with: '12345678000190'
    fill_in 'Telefone', with: '551112345678'
    fill_in 'E-mail', with: 'contato@pucksgastronomy.com'
    fill_in 'Endereço', with: 'Avenida 9 de Julho, 342'
    fill_in 'Bairro', with: 'Praça da Bandeira'
    fill_in 'Estado', with: 'São Paulo'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'CEP', with: '01153000'
    fill_in 'Descrição', with: 'Reconhecido por sua excelência 
    em serviços de buffet, proporcionando experiências 
    gastronômicas memoráveis para uma variedade de eventos.'
    # check 'Pix'
    # check 'Mastercard'
    # check 'Visa'
    # check 'Dinheiro'
    click_on 'Cadastrar'

    expect(page).to have_content 'Buffet cadastrado com sucesso.'
    expect(page).to have_content 'Nome Fantasia: Wolfgang Puck Catering'
    expect(page).to have_content 'Razão Social: Wolfgang Puck Catering Ltd.'
    expect(page).to have_content 'CNPJ: 12345678000190'
    expect(page).to have_content 'Telefone: 551112345678'
    expect(page).to have_content 'E-mail: contato@pucksgastronomy.com'
    expect(page).to have_content 'Endereço: Avenida 9 de Julho, 342'
    expect(page).to have_content 'Bairro: Praça da Bandeira'
    expect(page).to have_content 'Estado: São Paulo'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'CEP: 01153000'
    expect(page).to have_content "Descrição: Reconhecido por sua excelência em serviços de buffet, proporcionando experiências gastronômicas memoráveis para uma variedade de eventos."
    # expect(page).to have_checked_field 'Métodos de pagamento aceitos: Pix, Mastercard, Visa, Boleto.'
  end
end
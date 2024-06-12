require 'rails_helper'

describe 'Cliente se autentica' do
  it 'com sucesso' do
    visit root_path
    click_on 'Faça seu Login como Cliente'
    click_on 'Cadastre-se'
    fill_in 'Nome', with: 'Manu'
    fill_in 'CPF', with: '11111111111'
    fill_in 'E-mail', with: 'manu@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastre-se'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Manu'
    expect(page).to have_button 'Sair'
    client = Client.last
    expect(client.name).to eq 'Manu'
  end
end

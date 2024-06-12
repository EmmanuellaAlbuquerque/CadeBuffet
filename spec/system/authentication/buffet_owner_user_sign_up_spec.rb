require 'rails_helper'

describe 'Dono de Buffet se autentica' do
  it 'com sucesso' do
    visit root_path
    click_on 'Faça seu Login como Dono de Buffet'
    click_on 'Cadastre-se'
    fill_in 'E-mail', with: 'support@wolfgangpuck.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastre-se'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'support@wolfgangpuck.com'
    expect(page).to have_button 'Sair'
    buffet_owner = BuffetOwner.last
    expect(buffet_owner.email).to eq 'support@wolfgangpuck.com'
  end
end

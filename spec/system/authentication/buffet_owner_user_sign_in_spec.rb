require 'rails_helper'

describe 'Usuário Dono de Buffet se autentica' do
  it 'com sucesso' do
    BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')

    visit root_path
    click_on 'Faça seu Login'
    within('main') do
      fill_in 'E-mail', with: 'support@wolfgangpuck.com'
      fill_in 'Senha', with: 'biE@u4&mZ5G3p3'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).to have_button 'Sair'
      expect(page).not_to have_link 'Faça seu Login'
      expect(page).to have_content 'support@wolfgangpuck.com'
    end
  end

  it 'e faz logout' do
    BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')

    visit root_path
    click_on 'Faça seu Login'
    within('main') do
      fill_in 'E-mail', with: 'support@wolfgangpuck.com'
      fill_in 'Senha', with: 'biE@u4&mZ5G3p3'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    within('nav') do
      expect(page).to have_link 'Faça seu Login'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'support@wolfgangpuck.com'
    end        
  end  
end
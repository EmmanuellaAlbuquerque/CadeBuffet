require 'rails_helper'

describe 'Usuário Cliente se autentica' do
  it 'com sucesso' do
    Client.create!(
      name: 'Manu',
      itin: CPF.generate(true),
      email: 'manu@email.com', 
      password: '123456'
    )

    visit root_path
    click_on 'Faça seu Login como Cliente'
    within('main') do
      fill_in 'E-mail', with: 'manu@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).to have_button 'Sair'
      expect(page).not_to have_link 'Faça seu Login como Cliente'
      expect(page).to have_content 'Manu'
    end
  end

  it 'e faz logout' do
    Client.create!(
      name: 'Manu',
      itin: CPF.generate(true),
      email: 'manu@email.com', 
      password: '123456'
    )

    visit root_path
    click_on 'Faça seu Login como Cliente'
    within('main') do
      fill_in 'E-mail', with: 'manu@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    within('nav') do
      expect(page).to have_link 'Faça seu Login como Cliente'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'Manu'
    end        
  end  
end
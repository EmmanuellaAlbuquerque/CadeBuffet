require 'rails_helper'

describe 'Dono de Buffet que ainda não cadastrou seu Buffet, tenta' do
  it 'acessar a home da aplicação e é redirecionado' do
    buffet_owner = BuffetOwner.create!(
      email: 'contato@deyvin.com', 
      password: 'biE@u4&mZ5G3p3')

    login_as buffet_owner, scope: :buffet_owner
    visit root_path

    expect(page).to have_content 'Cadastre o seu Buffet'
    expect(current_path).to eq new_buffet_path
  end

  it 'acessar seu dashboard e é redirecionado' do
    buffet_owner = BuffetOwner.create!(
      email: 'contato@deyvin.com', 
      password: 'biE@u4&mZ5G3p3')

    login_as buffet_owner, scope: :buffet_owner
    visit owner_dashboard_path

    expect(page).to have_content 'Cadastre o seu Buffet'
    expect(current_path).to eq new_buffet_path
  end

  it 'acessar a tela de Login e é redirecionado' do
    buffet_owner = BuffetOwner.create!(
      email: 'contato@deyvin.com', 
      password: 'biE@u4&mZ5G3p3')

    login_as buffet_owner, scope: :buffet_owner
    visit new_buffet_owner_session_path

    expect(page).to have_content 'Cadastre o seu Buffet'
    expect(current_path).to eq new_buffet_path
  end  

  it 'fazer logout' do
    buffet_owner = BuffetOwner.create!(
      email: 'contato@deyvin.com', 
      password: 'biE@u4&mZ5G3p3')

    login_as buffet_owner, scope: :buffet_owner
    visit new_buffet_path
    click_on 'Sair'

    expect(page).to have_content 'Faça seu Login como Dono de Buffet'
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(current_path).to eq root_path
  end   
end
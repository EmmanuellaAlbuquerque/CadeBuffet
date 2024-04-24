require 'rails_helper'

describe 'Cliente se autentica' do
  it 'com sucesso' do
    client = Client.create!(
      name: 'Ana',
      itin: '29053152024',
      email: 'ana@example.com', 
      password: 'p@ssw0rd123'
    )

    login_as client, scope: :client
    visit root_path

    expect(page).to have_content 'Ana'
    expect(page).to have_button 'Sair'
    expect(current_path).to eq root_path
  end

  it 'e faz logout' do
    client = Client.create!(
      name: 'Ana',
      itin: '29053152024',
      email: 'ana@example.com', 
      password: 'p@ssw0rd123'
    )

    login_as client, scope: :client
    visit root_path
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Faça seu Login como Cliente'
    expect(page).to have_link 'Faça seu Login como Dono de Buffet'
    expect(current_path).to eq root_path
  end   
end

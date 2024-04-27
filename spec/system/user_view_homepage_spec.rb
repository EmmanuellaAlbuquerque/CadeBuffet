require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome da aplicação' do

    visit root_path

    within('nav') do
      expect(page).to have_link 'Cadê Buffet?'
      expect(page).to have_link 'Faça seu Login como Dono de Buffet'
      expect(page).to have_link 'Faça seu Login como Cliente'
    end
  end
end

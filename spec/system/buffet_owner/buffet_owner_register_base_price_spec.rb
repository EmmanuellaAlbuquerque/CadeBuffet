require 'rails_helper'

describe 'Usuário Dono de Buffet registra preço base de um Evento' do
  it 'e deve estar autenticado' do

    visit new_base_price_path

    expect(current_path).to eq new_buffet_owner_session_path
  end
end
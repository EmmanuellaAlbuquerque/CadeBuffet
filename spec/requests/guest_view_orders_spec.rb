require 'rails_helper'

describe 'Visitante vê pedidos' do
  it 'e é redirecionado' do
    
    get orders_path

    expect(response).to redirect_to new_client_session_path
  end
end

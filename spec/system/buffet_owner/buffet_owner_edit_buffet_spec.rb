require 'rails_helper'

describe 'Dono de Buffet edita Buffet' do
  it 'e deve estar autenticado' do
    
    pix = PaymentMethod.create!(name: 'Pix')
    credit_card = PaymentMethod.create!(name: 'Cartão de Crédito')
    debit_card = PaymentMethod.create!(name: 'Boleto')
    cash = PaymentMethod.create!(name: 'Dinheiro')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu')

    buffet = Buffet.create!(
      trading_name: 'Serviço de Bufê do Maicão', 
      company_name: 'Serviço de Bufê do Michaels LTDA.',
      registration_number: '21395428000150', 
      phone: '8393734865', 
      email: 'contato@cateringbymichaels.com',
      address: 'Rua Diógenes Cassimiro do Nascimento', 
      neighborhood: 'Paratibe', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58062338', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao
    )

    buffet.payment_methods = [pix, cash]

    visit edit_buffet_path(buffet.id)
    
    expect(current_path).to eq new_buffet_owner_session_path
  end
end
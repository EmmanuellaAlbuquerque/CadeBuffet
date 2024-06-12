require 'rails_helper'

describe 'Dono de Buffet tenta editar um Buffet' do
  it 'e não é o dono do Buffet' do
    pix = PaymentMethod.create!(name: 'Pix')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu')

    manu = BuffetOwner.create!(
      email: 'manu@gmail.com', 
      password: '9LMPBu!ae4u$CM9%s')      

    buffet = Buffet.create!(
      trading_name: 'Serviço de Bufê do Maicão', 
      company_name: 'Serviço de Bufê do Michaels LTDA.',
      registration_number: '21395428000150', 
      phone: '(83) 9 9834-0345', 
      email: 'contato@cateringbymichaels.com',
      address: 'Rua Diógenes Cassimiro do Nascimento, 867', 
      neighborhood: 'Remédios', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '06328-210', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix]
    )

    login_as manu, scope: :buffet_owner
    patch buffet_path(buffet.id), params: { buffet: { email: 'mr.robot@outlook.com' } }

    expect(response).to redirect_to owner_dashboard_path
  end 
end
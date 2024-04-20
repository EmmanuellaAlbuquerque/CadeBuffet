require 'rails_helper'

describe 'Dono de Buffet edita Evento' do
  it 'e deve estar autenticado' do
    
    pix = PaymentMethod.create!(name: 'Pix')
    parking_service = ServiceOption.create!(name: 'Serviço de Estacionamento')

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
      buffet_owner: maicao,
      payment_methods: [pix]
    )

    event = Event.create!(
      name: 'Festa de debutante',
      description: 'Esta festa de debutante é um momento mágico e inesquecível.',
      qty_min: 100,
      qty_max: 500,
      duration: 180,
      menu: 'Prato Principal: Filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère.',
      service_options: [parking_service],
      buffet: buffet
    )

    visit edit_event_path(event.id)
    
    expect(current_path).to eq new_buffet_owner_session_path
  end
end
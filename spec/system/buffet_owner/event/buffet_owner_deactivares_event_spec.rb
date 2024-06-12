require 'rails_helper'

describe 'Dono de buffet desativa Tipo de Evento' do
  it 'a partir do dashboard' do
    pix = PaymentMethod.create!(name: 'Pix')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu'
    )

    maicao_buffet =  Buffet.create!(
      trading_name: 'Maicão Cozinha & Eventos', 
      company_name: 'Serviço de Bufê do Michaels LTDA.',
      registration_number: '21395428000150', 
      phone: '8393734865', 
      email: 'contato@cateringbymichaels.com',
      address: 'Rua Diógenes Cassimiro do Nascimento, 867', 
      neighborhood: 'Remédios', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58900-000', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix],
      status: :deactive
    )

    Event.create!(
      name: 'Festa de Formatura',
      description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
      qty_min: 50,
      qty_max: 100,
      duration: 180,
      menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
      exclusive_location: true,
      buffet: maicao_buffet
    )

    Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      buffet: maicao_buffet
    )    

    login_as maicao, scope: :buffet_owner
    visit root_path
    click_on 'Festa de Formatura'
    click_on 'Desativar Evento'

    expect(page).to have_content 'O seu evento "Festa de Formatura" foi desativado!'
    expect(page).to have_content 'Festa de Formatura'
    expect(page).to have_content 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novo...'
    expect(page).to have_content 'Evento desativado'
  end

  it 'e o tipo de evento não é exibido na tela de detalhes do buffet para visitantes' do
    pix = PaymentMethod.create!(name: 'Pix')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu'
    )

    maicao_buffet =  Buffet.create!(
      trading_name: 'Maicão Cozinha & Eventos', 
      company_name: 'Serviço de Bufê do Michaels LTDA.',
      registration_number: '21395428000150', 
      phone: '8393734865', 
      email: 'contato@cateringbymichaels.com',
      address: 'Rua Diógenes Cassimiro do Nascimento, 867', 
      neighborhood: 'Remédios', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58900-000', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix]
    )

    Event.create!(
      name: 'Festa de Formatura',
      description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
      qty_min: 50,
      qty_max: 100,
      duration: 180,
      menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
      exclusive_location: true,
      buffet: maicao_buffet
    )

    Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      buffet: maicao_buffet,
      status: :deactive
    )    

    visit root_path
    click_on 'Maicão Cozinha & Eventos'

    expect(page).not_to have_content 'Gala de Aniversário de 50 Anos'  
    expect(page).not_to have_content 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa es...'  
    expect(page).to have_content 'Festa de Formatura'  
    expect(page).to have_content 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o iníc...'  
  end
end
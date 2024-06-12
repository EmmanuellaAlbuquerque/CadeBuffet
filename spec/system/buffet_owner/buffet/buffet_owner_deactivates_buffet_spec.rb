require 'rails_helper'

describe 'Dono de buffet desativa buffet' do
  it 'a partir do dashboard' do
    pix = PaymentMethod.create!(name: 'Pix')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu')

    Buffet.create!(
      trading_name: 'Serviço de Bufê do Maicão', 
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

    login_as maicao, scope: :buffet_owner
    visit root_path
    click_on 'Desativar Buffet'

    expect(page).to have_content 'O seu Buffet foi desativado!'
    expect(page).to have_content 'Status atual do Buffet: Desativado'
  end

  it 'e o buffet não é exibido na tela inicial para visitantes' do
    pix = PaymentMethod.create!(name: 'Pix')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu')

    caio_cozinha = BuffetOwner.create!(
      email: 'contato@caiocozinha.com', 
      password: 'caio123'
    )

    Buffet.create!(        
      trading_name: 'Caio Cozinha & Eventos', 
      company_name: 'Caio Cozinha & Eventos Ltda.',
      registration_number: '92732949000102', 
      phone: '7723633113', 
      email: 'contato@caiocozinha.com', 
      address: 'Rua Comendador Bernardo Catarino, 89',
      neighborhood: 'Centro',
      state: 'BA', 
      city: 'Salvador', 
      zipcode: '06397-600',
      description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
      buffet_owner: caio_cozinha,
      payment_methods: [pix]
    )    

    Buffet.create!(
      trading_name: 'Serviço de Bufê do Maicão', 
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

    visit root_path

    expect(page).not_to have_link 'Serviço de Bufê do Maicão'
    expect(page).not_to have_content 'João Pessoa - PB'
    expect(page).to have_link 'Caio Cozinha & Eventos'
    expect(page).to have_content 'Salvador - BA'    
  end

  it 'e o buffet não é exibido durante pesquisas' do
    pix = PaymentMethod.create!(name: 'Pix')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu')

    caio_cozinha = BuffetOwner.create!(
      email: 'contato@caiocozinha.com', 
      password: 'caio123'
    )

    Buffet.create!(        
      trading_name: 'Caio Cozinha & Eventos', 
      company_name: 'Caio Cozinha & Eventos Ltda.',
      registration_number: '92732949000102', 
      phone: '7723633113', 
      email: 'contato@caiocozinha.com', 
      address: 'Rua Comendador Bernardo Catarino, 89',
      neighborhood: 'Centro',
      state: 'BA', 
      city: 'Salvador', 
      zipcode: '06397-600',
      description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
      buffet_owner: caio_cozinha,
      payment_methods: [pix]
    )       

    Buffet.create!(
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

    visit root_path
    fill_in id: 'search_buffet_input', with: 'Cozinha & Eventos'
    click_on 'Pesquisar'

    expect(page).not_to have_link 'Maicão Cozinha & Eventos'
    expect(page).not_to have_content 'João Pessoa - PB'
    expect(page).to have_link 'Caio Cozinha & Eventos'
    expect(page).to have_content 'Salvador - BA'    
  end
end
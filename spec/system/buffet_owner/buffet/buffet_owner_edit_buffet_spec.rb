require 'rails_helper'

describe 'Dono de Buffet edita Buffet' do
  it 'e deve estar autenticado' do
    
    pix = PaymentMethod.create!(name: 'Pix')
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
      buffet_owner: maicao,
      payment_methods: [pix, cash]
    )

    visit edit_buffet_path(buffet.id)
    
    expect(current_path).to eq new_buffet_owner_session_path
  end

  it 'com sucesso' do
    pix = PaymentMethod.create!(name: 'Pix')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    PaymentMethod.create!(name: 'Cartão de Crédito')
    PaymentMethod.create!(name: 'Cartão de Débito')

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
      zipcode: '58062338', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix, cash]
    )

    login_as maicao, scope: :buffet_owner
    visit root_path
    click_on 'Editar dados do buffet'
    fill_in 'Cidade', with: 'Cajazeiras'
    fill_in 'Bairro', with: 'Remédios'
    fill_in 'CEP', with: '58900000'
    check 'Cartão de Crédito'
    check 'Cartão de Débito'
    uncheck 'Pix'
    uncheck 'Dinheiro'
    click_on 'Salvar'

    expect(page).to have_content 'Buffet atualizado com sucesso.'
    expect(page).to have_content 'Nome Fantasia: Serviço de Bufê do Maicão'
    expect(page).to have_content 'Razão Social: Serviço de Bufê do Michaels LTDA.'
    expect(page).to have_content 'CNPJ: 21395428000150'
    expect(page).to have_content 'Telefone: 8393734865'
    expect(page).to have_content 'E-mail: contato@cateringbymichaels.com'
    expect(page).to have_content 'Endereço: Rua Diógenes Cassimiro do Nascimento, 867'
    expect(page).to have_content 'Bairro: Remédios'
    expect(page).to have_content 'Estado: PB'
    expect(page).to have_content 'Cidade: Cajazeiras'
    expect(page).to have_content 'CEP: 58900000'
    expect(page).to have_content "Descrição: O mais renomado serviço de buffet da região costeira."
    expect(page).to have_content 'MÉTODOS DE PAGAMENTO ACEITOS'
    expect(page).to have_content 'Cartão de Crédito'
    expect(page).to have_content 'Cartão de Débito'
  end

  it 'com dados incompletos' do
    pix = PaymentMethod.create!(name: 'Pix')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    PaymentMethod.create!(name: 'Cartão de Crédito')
    PaymentMethod.create!(name: 'Cartão de Débito')

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
      zipcode: '58062338', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix, cash]
    )

    login_as maicao, scope: :buffet_owner
    visit root_path
    click_on 'Editar dados do buffet'
    fill_in 'Cidade', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'CEP', with: ''
    uncheck 'Pix'
    uncheck 'Dinheiro'
    click_on 'Salvar'

    occurrences = all('div.invalid-feedback', text: 'não pode ficar em branco')

    expect(occurrences.count).to eq(4)
    expect(page).to have_content 'Não foi possível atualizar o buffet.'
  end   

  it 'caso seja o responsável por ele' do

    pix = PaymentMethod.create!(name: 'Pix')

    maicao = BuffetOwner.create!(
      email: 'michaelspessoal@gmail.com', 
      password: '!ae4u$CM9%s9LMPBu')

    manu = BuffetOwner.create!(
      email: 'manu@gmail.com', 
      password: '9LMPBu!ae4u$CM9%s')      

    buffet_maicao = Buffet.create!(
      trading_name: 'Serviço de Bufê do Maicão', 
      company_name: 'Serviço de Bufê do Michaels LTDA.',
      registration_number: '21395428000150', 
      phone: '8393734865', 
      email: 'contato@cateringbymichaels.com',
      address: 'Rua Diógenes Cassimiro do Nascimento, 867', 
      neighborhood: 'Remédios', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58062338', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao,
      payment_methods: [pix]
    )

    buffet_manu = Buffet.create!(
      trading_name: 'Serviço de Bufê da Manu', 
      company_name: 'Serviço de Bufê da Manu LTDA.',
      registration_number: '00150213954280', 
      phone: '8393348765', 
      email: 'manu@gmail.com',
      address: 'Rua dos Cartaxos, 144', 
      neighborhood: 'Centro', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58062338', 
      description: 'Uma descrição',
      buffet_owner: manu,
      payment_methods: [pix]
    )

    login_as manu, scope: :buffet_owner
    visit edit_buffet_path(buffet_maicao.id)

    expect(current_path).to eq owner_dashboard_path
  end
end
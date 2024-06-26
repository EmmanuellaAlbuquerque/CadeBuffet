require 'rails_helper'

describe 'Dono de Buffet cadastra Buffet' do
  it 'e deve estar autenticado' do
    
    visit root_path
    
    expect(page).to have_link 'Faça seu Login'
    expect(page).not_to have_button 'Sair'
  end

  it 'a partir da tela inicial' do
    PaymentMethod.create!(name: 'Pix')
    PaymentMethod.create!(name: 'Dinheiro')
    PaymentMethod.create!(name: 'Cartão de Crédito')
    PaymentMethod.create!(name: 'Boleto')

    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')
    
    login_as buffet_owner, scope: :buffet_owner
    visit root_path
    
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Telefone')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Bairro')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Pix')
    expect(page).to have_field('Cartão de Crédito')
    expect(page).to have_field('Boleto')
  end

  it 'com sucesso' do
    PaymentMethod.create!(name: 'Pix')
    PaymentMethod.create!(name: 'Dinheiro')

    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')
    
    login_as buffet_owner, scope: :buffet_owner
    visit root_path

    fill_in 'Nome Fantasia', with: 'Wolfgang Puck Catering'
    fill_in 'Razão Social', with: 'Wolfgang Puck Catering Ltd.'
    fill_in 'CNPJ', with: '05.936.869/0001-66'
    fill_in 'Telefone', with: '(83) 9 9834-0345'
    fill_in 'E-mail', with: 'contato@pucksgastronomy.com'
    fill_in 'Endereço', with: 'Avenida 9 de Julho, 342'
    fill_in 'Bairro', with: 'Praça da Bandeira'
    fill_in 'Estado', with: 'SP'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'CEP', with: '06331-060'
    fill_in 'Descrição', with: 'Reconhecido por sua excelência em serviços de buffet, proporcionando experiências gastronômicas memoráveis para uma variedade de eventos.'
    check 'Pix'
    check 'Dinheiro'
    click_on 'Cadastrar'

    expect(page).to have_content 'Buffet cadastrado com sucesso.'
    expect(page).to have_content 'Nome Fantasia: Wolfgang Puck Catering'
    expect(page).to have_content 'Razão Social: Wolfgang Puck Catering Ltd.'
    expect(page).to have_content 'CNPJ: 05.936.869/0001-66'
    expect(page).to have_content 'Telefone: (83) 9 9834-0345'
    expect(page).to have_content 'E-mail: contato@pucksgastronomy.com'
    expect(page).to have_content 'Endereço: Avenida 9 de Julho, 342'
    expect(page).to have_content 'Bairro: Praça da Bandeira'
    expect(page).to have_content 'Estado: SP'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'CEP: 06331-060'
    expect(page).to have_content "Descrição: Reconhecido por sua excelência em serviços de buffet, proporcionando experiências gastronômicas memoráveis para uma variedade de eventos."
    expect(page).to have_content 'MÉTODOS DE PAGAMENTO ACEITOS'
    expect(page).to have_content 'Pix'
    expect(page).to have_content 'Dinheiro'
    expect(page).to have_content 'Nenhum evento cadastrado.'
  end

  it 'com dados incompletos' do
    PaymentMethod.create!(name: 'Pix')
    PaymentMethod.create!(name: 'Dinheiro')

    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')
    
    login_as buffet_owner, scope: :buffet_owner
    visit root_path

    fill_in 'Razão Social', with: 'Wolfgang Puck Catering Ltd.'
    fill_in 'CNPJ', with: '05.936.869/0001-66'
    fill_in 'Telefone', with: '(83) 9 9834-0345'
    fill_in 'E-mail', with: 'contato@pucksgastronomy.com'
    fill_in 'Cidade', with: 'São Paulo'
    click_on 'Cadastrar'

    occurrences = all('div.invalid-feedback', text: 'não pode ficar em branco')

    expect(occurrences.count).to eq(7)
    expect(page).to have_content 'Buffet não cadastrado.'
  end  

  it 'pela segunda vez' do
    buffet_owner = BuffetOwner.create!(
      email: 'support@wolfgangpuck.com', 
      password: 'biE@u4&mZ5G3p3')
    
    pix = PaymentMethod.create!(name: 'Pix')

    Buffet.create!(        
    trading_name: 'Wolfgang Puck Catering', 
    company_name: 'Wolfgang Puck Catering Ltd.',
    registration_number: CNPJ.generate(true), 
    phone: '(83) 9 9834-0345', 
    email: 'contato@pucksgastronomy.com', 
    address: 'Avenida 9 de Julho, 342',
    neighborhood: 'Praça da Bandeira',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '06331-060',
    description: 'Reconhecido por sua excelência em serviços de buffet.',
    buffet_owner: buffet_owner,
    payment_methods: [pix])
    
    login_as buffet_owner, scope: :buffet_owner

    visit new_buffet_path
    
    expect(current_path).to eq owner_dashboard_path
    expect(page).to have_content 'Você já cadastrou o seu Buffet.'
  end
end
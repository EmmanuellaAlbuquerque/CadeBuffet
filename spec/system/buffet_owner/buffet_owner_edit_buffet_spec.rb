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

  it 'com sucesso' do
    pix = PaymentMethod.create!(name: 'Pix')
    credit_card = PaymentMethod.create!(name: 'Cartão de Crédito')
    credit_card = PaymentMethod.create!(name: 'Cartão de Débito')
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
      address: 'Rua Diógenes Cassimiro do Nascimento, 867', 
      neighborhood: 'Remédios', 
      state: 'PB', 
      city: 'João Pessoa', 
      zipcode: '58062338', 
      description: 'O mais renomado serviço de buffet da região costeira.',
      buffet_owner: maicao
    )

    buffet.payment_methods = [pix, cash]

    login_as maicao, scope: :buffet_owner
    visit root_path
    click_on 'Editar'
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
    expect(page).to have_content 'Métodos de pagamento aceitos: Cartão de Crédito Cartão de Débito'
  end
end
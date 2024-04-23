require 'rails_helper'

describe 'Um usuário visitante não autenticado acessa a página inicial' do
  it 'e vê todos os buffets cadastrados' do

    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')

    fernando_tulipas = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

    caio_cozinha = BuffetOwner.create!(
      email: 'contato@caiocozinha.com', 
      password: 'caio123'
    )

    grenah_gastronomia = BuffetOwner.create!(
      email: 'contato@grenahgastronomia.com', 
      password: 'grenahgastronomia123'
    )

    tulipas_buffet = Buffet.create!(        
      trading_name: 'Buffet Tulipas - Villa Valentim', 
      company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
      registration_number: '12345678000123', 
      phone: '1129663900', 
      email: 'contato@buffettulipas.com.br', 
      address: 'Rua Valentim Magalhães, 293',
      neighborhood: 'Alto da Mooca',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '01234567',
      description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
      buffet_owner: fernando_tulipas,
      payment_methods: [pix]
    )

    caio_cozinha_buffet = Buffet.create!(        
      trading_name: 'Caio Cozinha & Eventos', 
      company_name: 'Caio Cozinha & Eventos Ltda.',
      registration_number: '92732949000102', 
      phone: '7723633113', 
      email: 'contato@caiocozinha.com', 
      address: 'Rua Comendador Bernardo Catarino, 89',
      neighborhood: 'Centro',
      state: 'BA', 
      city: 'Salvador', 
      zipcode: '12903834',
      description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
      buffet_owner: caio_cozinha,
      payment_methods: [pix]
    )

    grenah_buffet = Buffet.create!(        
      trading_name: 'Buffet Espaço Grenah | Gastronomia', 
      company_name: 'Buffet Espaço Grenah | Gastronomia Ltda.',
      registration_number: '00401207000178', 
      phone: '1430298587', 
      email: 'contato@grenahgastronomia.com', 
      address: 'Rua Azevedo Soares, 633',
      neighborhood: 'Jardim Anália Franco',
      state: 'SP', 
      city: 'Sorocaba', 
      zipcode: '03322000',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    visit root_path

    expect(page).to have_link 'Buffet Tulipas - Villa Valentim'
    expect(page).to have_content 'São Paulo - SP'
    expect(page).to have_link 'Caio Cozinha & Eventos'
    expect(page).to have_content 'Salvador - BA'
    expect(page).to have_link 'Buffet Espaço Grenah | Gastronomia'
    expect(page).to have_content 'Sorocaba - SP'
  end

  it 'e clica em um buffet específico' do

    pix = PaymentMethod.create!(name: 'Pix')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    cash = PaymentMethod.create!(name: 'Dinheiro')

    grenah_gastronomia = BuffetOwner.create!(
      email: 'contato@grenahgastronomia.com', 
      password: 'grenahgastronomia123'
    )

    grenah_buffet = Buffet.create!(        
      trading_name: 'Espaço Grenah | Gastronomia', 
      company_name: 'Espaço Grenah | Gastronomia Ltda.',
      registration_number: '00401207000178', 
      phone: '1430298587', 
      email: 'contato@grenahgastronomia.com', 
      address: 'Rua Azevedo Soares, 633',
      neighborhood: 'Jardim Anália Franco',
      state: 'SP', 
      city: 'Sorocaba', 
      zipcode: '03322000',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix, credit, cash]
    )

    visit root_path
    click_on 'Espaço Grenah | Gastronomia'
    
    expect(page).to have_content 'Detalhes do Buffet Espaço Grenah | Gastronomia'
    within('section#info') do
      expect(page.find('#buffet-image')['alt']).to have_content 'Imagem do Buffet Espaço Grenah | Gastronomia'
      expect(page).to have_content 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.'
      expect(page).to have_content 'cnpj da empresa: 00401207000178'
      within('section#payments') do
        expect(page).to have_content 'Formas de pagamento aceitas'
        expect(page).to have_content 'Pix'
        expect(page).to have_content 'Cartão de Crédito'
        expect(page).to have_content 'Dinheiro'
      end      
    end
    
    within('section#contact') do
      expect(page).to have_content 'Formas de Contato'
      expect(page).to have_content 'Telefone: 1430298587'
      expect(page).to have_content 'E-mail: contato@grenahgastronomia.com'
    end
    within('section#localization') do
      expect(page).to have_content 'Localização do Buffet'
      expect(page).to have_content 'Sorocaba - SP'
      expect(page).to have_content 'Rua Azevedo Soares, 633'
      expect(page).to have_content 'Bairro: Jardim Anália Franco'
      expect(page).to have_content 'CEP: 03322000'
    end
  end
end

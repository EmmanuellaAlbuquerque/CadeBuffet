require 'rails_helper'

describe 'Um usuário visitante não autenticado acessa a página inicial' do
  it 'e vê todos os buffets cadastrados' do

    pix = PaymentMethod.create!(name: 'Pix')
    ServiceOption.create!(name: 'Serviço de Valet')

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

    Buffet.create!(        
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
      zipcode: '12903834',
      description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
      buffet_owner: caio_cozinha,
      payment_methods: [pix]
    )

    Buffet.create!(        
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
    parking_service = ServiceOption.create!(name: 'Serviço de Estacionamento')
    drinking_service = ServiceOption.create!(name: 'Distribuição de Bebidas Alcoólicas') 
    
    fernando_tulipas = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

    Buffet.create!(        
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

    gala_event = Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: true,
      buffet: grenah_buffet
    )

    Event.create!(
      name: 'Evento Beneficente de Arrecadação de Fundos',
      description: 'Uma noite de glamour e generosidade, arrecadando fundos para uma causa importante.',
      qty_min: 100,
      qty_max: 500,
      duration: 180,
      menu: 'Prato Principal: Medalhões de filé mignon ao molho de vinho tinto. Acompanhamentos: Batatas gratinadas com queijo gruyère.',
      service_options: [parking_service, drinking_service],
      buffet: grenah_buffet
    )    

    BasePrice.create!(
      min_price: 4000,
      chosen_category_day: 'weekend',
      extra_price_per_person: 100,
      extra_price_per_duration: 150,
      event: gala_event
    )

    BasePrice.create!(
      min_price: 3500,
      chosen_category_day: 'weekdays',
      extra_price_per_person: 90,
      extra_price_per_duration: 130,
      event: gala_event
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
    within('section#events') do
      expect(page).to have_content 'Eventos disponíveis no Buffet'
      expect(page).to have_content 'Gala de Aniversário de 50 Anos'
      expect(page).to have_content 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa es...'
      expect(page).to have_content 'Quantidade mínima de pessoas: 50'
      expect(page).to have_content 'Quantidade máxima de pessoas: 200'
      expect(page).to have_content 'Duração do Evento: 120 (min)'

      expect(page).to have_content 'Evento Beneficente de Arrecadação de Fundos'
      expect(page).to have_content 'Uma noite de glamour e generosidade, arrecadando fundos para uma causa important...'
      expect(page).to have_content 'Quantidade mínima de pessoas: 100'
      expect(page).to have_content 'Quantidade máxima de pessoas: 500'
      expect(page).to have_content 'Duração do Evento: 180 (min)'
    end
  end

  it 'e clica em um evento específico do buffet específico' do

    pix = PaymentMethod.create!(name: 'Pix')    

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
      payment_methods: [pix]
    )

    gala_event = Event.create!(
      name: 'Gala de Aniversário de 50 Anos',
      description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
      qty_min: 50,
      qty_max: 200,
      duration: 120,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: true,
      buffet: grenah_buffet
    )   

    BasePrice.create!(
      min_price: 4000,
      chosen_category_day: 'weekend',
      extra_price_per_person: 100,
      extra_price_per_duration: 150,
      event: gala_event
    )

    BasePrice.create!(
      min_price: 3500,
      chosen_category_day: 'weekdays',
      extra_price_per_person: 90,
      extra_price_per_duration: 130,
      event: gala_event
    )    

    visit root_path
    click_on 'Espaço Grenah | Gastronomia'
    click_on 'Ver mais Detalhes'

    expect(page).to have_content 'Detalhes do Evento Gala de Aniversário de 50 Anos'
    expect(page).to have_content 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.'
    expect(page).to have_content 'Quantidade mínima de pessoas: 50'
    expect(page).to have_content 'Quantidade máxima de pessoas: 200'
    expect(page).to have_content 'Duração do Evento: 120 (min)'
    expect(page).to have_content 'Cardápio: Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.'
    expect(page).to have_content 'Localização do Evento: Exclusiva'

    expect(page).to have_content 'Durante a semana (De segunda a sexta-feira)'
    expect(page).to have_content 'Preço mínimo: R$ 3.500,00'
    expect(page).to have_content 'Taxa adicional por pessoa: R$ 90'
    expect(page).to have_content 'Taxa adicional por hora extra: R$ 130'

    expect(page).to have_content 'Durante o fim de semana (Sábado e Domingo)'
    expect(page).to have_content 'Preço mínimo: R$ 4.000,00'
    expect(page).to have_content 'Taxa adicional por pessoa: R$ 100'
    expect(page).to have_content 'Taxa adicional por hora extra: R$ 150'     
  end  
end

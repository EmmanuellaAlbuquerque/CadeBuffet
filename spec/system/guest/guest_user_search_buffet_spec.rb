require 'rails_helper'

describe 'Um usuário visitante não autenticado faz uma busca por Buffet' do
  it 'pelo nome fantasia' do

    pix = PaymentMethod.create!(name: 'Pix')

    fernando_tulipas = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

    caio_cozinha = BuffetOwner.create!(
      email: 'contato@caiocozinha.com', 
      password: 'caio123'
    )

    Buffet.create!(        
      trading_name: 'Buffet Tulipas - Villa Valentim', 
      company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
      registration_number: '12345678000123', 
      phone: '(83) 9 9834-0345', 
      email: 'contato@buffettulipas.com.br', 
      address: 'Rua Valentim Magalhães, 293',
      neighborhood: 'Alto da Mooca',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '06397-410',
      description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
      buffet_owner: fernando_tulipas,
      payment_methods: [pix]
    )

    Buffet.create!(        
      trading_name: 'Caio Cozinha & Eventos', 
      company_name: 'Caio Cozinha & Eventos Ltda.',
      registration_number: '92732949000102', 
      phone: '(83) 9 9834-0345', 
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

    visit root_path
    fill_in id: 'search_buffet_input', with: 'Caio Cozinha'
    click_on 'Pesquisar'
    
    expect(page).to have_content "Resultado da Pesquisa por: 'Caio Cozinha'"
    expect(page).to have_content "Foi encontrado 1 buffet"
    expect(page).to have_content "Caio Cozinha & Eventos"
    expect(page).to have_content "Salvador - BA"    
  end

  it 'pela cidade' do

    pix = PaymentMethod.create!(name: 'Pix')

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
      trading_name: 'Espaço Grenah | Gastronomia', 
      company_name: 'Espaço Grenah | Gastronomia Ltda.',
      registration_number: '00401207000178', 
      phone: '(83) 9 9834-0345', 
      email: 'contato@grenahgastronomia.com', 
      address: 'Rua Azevedo Soares, 633',
      neighborhood: 'Jardim Anália Franco',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '06386-095',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    Buffet.create!(        
      trading_name: 'Caio Cozinha & Eventos', 
      company_name: 'Caio Cozinha & Eventos Ltda.',
      registration_number: '92732949000102', 
      phone: '(83) 9 9834-0345', 
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
      trading_name: 'Buffet Tulipas - Villa Valentim', 
      company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
      registration_number: '12345678000123', 
      phone: '(83) 9 9834-0345', 
      email: 'contato@buffettulipas.com.br', 
      address: 'Rua Valentim Magalhães, 293',
      neighborhood: 'Alto da Mooca',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '06397-410',
      description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
      buffet_owner: fernando_tulipas,
      payment_methods: [pix]
    )

    visit root_path
    fill_in id: 'search_buffet_input', with: 'São Paulo'
    click_on 'Pesquisar'

    expect(page).to have_content "Resultado da Pesquisa por: 'São Paulo'"
    expect(page).to have_content "Foram encontrados 2 buffets"
    within('#buffets > div:nth-child(1)') do
      expect(page).to have_content "Buffet Tulipas - Villa Valentim"
      expect(page).to have_content "São Paulo - SP"
    end
    within('#buffets > div:nth-child(2)') do
      expect(page).to have_content "Espaço Grenah | Gastronomia"
      expect(page).to have_content "São Paulo - SP"
    end
  end  

  it 'pelos tipos de festas realizadas' do

    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')

    fernando_tulipas = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )

    grenah_gastronomia = BuffetOwner.create!(
      email: 'contato@grenahgastronomia.com', 
      password: 'grenahgastronomia123'
    )

    grenah_buffet = Buffet.create!(        
      trading_name: 'Espaço Grenah | Gastronomia', 
      company_name: 'Espaço Grenah | Gastronomia Ltda.',
      registration_number: '00401207000178', 
      phone: '(83) 9 9834-0345', 
      email: 'contato@grenahgastronomia.com', 
      address: 'Rua Azevedo Soares, 633',
      neighborhood: 'Jardim Anália Franco',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '06386-095',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    ) 

    tulipas_buffet = Buffet.create!(        
      trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
      company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
      registration_number: '12345678000123', 
      phone: '(83) 9 9834-0345', 
      email: 'contato@buffettulipas.com.br', 
      address: 'Rua Valentim Magalhães, 293',
      neighborhood: 'Alto da Mooca',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '06397-410',
      description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
      buffet_owner: fernando_tulipas,
      payment_methods: [pix]
    )    

    Event.create!(
      name: 'Festa de Formatura',
      description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
      qty_min: 50,
      qty_max: 250,
      duration: 240,
      menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
      exclusive_location: true,
      service_options: [valet_service],
      buffet: tulipas_buffet
    )
    
    Event.create!(
      name: 'Festa de Casamento',
      description: 'Um dia especial para celebrar o amor e a união.',
      qty_min: 50,
      qty_max: 250,
      duration: 240,
      menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
      service_options: [valet_service],
      buffet: tulipas_buffet
    ) 

    Event.create!(
      name: 'Festa de Casamento',
      description: 'Uma jornada mágica onde dois corações se unem para compartilhar amor, risos e promessas eternas. Venha celebrar conosco este momento único e inesquecível.',
      qty_min: 100,
      qty_max: 500,
      duration: 180,
      menu: 'Entradas: Seleção de canapés gourmet e camarões ao molho de limão siciliano. Prato Principal: Medalhões de filé mignon com molho de cogumelos selvagens. Acompanhamentos: Risoto de aspargos e batatas rústicas. Sobremesa: Degustação de mini sobremesas, incluindo macarons, cheesecake de frutas vermelhas e torta de chocolate belga.',
      service_options: [valet_service],
      buffet: grenah_buffet
    )

    visit root_path
    fill_in id: 'search_buffet_input', with: 'Festa de Casamento'
    click_on 'Pesquisar'
    
    expect(page).to have_content "Resultado da Pesquisa por: 'Festa de Casamento'"
    expect(page).to have_content "Foram encontrados 2 buffets"
    within('#buffets > div:nth-child(1)') do
      expect(page).to have_content "Espaço Grenah | Gastronomia"
      expect(page).to have_content "São Paulo - SP" 
    end
    within('#buffets > div:nth-child(2)') do      
      expect(page).to have_content "Tulipas Buffef | O melhor buffet da região Sudeste"
      expect(page).to have_content "São Paulo - SP"  
    end    
  end  

  it 'e não encontra nada' do

    pix = PaymentMethod.create!(name: 'Pix')

    grenah_gastronomia = BuffetOwner.create!(
      email: 'contato@grenahgastronomia.com', 
      password: 'grenahgastronomia123'
    )

    Buffet.create!(        
      trading_name: 'Espaço Grenah | Gastronomia', 
      company_name: 'Espaço Grenah | Gastronomia Ltda.',
      registration_number: '00401207000178', 
      phone: '(83) 9 9834-0345', 
      email: 'contato@grenahgastronomia.com', 
      address: 'Rua Azevedo Soares, 633',
      neighborhood: 'Jardim Anália Franco',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '06386-095',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    ) 

    visit root_path
    fill_in id: 'search_buffet_input', with: 'Espaço Miramar'
    click_on 'Pesquisar'
    
    expect(page).to have_content "Resultado da Pesquisa por: 'Espaço Miramar'"
    expect(page).to have_content "Nenhum Buffet encontrado!"      
  end
end

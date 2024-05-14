require 'rails_helper'

describe 'Buffets API' do
  context 'GET /api/v1/buffets' do
    it 'lista todos os buffets' do

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
        trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
        company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
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

      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]["trading_name"]).to eq 'Tulipas Buffef | O melhor buffet da região Sudeste'
      expect(json_response[1]["trading_name"]).to eq 'Caio Cozinha & Eventos'
    end

    it 'e não exibe buffets desativados' do

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
        trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
        company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
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
        payment_methods: [pix],
        status: :deactive
      )

      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 1
      expect(json_response[0]["trading_name"]).to eq 'Tulipas Buffef | O melhor buffet da região Sudeste'
      expect(json_response[1]).to eq nil
    end    

    it 'e retorna vazio se não existirem Buffets' do

      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 0
      expect(json_response).to eq []     
    end

    it 'e gera um erro interno' do
      allow(Buffet).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/buffets'

      expect(response).to have_http_status(500)
    end
  end

  context 'GET /api/v1/buffets/1' do
    it 'lista detalhes de um buffet específico' do
      pix = PaymentMethod.create!(name: 'Pix')
      credit_card = PaymentMethod.create!(name: 'Cartão de Crédito')
      debit_card = PaymentMethod.create!(name: 'Cartão de Débito')

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
      )
    
      Buffet.create!(        
        trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
        company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
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
        payment_methods: [pix, credit_card, debit_card]
      )

      get '/api/v1/buffets/1'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body)["trading_name"]).to eq 'Tulipas Buffef | O melhor buffet da região Sudeste'
      expect(JSON.parse(response.body)["company_name"]).to eq nil
      expect(JSON.parse(response.body)["registration_number"]).to eq nil
      expect(JSON.parse(response.body)["phone"]).to eq '1129663900'
      expect(JSON.parse(response.body)["email"]).to eq 'contato@buffettulipas.com.br'
      expect(JSON.parse(response.body)["address"]).to eq 'Rua Valentim Magalhães, 293'
      expect(JSON.parse(response.body)["neighborhood"]).to eq 'Alto da Mooca'
      expect(JSON.parse(response.body)["state"]).to eq 'SP'
      expect(JSON.parse(response.body)["city"]).to eq 'São Paulo'
      expect(JSON.parse(response.body)["zipcode"]).to eq '01234567'
      expect(JSON.parse(response.body)["description"]).to eq 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.'
      expect(JSON.parse(response.body)["buffet_owner_id"]).to eq 1
      expect(JSON.parse(response.body)["payment_methods"].length).to eq 3
      expect(JSON.parse(response.body)["payment_methods"][0]["name"]).to eq 'Pix'
      expect(JSON.parse(response.body)["payment_methods"][1]["name"]).to eq 'Cartão de Crédito'
      expect(JSON.parse(response.body)["payment_methods"][2]["name"]).to eq 'Cartão de Débito'
    end

    it 'e não é possível ver detalhes de um buffet desativado' do

      pix = PaymentMethod.create!(name: 'Pix')

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
        zipcode: '12903834',
        description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
        buffet_owner: caio_cozinha,
        payment_methods: [pix],
        status: :deactive
      )

      get '/api/v1/buffets/1'

      expect(response.status).to eq 404    
    end

    it 'falha se o buffet não for encontrado' do
      
      get "/api/v1/buffets/99999999"

      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/buffets?query=' do
    it 'lista Buffet por Filtro (Nome Fantasia)' do
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
        city: 'São Paulo', 
        zipcode: '03322000',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )

      Buffet.create!(        
        trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
        company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
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
      
      get '/api/v1/buffets', params: {query: 'Tulipas Buffef | O melhor buffet da região Sudeste'}

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body).length).to eq 1
      expect(JSON.parse(response.body).first["trading_name"]).to eq 'Tulipas Buffef | O melhor buffet da região Sudeste'    
    end

    it 'lista Buffet por Filtro (Cidade)' do
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
        trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
        company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
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
        city: 'São Paulo', 
        zipcode: '03322000',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )      

      get '/api/v1/buffets', params: {query: 'São Paulo'}

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body).length).to eq 2
      expect(JSON.parse(response.body).first["trading_name"]).to eq 'Buffet Espaço Grenah | Gastronomia'       
      expect(JSON.parse(response.body).second["trading_name"]).to eq 'Tulipas Buffef | O melhor buffet da região Sudeste'       
    end

    it 'lista Buffet por Filtro (Nome do Evento)' do
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

      tulipas_buffet = Buffet.create!(        
        trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
        company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
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

      grenah_buffet = Buffet.create!(        
        trading_name: 'Buffet Espaço Grenah | Gastronomia', 
        company_name: 'Buffet Espaço Grenah | Gastronomia Ltda.',
        registration_number: '00401207000178', 
        phone: '1430298587', 
        email: 'contato@grenahgastronomia.com', 
        address: 'Rua Azevedo Soares, 633',
        neighborhood: 'Jardim Anália Franco',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '03322000',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )

      Event.create!(
        name: 'Festa de Casamento',
        description: 'Um dia especial para celebrar o amor e a união.',
        qty_min: 50,
        qty_max: 250,
        duration: 240,
        menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
        buffet: tulipas_buffet
      )
      
      Event.create!(
        name: 'Festa de Formatura',
        description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
        qty_min: 50,
        qty_max: 100,
        duration: 180,
        menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        exclusive_location: true,
        buffet: tulipas_buffet
      )
      
      Event.create!(
        name: 'Festa de Casamento',
        description: 'Uma jornada mágica onde dois corações se unem para compartilhar amor, risos e promessas eternas. Venha celebrar conosco este momento único e inesquecível.',
        qty_min: 100,
        qty_max: 500,
        duration: 180,
        menu: 'Entradas: Seleção de canapés gourmet e camarões ao molho de limão siciliano. Prato Principal: Medalhões de filé mignon com molho de cogumelos selvagens. Acompanhamentos: Risoto de aspargos e batatas rústicas. Sobremesa: Degustação de mini sobremesas, incluindo macarons, cheesecake de frutas vermelhas e torta de chocolate belga.',
        buffet: grenah_buffet
      )      

      get '/api/v1/buffets', params: {query: 'Festa de Casamento'}

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body).length).to eq 2
      expect(JSON.parse(response.body).first["trading_name"]).to eq 'Buffet Espaço Grenah | Gastronomia'       
      expect(JSON.parse(response.body).second["trading_name"]).to eq 'Tulipas Buffef | O melhor buffet da região Sudeste'       
    end

    it 'e não é possível encontrar por pesquisa um buffet desativado' do
      pix = PaymentMethod.create!(name: 'Pix')

      caio_cozinha = BuffetOwner.create!(
        email: 'contato@caiocozinha.com', 
        password: 'caio123'
      )      
      
      Buffet.create!(        
        trading_name: 'Caio Buffet', 
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
        payment_methods: [pix],
        status: :deactive
      )

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
      )      

      Buffet.create!(        
        trading_name: 'Tulipas Buffet', 
        company_name: 'Tulipas Buffet | O melhor buffet da região Sudeste Ltda.',
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

      get '/api/v1/buffets', params: {query: 'Buffet'}

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body).length).to eq 1
      expect(JSON.parse(response.body)[0]["trading_name"]).to eq 'Tulipas Buffet'    
      expect(JSON.parse(response.body)[1]).to eq nil
    end
  end
end
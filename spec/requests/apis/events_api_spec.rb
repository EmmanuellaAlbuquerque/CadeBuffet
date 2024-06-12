require 'rails_helper'

describe 'Events API' do
  context 'GET /api/v1/buffets/1/events' do
    it 'lista todos os tipos de eventos do buffet' do
      pix = PaymentMethod.create!(name: 'Pix')

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
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
        zipcode: '06394-025',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: fernando_tulipas,
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
      
      get '/api/v1/buffets/1/events'
      
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body).length).to eq 2
      expect(JSON.parse(response.body).first["name"]).to eq 'Festa de Casamento'
      expect(JSON.parse(response.body).first["description"]).to eq 'Um dia especial para celebrar o amor e a união.'
      expect(JSON.parse(response.body).first["qty_max"]).to eq 250
      expect(JSON.parse(response.body).first["exclusive_location"]).to eq false
      expect(JSON.parse(response.body).second["name"]).to eq 'Festa de Formatura'
      expect(JSON.parse(response.body).second["description"]).to eq 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.'
      expect(JSON.parse(response.body).second["qty_max"]).to eq 100
      expect(JSON.parse(response.body).second["exclusive_location"]).to eq true
    end

    it 'e não deve ser listado um evento desativado' do
      pix = PaymentMethod.create!(name: 'Pix')

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
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
        buffet: tulipas_buffet,
        status: :deactive
      )
      
      get '/api/v1/buffets/1/events'
      
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body).length).to eq 1
      expect(JSON.parse(response.body)[0]["name"]).to eq 'Festa de Casamento'
      expect(JSON.parse(response.body)[1]).to eq nil
      expect(response.body).not_to include 'Festa de Formatura'
    end

    it 'e não deve ser possível ver eventos de um buffet desativado' do
      pix = PaymentMethod.create!(name: 'Pix')

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
      )
      
      Buffet.create!(        
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
        payment_methods: [pix],
        status: :deactive
      )
            
      get '/api/v1/buffets/1/events'
      
      expect(response.status).to eq 404     
    end

    it 'falha se o buffet não for encontrado' do
      
      get "/api/v1/buffets/99999999/events"

      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/events/:id/available' do
    it 'verifica disponibilidade para realização do evento e retorna o preço' do
      pix = PaymentMethod.create!(name: 'Pix')

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
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
      
      wedding_party = Event.create!(
        name: 'Festa de Casamento',
        description: 'Um dia especial para celebrar o amor e a união.',
        qty_min: 30,
        qty_max: 250,
        duration: 240,
        menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
        buffet: tulipas_buffet
      )

      BasePrice.create!(
        min_price: 14_000,
        chosen_category_day: 'weekend',
        extra_price_per_person: 100,
        extra_price_per_duration: 150,
        event: wedding_party
      )
      
      BasePrice.create!(
        min_price: 10_000,
        chosen_category_day: 'weekdays',
        extra_price_per_person: 90,
        extra_price_per_duration: 130,
        event: wedding_party
      )      
      
      get '/api/v1/events/1/available', 
        params: {
          "event_date": Date.today.next_occurring(:sunday),
          "qty_invited": 30
      }
      
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body)["status"]).to eq true
      expect(JSON.parse(response.body)["total_price"]).to eq 14_000
    end

    it 'verifica disponibilidade para realização do evento e retorna indisponibilidade' do
      pix = PaymentMethod.create!(name: 'Pix')

      manu = Client.create!(
        name: 'Manu',
        itin: '00189137096',
        email: 'manu@contato.com', 
        password: 'u!Qm926Kz8qupGTPh'
      )      

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
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
      
      wedding_party = Event.create!(
        name: 'Festa de Casamento',
        description: 'Um dia especial para celebrar o amor e a união.',
        qty_min: 30,
        qty_max: 250,
        duration: 240,
        menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
        buffet: tulipas_buffet
      )

      BasePrice.create!(
        min_price: 14_000,
        chosen_category_day: 'weekend',
        extra_price_per_person: 300,
        extra_price_per_duration: 1500,
        event: wedding_party
      )
      
      BasePrice.create!(
        min_price: 10_000,
        chosen_category_day: 'weekdays',
        extra_price_per_person: 250,
        extra_price_per_duration: 1000,
        event: wedding_party
      )

      Order.create!(
        event_date: Date.today.next_occurring(:sunday), 
        qty_invited: 50,
        event_details: '#1 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: tulipas_buffet,
        event: wedding_party,
        client: manu,
        status: :confirmed
      )      
      
      get '/api/v1/events/1/available', 
        params: {
          "event_date": Date.today.next_occurring(:sunday),
          "qty_invited": 50
      }
      
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body)["status"]).to eq false       
      expect(JSON.parse(response.body)["msg"]).to eq 'O evento não pode ser agendado para a data e horário solicitados no Buffet: Tulipas Buffef | O melhor buffet da região Sudeste. Por favor, escolha uma data e horário disponíveis.'
    end

    it 'falha se o dia do evento não for uma data' do
      pix = PaymentMethod.create!(name: 'Pix')    

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
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
        name: 'Festa de Casamento',
        description: 'Um dia especial para celebrar o amor e a união.',
        qty_min: 30,
        qty_max: 250,
        duration: 240,
        menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
        buffet: tulipas_buffet
      )

      get '/api/v1/events/1/available', 
        params: {
          "event_date": 'adfsadfk',
          "qty_invited": 50
      }
      
      expect(response.status).to eq 406
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body)["error"]).to eq 'a data informada é inválida'
    end

    it 'falha se a quantidade de convidados for maior que a capacidade suportada pelo Evento do Buffet' do
      pix = PaymentMethod.create!(name: 'Pix')    

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
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
        name: 'Festa de Casamento',
        description: 'Um dia especial para celebrar o amor e a união.',
        qty_min: 30,
        qty_max: 250,
        duration: 240,
        menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
        buffet: tulipas_buffet
      )

      get '/api/v1/events/1/available', 
        params: {
          "event_date": Date.today.next_occurring(:sunday),
          "qty_invited": 500
      }
      
      expect(response.status).to eq 406
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body)["error"]).to eq 'a quantidade de convidados é superior a quantidade limite suportada para o Evento'      
    end

    it 'falha se a data escolhida para realização do evento for antiga' do
      pix = PaymentMethod.create!(name: 'Pix')    

      fernando_tulipas = BuffetOwner.create!(
        email: 'contato@fernandotulipas.com', 
        password: 'fernandodastulipas123'
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
        name: 'Festa de Casamento',
        description: 'Um dia especial para celebrar o amor e a união.',
        qty_min: 30,
        qty_max: 250,
        duration: 240,
        menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
        buffet: tulipas_buffet
      )

      get '/api/v1/events/1/available', 
        params: {
          "event_date": Date.yesterday,
          "qty_invited": 100
      }
      
      expect(response.status).to eq 406
      expect(response.content_type).to include 'application/json'
      expect(JSON.parse(response.body)["error"]).to eq 'a data escolhida para realização do evento já passou!'      
    end
  end
end
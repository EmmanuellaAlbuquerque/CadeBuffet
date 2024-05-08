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
  end
end
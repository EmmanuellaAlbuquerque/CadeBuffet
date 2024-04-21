require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'O nome do evento é obrigatório' do

        pix = PaymentMethod.create!(name: 'Pix')
        valet_service = ServiceOption.create!(name: 'Serviço de Valet')
        decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')
    
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
    
        tulipas_buffet = Buffet.create!(        
        trading_name: 'Buffet Tulipas - Villa Valentim', 
        company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
        registration_number: '12345678000123', 
        phone: ' 1129663900', 
        email: 'contato@buffettulipas.com.br', 
        address: 'Rua Valentim Magalhães, 293',
        neighborhood: ' Alto da Mooca',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '01234567',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: buffet_owner,
        payment_methods: [pix])

        event = Event.new(
          name: '',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        event.valid?
        
        expect(event.errors.include? :name).to be true
        expect(event.errors[:name]).to include 'não pode ficar em branco'
      end

      it 'A descrição do evento é obrigatória' do

        pix = PaymentMethod.create!(name: 'Pix')
        valet_service = ServiceOption.create!(name: 'Serviço de Valet')
        decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')
    
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
    
        tulipas_buffet = Buffet.create!(        
        trading_name: 'Buffet Tulipas - Villa Valentim', 
        company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
        registration_number: '12345678000123', 
        phone: ' 1129663900', 
        email: 'contato@buffettulipas.com.br', 
        address: 'Rua Valentim Magalhães, 293',
        neighborhood: ' Alto da Mooca',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '01234567',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: buffet_owner,
        payment_methods: [pix])

        event = Event.new(
          name: 'Festa de formatura',
          description: '',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        event.valid?
        
        expect(event.errors.include? :description).to be true
        expect(event.errors[:description]).to include 'não pode ficar em branco'
      end
      
      it 'A quantidade mínima de pessoas que podem participar do evento é obrigatória' do

        pix = PaymentMethod.create!(name: 'Pix')
        valet_service = ServiceOption.create!(name: 'Serviço de Valet')
        decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')
    
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
    
        tulipas_buffet = Buffet.create!(        
        trading_name: 'Buffet Tulipas - Villa Valentim', 
        company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
        registration_number: '12345678000123', 
        phone: ' 1129663900', 
        email: 'contato@buffettulipas.com.br', 
        address: 'Rua Valentim Magalhães, 293',
        neighborhood: ' Alto da Mooca',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '01234567',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: buffet_owner,
        payment_methods: [pix])

        event = Event.new(
          name: 'Festa de formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: '',
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        event.valid?
        
        expect(event.errors.include? :qty_min).to be true
        expect(event.errors[:qty_min]).to include 'não pode ficar em branco'
      end  
      
      it 'A quantidade máxima de pessoas que podem participar do evento é obrigatória' do

        pix = PaymentMethod.create!(name: 'Pix')
        valet_service = ServiceOption.create!(name: 'Serviço de Valet')
        decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')
    
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
    
        tulipas_buffet = Buffet.create!(        
        trading_name: 'Buffet Tulipas - Villa Valentim', 
        company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
        registration_number: '12345678000123', 
        phone: ' 1129663900', 
        email: 'contato@buffettulipas.com.br', 
        address: 'Rua Valentim Magalhães, 293',
        neighborhood: ' Alto da Mooca',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '01234567',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: buffet_owner,
        payment_methods: [pix])

        event = Event.new(
          name: 'Festa de formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: '',
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        event.valid?
        
        expect(event.errors.include? :qty_max).to be true
        expect(event.errors[:qty_max]).to include 'não pode ficar em branco'
      end   
      
      it 'A duração padrão do evento é obrigatória' do

        pix = PaymentMethod.create!(name: 'Pix')
        valet_service = ServiceOption.create!(name: 'Serviço de Valet')
        decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')
    
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
    
        tulipas_buffet = Buffet.create!(        
        trading_name: 'Buffet Tulipas - Villa Valentim', 
        company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
        registration_number: '12345678000123', 
        phone: ' 1129663900', 
        email: 'contato@buffettulipas.com.br', 
        address: 'Rua Valentim Magalhães, 293',
        neighborhood: ' Alto da Mooca',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '01234567',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: buffet_owner,
        payment_methods: [pix])

        event = Event.new(
          name: 'Festa de formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: '',
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        event.valid?
        
        expect(event.errors.include? :duration).to be true
        expect(event.errors[:duration]).to include 'não pode ficar em branco'
      end 
      
      it 'O cardápio do evento é obrigatório' do

        pix = PaymentMethod.create!(name: 'Pix')
        valet_service = ServiceOption.create!(name: 'Serviço de Valet')
        decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')
    
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
    
        tulipas_buffet = Buffet.create!(        
        trading_name: 'Buffet Tulipas - Villa Valentim', 
        company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
        registration_number: '12345678000123', 
        phone: ' 1129663900', 
        email: 'contato@buffettulipas.com.br', 
        address: 'Rua Valentim Magalhães, 293',
        neighborhood: ' Alto da Mooca',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '01234567',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: buffet_owner,
        payment_methods: [pix])

        event = Event.new(
          name: 'Festa de formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: '',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        event.valid?
        
        expect(event.errors.include? :menu).to be true
        expect(event.errors[:menu]).to include 'não pode ficar em branco'
      end       
    end
    
    context 'numericality' do

      it 'A quantidade mínima de pessoas que podem participar do evento deve ser um número inteiro' do

        pix = PaymentMethod.create!(name: 'Pix')
        valet_service = ServiceOption.create!(name: 'Serviço de Valet')
        decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')
    
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
    
        tulipas_buffet = Buffet.create!(        
        trading_name: 'Buffet Tulipas - Villa Valentim', 
        company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
        registration_number: '12345678000123', 
        phone: ' 1129663900', 
        email: 'contato@buffettulipas.com.br', 
        address: 'Rua Valentim Magalhães, 293',
        neighborhood: ' Alto da Mooca',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '01234567',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: buffet_owner,
        payment_methods: [pix])

        event = Event.new(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50.5,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        event.valid?
        
        expect(event.errors.include? :qty_min).to be true
        expect(event.errors[:qty_min]).to include 'não é um número inteiro'
      end      

      it 'A quantidade máxima de pessoas que podem participar do evento deve ser um número inteiro' do

        pix = PaymentMethod.create!(name: 'Pix')
        valet_service = ServiceOption.create!(name: 'Serviço de Valet')
        decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')
    
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
    
        tulipas_buffet = Buffet.create!(        
        trading_name: 'Buffet Tulipas - Villa Valentim', 
        company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
        registration_number: '12345678000123', 
        phone: ' 1129663900', 
        email: 'contato@buffettulipas.com.br', 
        address: 'Rua Valentim Magalhães, 293',
        neighborhood: ' Alto da Mooca',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '01234567',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: buffet_owner,
        payment_methods: [pix])

        event = Event.new(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100.5,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          buffet: tulipas_buffet
        )

        event.valid?
        
        expect(event.errors.include? :qty_max).to be true
        expect(event.errors[:qty_max]).to include 'não é um número inteiro'
      end      
    end
  end  
end

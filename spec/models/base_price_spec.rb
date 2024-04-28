require 'rails_helper'

RSpec.describe BasePrice, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'O preço mínimo do evento é obrigatório' do

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

        event = Event.create!(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        base_price = BasePrice.new(
          min_price: '',
          chosen_category_day: 'weekend',
          extra_price_per_person: 100,
          extra_price_per_duration: 150,
          event: event
        )

        base_price.valid?
        
        expect(base_price.errors.include? :min_price).to be true
        expect(base_price.errors[:min_price]).to include 'não pode ficar em branco'        
      end

      it 'O período para realização do evento é obrigatório' do

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

        event = Event.create!(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: '',
          extra_price_per_person: 100,
          extra_price_per_duration: 150,
          event: event
        )

        base_price.valid?
        
        expect(base_price.errors.include? :chosen_category_day).to be true
        expect(base_price.errors[:chosen_category_day]).to include 'não pode ficar em branco'        
      end      

      it 'A taxa adicional por pessoa extra do evento é obrigatória' do

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

        event = Event.create!(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: '',
          extra_price_per_duration: 150,
          event: event
        )

        base_price.valid?
        
        expect(base_price.errors.include? :extra_price_per_person).to be true
        expect(base_price.errors[:extra_price_per_person]).to include 'não pode ficar em branco'             
      end   
      
      it 'A taxa adicional por hora extra do evento é obrigatória' do

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

        event = Event.create!(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: 100,
          extra_price_per_duration: '',
          event: event
        )

        base_price.valid?
        
        expect(base_price.errors.include? :extra_price_per_duration).to be true
        expect(base_price.errors[:extra_price_per_duration]).to include 'não pode ficar em branco'             
      end       
    end

    context 'numericality' do

      it 'O preço mínimo do evento deve ser um número' do

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

        event = Event.create!(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        base_price = BasePrice.new(
          min_price: '',
          chosen_category_day: 'weekend',
          extra_price_per_person: 100,
          extra_price_per_duration: 150,
          event: event
        )

        base_price.valid?
        
        expect(base_price.errors.include? :min_price).to be true
        expect(base_price.errors[:min_price]).to include 'não é um número'        
      end      

      it 'A taxa adicional por pessoa extra do evento deve ser um número' do

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

        event = Event.create!(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: '',
          extra_price_per_duration: 150,
          event: event
        )

        base_price.valid?
        
        expect(base_price.errors.include? :extra_price_per_person).to be true
        expect(base_price.errors[:extra_price_per_person]).to include 'não é um número'             
      end   
      
      it 'A taxa adicional por hora extra do evento deve ser um número' do

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

        event = Event.create!(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: 100,
          extra_price_per_duration: '',
          event: event
        )

        base_price.valid?
        
        expect(base_price.errors.include? :extra_price_per_duration).to be true
        expect(base_price.errors[:extra_price_per_duration]).to include 'não é um número'             
      end

      it 'O preço mínimo, a taxa adicional por pessoa e a taxa adicional por hora extra devem ser maiores que zero' do

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

        event = Event.create!(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
          exclusive_location: true,
          service_options: [valet_service, decoration_service],
          buffet: tulipas_buffet
        )

        base_price = BasePrice.new(
          min_price: -4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: -100,
          extra_price_per_duration: -200,
          event: event
        )

        base_price.valid?
        
        expect(base_price.errors.include? :min_price).to be true
        expect(base_price.errors[:min_price]).to include 'deve ser maior que 0'
        expect(base_price.errors.include? :extra_price_per_person).to be true
        expect(base_price.errors[:extra_price_per_person]).to include 'deve ser maior que 0'
        expect(base_price.errors.include? :extra_price_per_duration).to be true
        expect(base_price.errors[:extra_price_per_duration]).to include 'deve ser maior que 0'            
      end      
    end
  end
end

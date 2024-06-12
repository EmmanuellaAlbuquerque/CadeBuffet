require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'A Data do Evento não pode ficar em branco' do
    
        birthday_event_order = Order.new(
          event_date: '', 
          qty_invited: 50, 
          event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
          event_address: 'Rua Biboca Diagonal, 934',
        )

        birthday_event_order.valid?

        expect(birthday_event_order.errors.include? :event_date).to be true
        expect(birthday_event_order.errors[:event_date]).to include 'não pode ficar em branco'
      end


      it 'A quantidade estimada de convidados não pode ficar em branco' do
    
        birthday_event_order = Order.new(
          event_date: 1.week.from_now, 
          qty_invited: '', 
          event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
          event_address: 'Rua Biboca Diagonal, 934',
        )

        birthday_event_order.valid?

        expect(birthday_event_order.errors.include? :qty_invited).to be true
        expect(birthday_event_order.errors[:qty_invited]).to include 'não pode ficar em branco'
      end      
    end

    context 'A data do Evento é futura' do
      it 'a Data do Evento deve não deve ser passada' do
        order = Order.new(event_date: 1.week.ago)
  
        order.valid?
  
        expect(order.errors.include? :event_date).to be true
        expect(order.errors[:event_date]).to include 'deve ser futura.'
      end
  
      it 'a Data do Evento não deve ser igual a hoje' do
        order = Order.new(event_date: Date.today)
  
        order.valid?
  
        expect(order.errors.include? :event_date).to be true
        expect(order.errors[:event_date]).to include 'deve ser futura.'
      end
  
      it 'a Data do Evento deve ser igual ou maior do que amanhã' do
        order = Order.new(event_date: 1.day.from_now)
  
        order.valid?
        
        expect(order.errors.include? :event_date).to be false
      end      
    end

    context 'Gera um código aleatório' do
      
      it 'ao criar um novo pedido' do
        pix = PaymentMethod.create!(name: 'Pix')

        manu = Client.create!(
          name: 'Manu',
          itin: '00189137096',
          email: 'manu@contato.com', 
          password: 'u!Qm926Kz8qupGTPh'
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
          zipcode: '06386-095',
          description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
          buffet_owner: grenah_gastronomia,
          payment_methods: [pix]
        )
    
        birthday_event = Event.create!(
          name: 'Festa de Aniversário',
          description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
          qty_min: 50,
          qty_max: 200,
          duration: 120,
          menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
          exclusive_location: false,
          buffet: grenah_buffet
        )
    
        birthday_event_order = Order.create!(
          event_date: 1.week.from_now, 
          qty_invited: 50, 
          event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
          event_address: 'Rua Biboca Diagonal, 934',
          buffet: grenah_buffet,
          event: birthday_event,
          client: manu
        )
        
        result = birthday_event_order.code

        expect(result).not_to be_empty
        expect(result.length).to eq 8
      end

      it 'e o código deve ser único' do
        pix = PaymentMethod.create!(name: 'Pix')

        manu = Client.create!(
          name: 'Manu',
          itin: '00189137096',
          email: 'manu@contato.com', 
          password: 'u!Qm926Kz8qupGTPh'
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
          zipcode: '06386-095',
          description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
          buffet_owner: grenah_gastronomia,
          payment_methods: [pix]
        )
    
        birthday_event = Event.create!(
          name: 'Festa de Aniversário',
          description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
          qty_min: 50,
          qty_max: 200,
          duration: 120,
          menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
          exclusive_location: false,
          buffet: grenah_buffet
        )
    
        first_order = Order.create!(
          event_date: 1.week.from_now, 
          qty_invited: 50, 
          event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
          event_address: 'Rua Biboca Diagonal, 934',
          buffet: grenah_buffet,
          event: birthday_event,
          client: manu
        )

        second_order = Order.new(
          event_date: 3.week.from_now, 
          qty_invited: 100, 
          buffet: grenah_buffet,
          event: birthday_event,
          client: manu
        )

        second_order.save!

        expect(second_order.code).not_to eq first_order.code
      end

      it 'e não deve ser modificado' do
        pix = PaymentMethod.create!(name: 'Pix')

        manu = Client.create!(
          name: 'Manu',
          itin: '00189137096',
          email: 'manu@contato.com', 
          password: 'u!Qm926Kz8qupGTPh'
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
          zipcode: '06386-095',
          description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
          buffet_owner: grenah_gastronomia,
          payment_methods: [pix]
        )
    
        birthday_event = Event.create!(
          name: 'Festa de Aniversário',
          description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
          qty_min: 50,
          qty_max: 200,
          duration: 120,
          menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
          exclusive_location: false,
          buffet: grenah_buffet
        )
    
        birthday_event_order = Order.create!(
          event_date: 1.week.from_now, 
          qty_invited: 50, 
          event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
          event_address: 'Rua Biboca Diagonal, 934',
          buffet: grenah_buffet,
          event: birthday_event,
          client: manu
        )

        original_code = birthday_event_order.code

        birthday_event_order.update!(event_date: 1.month.from_now)

        expect(birthday_event_order.code).to eq original_code
      end
    end
  end
end

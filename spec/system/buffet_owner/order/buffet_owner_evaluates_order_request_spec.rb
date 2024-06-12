require 'rails_helper'

describe 'Dono de Buffet avalia pedido' do
  it 'e deve estar autenticado' do

    visit root_path

    expect(page).not_to have_link 'Pedidos'
  end

  it 'a partir da tela inicial' do

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
      client: manu,
      status: :canceled
    )

    second_order = Order.create!(
      event_date: 1.month.from_now, 
      qty_invited: 60, 
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: birthday_event,
      client: manu,
    )
    
    login_as grenah_gastronomia, scope: :buffet_owner

    visit root_path
    click_on 'Pedidos'

    within('#orders > div:nth-child(1)') do
      expect(page).to have_content 'Pedidos Pendentes'
      expect(page).to have_content "Pedido ##{second_order.code} - Aguardando avaliação do buffet"
    end
    
    within('#orders > div:nth-child(2)') do
    expect(page).to have_content 'Demais Pedidos'
    expect(page).to have_content "Pedido ##{first_order.code} - Pedido Cancelado"
    end    
  end

  context 'ao clicar em um pedido específico' do
    it 'e deve ver os detalhes do mesmo e uma mensagem de aviso sobre os pedidos confirmados na mesma data' do

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
  
      past_request_order = Order.create!(
        event_date: 1.week.from_now, 
        qty_invited: 100, 
        buffet: grenah_buffet,
        event: birthday_event,
        client: manu,
        status: :confirmed
      )
  
      past_past_request_order = Order.create!(
        event_date: 1.week.from_now, 
        qty_invited: 50, 
        event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: birthday_event,
        client: manu,
        status: :confirmed
      )
  
      canceled_order = Order.create!(
        event_date: 1.week.from_now, 
        qty_invited: 50, 
        event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: birthday_event,
        client: manu,
        status: :canceled
      )
  
      birthday_event_order = Order.create!(
        event_date: 1.week.from_now, 
        qty_invited: 50, 
        event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: birthday_event,
        client: manu,
      )
      
      login_as grenah_gastronomia, scope: :buffet_owner
  
      visit root_path
      click_on 'Pedidos'
      click_on "##{birthday_event_order.code}"
  
      expect(page).to have_content "Data do Evento: #{I18n.l(1.week.from_now.to_date)}" 
      expect(page).to have_content "Quantidade estimada de convidados: 50" 
      expect(page).to have_content "Detalhes do Evento: Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas." 
      expect(page).to have_content "Endereço: Rua Biboca Diagonal, 934" 
      expect(page).to have_content "Você possui um evento confirmado para essa data (#{I18n.l(1.week.from_now.to_date)}): ##{past_request_order.code} ##{past_past_request_order.code} !"
      expect(page).not_to have_link "##{canceled_order.code}"
    end

    context "e quando o pedido é o único na mesma data" do
      it 'não deve exibir uma mensagem de aviso' do
        
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
    
        Order.create!(
          event_date: 1.week.from_now, 
          qty_invited: 100, 
          buffet: grenah_buffet,
          event: birthday_event,
          client: manu,
          status: :confirmed
        )
    
        birthday_event_order = Order.create!(
          event_date: 2.week.from_now, 
          qty_invited: 50, 
          event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
          event_address: 'Rua Biboca Diagonal, 934',
          buffet: grenah_buffet,
          event: birthday_event,
          client: manu,
        )
        
        login_as grenah_gastronomia, scope: :buffet_owner
    
        visit root_path
        click_on 'Pedidos'
        click_on "##{birthday_event_order.code}"
    
        expect(page).not_to have_content "Você possui um evento confirmado para essa data (#{I18n.l(2.week.from_now.to_date)}): ##{birthday_event_order.code}!" 
      end
    end
  end
end

require 'rails_helper'

describe 'Dono de Buffet aprova um pedido' do

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
      zipcode: '03322000',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    wedding_party_event = Event.create!(
      name: 'Festa de Casamento',
      description: 'Uma ocasião de elegância e celebração com todos os familiares e amigos.',
      qty_min: 30,
      qty_max: 100,
      duration: 240,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: false,
      buffet: grenah_buffet
    )

    BasePrice.create!(
      min_price: 10_000,
      chosen_category_day: 'weekdays',
      extra_price_per_person: 250,
      extra_price_per_duration: 1000,
      event: wedding_party_event
    )

    wedding_party_event_order = Order.create!(
      event_date: Date.today.next_occurring(:wednesday), 
      qty_invited: 30,
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: wedding_party_event,
      client: manu,
    )
    
    login_as grenah_gastronomia, scope: :buffet_owner

    visit root_path
    click_on 'Pedidos'
    click_on "##{wedding_party_event_order.code}"

    expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados): R$ 10.000'
    expect(page).to have_field 'Taxa extra (se aplicável)'
    expect(page).to have_field 'Desconto (se aplicável)'
    expect(page).to have_field 'Descrição (opcional)'
    expect(page).to have_field 'Data de validade do valor'
    expect(page).to have_field 'Forma de Pagamento'
  end

  it 'com sucesso' do
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
      zipcode: '03322000',
      description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
      buffet_owner: grenah_gastronomia,
      payment_methods: [pix]
    )

    wedding_party_event = Event.create!(
      name: 'Festa de Casamento',
      description: 'Uma ocasião de elegância e celebração com todos os familiares e amigos.',
      qty_min: 30,
      qty_max: 100,
      duration: 240,
      menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
      exclusive_location: false,
      buffet: grenah_buffet
    )

    BasePrice.create!(
      min_price: 10_000,
      chosen_category_day: 'weekdays',
      extra_price_per_person: 250,
      extra_price_per_duration: 1000,
      event: wedding_party_event
    )

    BasePrice.create!(
      min_price: 14_000,
      chosen_category_day: 'weekend',
      extra_price_per_person: 300,
      extra_price_per_duration: 1500,
      event: wedding_party_event
    )  

    wedding_party_event_order = Order.create!(
      event_date: Date.today.next_occurring(:wednesday), 
      qty_invited: 20,
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: wedding_party_event,
      client: manu,
    )
    
    login_as grenah_gastronomia, scope: :buffet_owner

    visit root_path
    click_on 'Pedidos'
    click_on "##{wedding_party_event_order.code}"

    fill_in 'Taxa extra (se aplicável)', with: 0
    fill_in 'Desconto (se aplicável)', with: 1000
    fill_in 'Descrição (opcional)', with: '10% de desconto para pagamento via Pix'
    fill_in 'Data de validade do valor', with: 1.week.from_now
    select 'Pix', from: 'Forma de Pagamento'
    click_on 'Aprovar Pedido'

    expect(page).to have_content 'Cálculo do Valor Final do Pedido'
    expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados): R$ 10.000,00'
    expect(page).to have_content '+ Taxa Extra: R$ 0,00'
    expect(page).to have_content '- Desconto: R$ 1.000,00'
    expect(page).to have_content 'Valor final do pedido: R$ 9.000,00'
    expect(page).to have_content 'Descrição: 10% de desconto para pagamento via Pix'
    expect(page).to have_content "Data de validade do valor: #{I18n.l(1.week.from_now.to_date)}"
    expect(page).to have_content 'Forma de Pagamento: Pix'
    expect(page).to have_content 'Status: Aguardando confirmação do cliente'
    expect(page).not_to have_button 'Confirmar Pedido'
    expect(page).not_to have_button 'Cancelar Pedido'      
  end

  context 'para um evento a ser realizado durante a semana' do
    it 'com 20 convidados do mínimo de 30 do evento' do
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
        zipcode: '03322000',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )
  
      wedding_party_event = Event.create!(
        name: 'Festa de Casamento',
        description: 'Uma ocasião de elegância e celebração com todos os familiares e amigos.',
        qty_min: 30,
        qty_max: 100,
        duration: 240,
        menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
        exclusive_location: false,
        buffet: grenah_buffet
      )
  
      BasePrice.create!(
        min_price: 10_000,
        chosen_category_day: 'weekdays',
        extra_price_per_person: 250,
        extra_price_per_duration: 1000,
        event: wedding_party_event
      )
  
      BasePrice.create!(
        min_price: 14_000,
        chosen_category_day: 'weekend',
        extra_price_per_person: 300,
        extra_price_per_duration: 1500,
        event: wedding_party_event
      )  
  
      wedding_party_event_order = Order.create!(
        event_date: Date.today.next_occurring(:wednesday), 
        qty_invited: 20,
        event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: wedding_party_event,
        client: manu,
      )
      
      login_as grenah_gastronomia, scope: :buffet_owner
  
      visit root_path
      click_on 'Pedidos'
      click_on "##{wedding_party_event_order.code}"
  
      fill_in 'Data de validade do valor', with: 1.week.from_now
      select 'Pix', from: 'Forma de Pagamento'
      click_on 'Aprovar Pedido'

      expect(page).to have_content 'Cálculo do Valor Final do Pedido'
      expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados): R$ 10.000,00'
      expect(page).to have_content '+ Taxa Extra: R$ 0,00'
      expect(page).to have_content '- Desconto: R$ 0,00'
      expect(page).to have_content 'Valor final do pedido: R$ 10.000,00'
      expect(page).to have_content "Data de validade do valor: #{I18n.l(1.week.from_now.to_date)}"
      expect(page).to have_content 'Forma de Pagamento: Pix'
    end

    it 'com a quantidade mínima de convidados' do
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
        zipcode: '03322000',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )
  
      wedding_party_event = Event.create!(
        name: 'Festa de Casamento',
        description: 'Uma ocasião de elegância e celebração com todos os familiares e amigos.',
        qty_min: 30,
        qty_max: 100,
        duration: 240,
        menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
        exclusive_location: false,
        buffet: grenah_buffet
      )
  
      BasePrice.create!(
        min_price: 10_000,
        chosen_category_day: 'weekdays',
        extra_price_per_person: 250,
        extra_price_per_duration: 1000,
        event: wedding_party_event
      )
  
      BasePrice.create!(
        min_price: 14_000,
        chosen_category_day: 'weekend',
        extra_price_per_person: 300,
        extra_price_per_duration: 1500,
        event: wedding_party_event
      )  
  
      wedding_party_event_order = Order.create!(
        event_date: Date.today.next_occurring(:wednesday), 
        qty_invited: 30,
        event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: wedding_party_event,
        client: manu,
      )
      
      login_as grenah_gastronomia, scope: :buffet_owner
  
      visit root_path
      click_on 'Pedidos'
      click_on "##{wedding_party_event_order.code}"
  
      fill_in 'Data de validade do valor', with: 1.week.from_now
      select 'Pix', from: 'Forma de Pagamento'
      click_on 'Aprovar Pedido'

      expect(page).to have_content 'Cálculo do Valor Final do Pedido'
      expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados): R$ 10.000,00'
      expect(page).to have_content '+ Taxa Extra: R$ 0,00'
      expect(page).to have_content '- Desconto: R$ 0,00'
      expect(page).to have_content 'Valor final do pedido: R$ 10.000,00'
      expect(page).to have_content "Data de validade do valor: #{I18n.l(1.week.from_now.to_date)}"
      expect(page).to have_content 'Forma de Pagamento: Pix'
    end

    it 'com 50 convidados do mínimo de 30 do evento' do
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
        zipcode: '03322000',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )
  
      wedding_party_event = Event.create!(
        name: 'Festa de Casamento',
        description: 'Uma ocasião de elegância e celebração com todos os familiares e amigos.',
        qty_min: 30,
        qty_max: 100,
        duration: 240,
        menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
        exclusive_location: false,
        buffet: grenah_buffet
      )
  
      BasePrice.create!(
        min_price: 10_000,
        chosen_category_day: 'weekdays',
        extra_price_per_person: 250,
        extra_price_per_duration: 1000,
        event: wedding_party_event
      )
  
      BasePrice.create!(
        min_price: 14_000,
        chosen_category_day: 'weekend',
        extra_price_per_person: 300,
        extra_price_per_duration: 1500,
        event: wedding_party_event
      )  
  
      wedding_party_event_order = Order.create!(
        event_date: Date.today.next_occurring(:wednesday), 
        qty_invited: 50,
        event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: wedding_party_event,
        client: manu,
      )
      
      login_as grenah_gastronomia, scope: :buffet_owner
  
      visit root_path
      click_on 'Pedidos'
      click_on "##{wedding_party_event_order.code}"
  
      fill_in 'Data de validade do valor', with: 1.week.from_now
      select 'Pix', from: 'Forma de Pagamento'
      click_on 'Aprovar Pedido'

      expect(page).to have_content 'Cálculo do Valor Final do Pedido'
      expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados)'
      expect(page).to have_content 'Preço Padrão: R$ 15.000,00'
      expect(page).to have_content '+ Taxa Extra: R$ 0,00'
      expect(page).to have_content '- Desconto: R$ 0,00'
      expect(page).to have_content 'Valor final do pedido: R$ 15.000,00'
      expect(page).to have_content "Data de validade do valor: #{I18n.l(1.week.from_now.to_date)}"
      expect(page).to have_content 'Forma de Pagamento: Pix'
    end       
  end

  context 'para um evento a ser realizado durante o final de semana' do
    it 'com 20 convidados do mínimo de 30 do evento' do
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
        zipcode: '03322000',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )
  
      wedding_party_event = Event.create!(
        name: 'Festa de Casamento',
        description: 'Uma ocasião de elegância e celebração com todos os familiares e amigos.',
        qty_min: 30,
        qty_max: 100,
        duration: 240,
        menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
        exclusive_location: false,
        buffet: grenah_buffet
      )
  
      BasePrice.create!(
        min_price: 10_000,
        chosen_category_day: 'weekdays',
        extra_price_per_person: 250,
        extra_price_per_duration: 1000,
        event: wedding_party_event
      )
  
      BasePrice.create!(
        min_price: 14_000,
        chosen_category_day: 'weekend',
        extra_price_per_person: 300,
        extra_price_per_duration: 1500,
        event: wedding_party_event
      )  
  
      wedding_party_event_order = Order.create!(
        event_date: Date.today.next_occurring(:sunday), 
        qty_invited: 20,
        event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: wedding_party_event,
        client: manu,
      )
      
      login_as grenah_gastronomia, scope: :buffet_owner
  
      visit root_path
      click_on 'Pedidos'
      click_on "##{wedding_party_event_order.code}"
  
      fill_in 'Data de validade do valor', with: 1.week.from_now
      select 'Pix', from: 'Forma de Pagamento'
      click_on 'Aprovar Pedido'

      expect(page).to have_content 'Cálculo do Valor Final do Pedido'
      expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados): R$ 14.000,00'
      expect(page).to have_content '+ Taxa Extra: R$ 0,00'
      expect(page).to have_content '- Desconto: R$ 0,00'
      expect(page).to have_content 'Valor final do pedido: R$ 14.000,00'
      expect(page).to have_content "Data de validade do valor: #{I18n.l(1.week.from_now.to_date)}"
      expect(page).to have_content 'Forma de Pagamento: Pix'
    end

    it 'com a quantidade mínima de convidados' do
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
        zipcode: '03322000',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )
  
      wedding_party_event = Event.create!(
        name: 'Festa de Casamento',
        description: 'Uma ocasião de elegância e celebração com todos os familiares e amigos.',
        qty_min: 30,
        qty_max: 100,
        duration: 240,
        menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
        exclusive_location: false,
        buffet: grenah_buffet
      )
  
      BasePrice.create!(
        min_price: 10_000,
        chosen_category_day: 'weekdays',
        extra_price_per_person: 250,
        extra_price_per_duration: 1000,
        event: wedding_party_event
      )
  
      BasePrice.create!(
        min_price: 14_000,
        chosen_category_day: 'weekend',
        extra_price_per_person: 300,
        extra_price_per_duration: 1500,
        event: wedding_party_event
      )  
  
      wedding_party_event_order = Order.create!(
        event_date: Date.today.next_occurring(:sunday), 
        qty_invited: 30,
        event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: wedding_party_event,
        client: manu,
      )
      
      login_as grenah_gastronomia, scope: :buffet_owner
  
      visit root_path
      click_on 'Pedidos'
      click_on "##{wedding_party_event_order.code}"
  
      fill_in 'Data de validade do valor', with: 1.week.from_now
      select 'Pix', from: 'Forma de Pagamento'
      click_on 'Aprovar Pedido'

      expect(page).to have_content 'Cálculo do Valor Final do Pedido'
      expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados): R$ 14.000,00'
      expect(page).to have_content '+ Taxa Extra: R$ 0,00'
      expect(page).to have_content '- Desconto: R$ 0,00'
      expect(page).to have_content 'Valor final do pedido: R$ 14.000,00'
      expect(page).to have_content "Data de validade do valor: #{I18n.l(1.week.from_now.to_date)}"
      expect(page).to have_content 'Forma de Pagamento: Pix'
    end

    it 'com 50 convidados do mínimo de 30 do evento' do
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
        zipcode: '03322000',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )
  
      wedding_party_event = Event.create!(
        name: 'Festa de Casamento',
        description: 'Uma ocasião de elegância e celebração com todos os familiares e amigos.',
        qty_min: 30,
        qty_max: 100,
        duration: 240,
        menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
        exclusive_location: false,
        buffet: grenah_buffet
      )
  
      BasePrice.create!(
        min_price: 10_000,
        chosen_category_day: 'weekdays',
        extra_price_per_person: 250,
        extra_price_per_duration: 1000,
        event: wedding_party_event
      )
  
      BasePrice.create!(
        min_price: 14_000,
        chosen_category_day: 'weekend',
        extra_price_per_person: 300,
        extra_price_per_duration: 1500,
        event: wedding_party_event
      )  
  
      wedding_party_event_order = Order.create!(
        event_date: Date.today.next_occurring(:sunday), 
        qty_invited: 50,
        event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: grenah_buffet,
        event: wedding_party_event,
        client: manu,
      )
      
      login_as grenah_gastronomia, scope: :buffet_owner
  
      visit root_path
      click_on 'Pedidos'
      click_on "##{wedding_party_event_order.code}"
  
      fill_in 'Data de validade do valor', with: 1.week.from_now
      select 'Pix', from: 'Forma de Pagamento'
      click_on 'Aprovar Pedido'

      expect(page).to have_content 'Cálculo do Valor Final do Pedido'
      expect(page).to have_content 'Cálculo automático (baseado no preço base e na quantidade de convidados): R$ 20.000,00'
      expect(page).to have_content '+ Taxa Extra: R$ 0,00'
      expect(page).to have_content '- Desconto: R$ 0,00'
      expect(page).to have_content 'Valor final do pedido: R$ 20.000,00'
      expect(page).to have_content "Data de validade do valor: #{I18n.l(1.week.from_now.to_date)}"
      expect(page).to have_content 'Forma de Pagamento: Pix'
    end
  end
end

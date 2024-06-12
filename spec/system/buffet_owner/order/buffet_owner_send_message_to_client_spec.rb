require 'rails_helper'

describe 'Dono de Buffet envia uma mensagem para o Cliente' do
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
      phone: '(83) 9 9834-0345', 
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

    chat = Chat.create!(
      order: birthday_event_order
    )

    login_as grenah_gastronomia, scope: :buffet_owner

    visit root_path
    click_on 'Pedidos'
    click_on "##{birthday_event_order.code}"
    fill_in 'message[content]', with: 'Olá, bom dia. Gostaria de saber mais detalhes sobre a decoração temática da festa, se há alguma restrição alimentar por parte dos seus convidados ou preferências culinárias específicas. Além disso, qual seria a forma de pagamento desejada?'
    click_on 'Enviar mensagem'

    expect(page).to have_content "#{I18n.l(chat.messages.first.created_at.to_date)}"
    expect(page).to have_content 'Dono do Buffet (Espaço Grenah | Gastronomia): Olá, bom dia. Gostaria de saber mais detalhes sobre a decoração temática da festa, se há alguma restrição alimentar por parte dos seus convidados ou preferências culinárias específicas. Além disso, qual seria a forma de pagamento desejada?'
    expect(page).to have_content "#{chat.created_at.in_time_zone(I18n.t('time_zone')).strftime("%H:%M")}"
  end

  it 'e o Cliente responde' do

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
      phone: '(83) 9 9834-0345', 
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

    chat = Chat.create!(
      order: birthday_event_order
    )

    owner_message = Message.create!(
      chat: chat,
      sender: grenah_gastronomia,
      content: 'Olá, bom dia. Gostaria de saber mais detalhes sobre a decoração temática da festa, se há alguma restrição alimentar por parte dos seus convidados ou preferências culinárias específicas. Além disso, qual seria a forma de pagamento desejada?'
    )

    login_as manu, scope: :client

    visit root_path
    click_on 'Meus Pedidos'
    click_on "##{birthday_event_order.code}"
    fill_in 'message[content]', with: 'Olaaa, sobre a decoração, pode incluir mesas decoradas com toalhas longas, candelabros flutuantes e banners das quatro casas de Hogwarts (Gryffindor, Slytherin, Ravenclaw e Hufflepuff) pendurados nas paredes. Sobre o pagamento, gostaria que fosse via Pix.'
    click_on 'Enviar mensagem'

    expect(page).to have_css("#chat .message", count: 2)

    within('#chat:nth-child(1)') do
      expect(page).to have_content 'Chat'
    end
    
    within('#chat > .message:nth-child(2)') do
      expect(page).to have_content "#{I18n.l(owner_message.created_at.to_date)}"
      expect(page).to have_content 'Dono do Buffet (Espaço Grenah | Gastronomia): Olá, bom dia. Gostaria de saber mais detalhes sobre a decoração temática da festa, se há alguma restrição alimentar por parte dos seus convidados ou preferências culinárias específicas. Além disso, qual seria a forma de pagamento desejada?'
      expect(page).to have_content "#{owner_message.created_at.in_time_zone(I18n.t('time_zone')).strftime("%H:%M")}"
    end

    within('#chat > .message:nth-child(3)') do
      expect(page).to have_content "#{I18n.l(chat.messages.second.created_at.to_date)}"
      expect(page).to have_content 'Manu: Olaaa, sobre a decoração, pode incluir mesas decoradas com toalhas longas, candelabros flutuantes e banners das quatro casas de Hogwarts (Gryffindor, Slytherin, Ravenclaw e Hufflepuff) pendurados nas paredes. Sobre o pagamento, gostaria que fosse via Pix.'
      expect(page).to have_content "#{chat.messages.second.created_at.in_time_zone(I18n.t('time_zone')).strftime("%H:%M")}"
    end
  end
end

require 'rails_helper'

describe 'Cliente vê seu próprios pedidos' do
  it 'e deve estar autenticado' do

    visit root_path

    expect(page).not_to have_link 'Meus Pedidos'
  end

  it 'sem ter feito nenhum' do

    manu = Client.create!(
      name: 'Manu',
      itin: '00189137096',
      email: 'manu@contato.com', 
      password: 'u!Qm926Kz8qupGTPh'
    )

    login_as manu

    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content 'Nenhum pedido realizado!'
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

    graduation_event = Event.create!(
      name: 'Festa de Formatura',
      description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
      qty_min: 50,
      qty_max: 100,
      duration: 180,
      menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
      exclusive_location: true,
      buffet: grenah_buffet,
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

    graduation_event_order = Order.create!(
      event_date: 1.week.from_now, 
      qty_invited: 50,
      buffet: grenah_buffet,
      event: graduation_event,
      client: manu
    )

    login_as manu

    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content 'Meus Pedidos'
    expect(page).to have_content "Evento ##{birthday_event_order.code} - #{I18n.l(birthday_event_order.event_date)}"
    expect(page).to have_content "Evento ##{graduation_event_order.code} - #{I18n.l(birthday_event_order.event_date)}"
  end

  it 'e visita um pedido' do

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

    other_order = Order.create!(
      event_date: 1.week.from_now, 
      qty_invited: 50, 
      event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: grenah_buffet,
      event: birthday_event,
      client: manu,
      status: :confirmed
    )

    login_as manu

    visit root_path
    click_on 'Meus Pedidos'
    click_on "##{birthday_event_order.code}"

    expect(page).to have_content "Detalhes do Pedido ##{birthday_event_order.code}"
    expect(page).to have_content 'Serviço oferecido pelo Buffet: Espaço Grenah | Gastronomia'
    expect(page).to have_content 'Tipo de Evento: Festa de Aniversário'
    expect(page).to have_content "Data do Evento: #{I18n.l(1.week.from_now.to_date)}"
    expect(page).to have_content 'Quantidade estimada de convidados: 50'
    expect(page).to have_content 'Detalhes do Evento: Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.'
    expect(page).to have_content 'Endereço: Rua Biboca Diagonal, 934'
    expect(page).to have_content 'Status: Aguardando avaliação do buffet'
    expect(page).not_to have_content "Você possui um evento confirmado para essa data (#{I18n.l(1.week.from_now.to_date)}): ##{other_order.code} !"
  end
end

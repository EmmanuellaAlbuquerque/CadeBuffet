require 'active_support/testing/time_helpers'
include ActiveSupport::Testing::TimeHelpers

ActiveRecord::Base.transaction do
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= MÉTODOS DE PAGAMENTO =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  pix = PaymentMethod.create!(name: 'Pix')
  credit_card = PaymentMethod.create!(name: 'Cartão de Crédito')
  debit_card = PaymentMethod.create!(name: 'Cartão de Débito')
  boleto = PaymentMethod.create!(name: 'Boleto')
  money = PaymentMethod.create!(name: 'Dinheiro')
  
  puts "Adiciona os Métodos de Pagamento: #{pix.name}, #{credit_card.name}, #{debit_card.name}, #{boleto.name}, #{money.name} ..."
  puts "Quantidade: #{PaymentMethod.all.count}"
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= OPÇÕES DE SERVIÇO EXTRAS (EVENTO) =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  valet_service = ServiceOption.create!(name: 'Serviço de Valet')
  parking_service = ServiceOption.create!(name: 'Serviço de Estacionamento')
  decoration_service = ServiceOption.create!(name: 'Serviço de Decoração')
  drinking_service = ServiceOption.create!(name: 'Distribuição de Bebidas Alcoólicas')
  
  puts "Adiciona as Opções de Serviços Extra: #{valet_service.name}, #{parking_service.name}, #{decoration_service.name}, #{drinking_service.name} ..."
  puts "Quantidade: #{ServiceOption.all.count}"
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= USUÁRIOS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= DONOS DE BUFFET =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
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
  
  sabores_owner = BuffetOwner.create!(
    email: 'sabores_buffet@example.com',
    password: '!@#Sabores1'
  )
  
  delicias_owner = BuffetOwner.create!(
    email: 'delicias_buffet@example.com',
    password: 'D3l1c1@s#2'
  )
  
  encantos_owner = BuffetOwner.create!(
    email: 'encantos_buffet@example.com',
    password: 'Enc@nt0s#3'
  )
  
  puts "Adiciona Donos de Buffet"
  puts "Quantidade: #{BuffetOwner.all.count}"
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= CLIENTES =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  manu = Client.create!(
    name: 'Manu',
    itin: CPF.generate(true),
    email: 'manu@contato.com', 
    password: '123456'
  )
  
  ana = Client.create!(
    name: 'Ana',
    itin: CPF.generate(true),
    email: 'ana@example.com', 
    password: 'p@ssw0rd123'
  )
  
  Client.create!(
    name: 'Pedro',
    itin: CPF.generate(true),
    email: 'pedro@example.com',
    password: '!@#fgqoD'
  )
  
  Client.create!(
    name: 'Maria',
    itin: CPF.generate(true),
    email: 'maria@example.com',
    password: 'Str0ng!'
  )
  
  joao = Client.create!(
    name: 'João',
    itin: CPF.generate(true),
    email: 'joao@example.com',
    password: 'S@fe12'
  )
  
  puts "Adiciona Clientes"
  puts "Quantidade: #{Client.all.count}"
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= BUFFETS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  tulipas_buffet = Buffet.create!(        
    trading_name: 'Tulipas Buffef | O melhor buffet da região Sudeste', 
    company_name: 'Tulipas Buffef | O melhor buffet da região Sudeste Ltda.',
    registration_number: CNPJ.generate(true), 
    phone: '(83) 9 9834-0345', 
    email: 'contato@buffettulipas.com.br', 
    address: 'Rua Valentim Magalhães, 293',
    neighborhood: 'Alto da Mooca',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '06331-060',
    description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
    buffet_owner: fernando_tulipas,
    payment_methods: [pix, credit_card, debit_card, boleto, money]
  )
  
  caio_buffet = Buffet.create!(        
    trading_name: 'Caio Cozinha & Eventos', 
    company_name: 'Caio Cozinha & Eventos Ltda.',
    registration_number: CNPJ.generate(true), 
    phone: '(83) 9 9834-0345', 
    email: 'contato@caiocozinha.com', 
    address: 'Rua Comendador Bernardo Catarino, 89',
    neighborhood: 'Centro',
    state: 'BA', 
    city: 'Salvador', 
    zipcode: '06331-060',
    description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
    buffet_owner: caio_cozinha,
    payment_methods: [pix, money]
  )
  
  grenah_buffet = Buffet.create!(        
    trading_name: 'Buffet Espaço Grenah | Gastronomia', 
    company_name: 'Buffet Espaço Grenah | Gastronomia Ltda.',
    registration_number: CNPJ.generate(true), 
    phone: '(83) 9 9834-0345', 
    email: 'contato@grenahgastronomia.com', 
    address: 'Rua Azevedo Soares, 633',
    neighborhood: 'Jardim Anália Franco',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '06331-060',
    description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
    buffet_owner: grenah_gastronomia,
    payment_methods: [credit_card, debit_card]
  )
  
  sabores_buffet = Buffet.create!(        
    trading_name: 'Sabores Buffet', 
    company_name: 'Sabores Buffet Ltda.',
    registration_number: CNPJ.generate(true), 
    phone: '(12) 9 3456-7890', 
    email: 'contato@saboresbuffet.com', 
    address: 'Rua dos Sabores, 123',
    neighborhood: 'Bairro dos Sabores',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '06331-060',
    description: 'O Sabores Buffet oferece uma ampla variedade de pratos, desde o tradicional até o contemporâneo, garantindo uma experiência gastronômica única para todos os tipos de eventos.',
    buffet_owner: sabores_owner,
    payment_methods: [pix, money]
  )
  
  delicias_buffet = Buffet.create!(        
    trading_name: 'Delícias Buffet', 
    company_name: 'Delícias Buffet Ltda.',
    registration_number: CNPJ.generate(true), 
    phone: '(12) 9 9876-5432', 
    email: 'contato@deliciasbuffet.com', 
    address: 'Avenida das Delícias, 456',
    neighborhood: 'Vila Delícias',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '06331-060',
    description: 'O Delícias Buffet oferece uma experiência culinária única, com um menu variado e personalizado para atender a todos os tipos de eventos, desde casamentos a festas corporativas.',
    buffet_owner: delicias_owner,
    payment_methods: [credit_card, debit_card]
  )
  
  encantos_buffet = Buffet.create!(        
    trading_name: 'Encantos Buffet', 
    company_name: 'Encantos Buffet Ltda.',
    registration_number: CNPJ.generate(true), 
    phone: '(12) 9 9876-5432', 
    email: 'contato@encantosbuffet.com', 
    address: 'Rua dos Encantos, 789',
    neighborhood: 'Centro dos Encantos',
    state: 'SP', 
    city: 'São Paulo', 
    zipcode: '06331-060',
    description: 'O Encantos Buffet oferece uma experiência gastronômica única, combinando ingredientes frescos e técnicas culinárias modernas para criar pratos que encantam os paladares mais exigentes.',
    buffet_owner: encantos_owner,
    payment_methods: [credit_card, debit_card]
  )
  
  puts "Adiciona Buffets"
  puts "Quantidade: #{Buffet.all.count}"
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= EVENTOS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= EVENTOS DO BUFFET TULIPAS  =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  tulipas_graduation_event = Event.create!(
    name: 'Festa de Formatura',
    description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
    qty_min: 50,
    qty_max: 100,
    duration: 180,
    menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
    exclusive_location: true,
    service_options: [valet_service, parking_service, decoration_service, drinking_service],
    buffet: tulipas_buffet
  )
  tulipas_graduation_event.photos.attach(io: File.open(Rails.root.join('db', 'images', 'graduation01.jpg')), filename: 'graduation01.jpg')
  tulipas_graduation_event.photos.attach(io: File.open(Rails.root.join('db', 'images', 'graduation02.jpg')), filename: 'graduation02.jpg')
  
  tulipas50anniversary_event = Event.create!(
    name: 'Gala de Aniversário de 50 Anos',
    description: 'Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.',
    qty_min: 50,
    qty_max: 200,
    duration: 120,
    menu: 'Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.',
    service_options: [valet_service, decoration_service, drinking_service],
    buffet: tulipas_buffet
  )
  tulipas50anniversary_event.photos.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'festa_de_50_anos.png')), filename: 'festa_de_50_anos.png')
  
  tulipas_wedding_party = Event.create!(
    name: 'Festa de Casamento',
    description: 'Um dia especial para celebrar o amor e a união.',
    qty_min: 50,
    qty_max: 250,
    duration: 240,
    menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
    service_options: [valet_service, parking_service, decoration_service, drinking_service],
    buffet: tulipas_buffet
  )
  tulipas_wedding_party.photos.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'festa_de_casamento.jpg')), filename: 'festa_de_casamento.jpg')
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= EVENTOS DO BUFFET GRENAH  =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  grenah_wedding_party = Event.create!(
    name: 'Festa de Casamento',
    description: 'Uma jornada mágica onde dois corações se unem para compartilhar amor, risos e promessas eternas. Venha celebrar conosco este momento único e inesquecível.',
    qty_min: 30,
    qty_max: 100,
    duration: 180,
    menu: 'Entradas: Seleção de canapés gourmet e camarões ao molho de limão siciliano. Prato Principal: Medalhões de filé mignon com molho de cogumelos selvagens. Acompanhamentos: Risoto de aspargos e batatas rústicas. Sobremesa: Degustação de mini sobremesas, incluindo macarons, cheesecake de frutas vermelhas e torta de chocolate belga.',
    service_options: [parking_service, drinking_service],
    buffet: grenah_buffet
  )
  grenah_wedding_party.photos.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'buffet-para-casamento-com-garcom.jpg')), filename: 'buffet-para-casamento-com-garcom.jpg')
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= EVENTOS DO BUFFET CAIO COZINHA  =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  caio_anniversary_party = Event.create!(
    name: 'Festa de Aniversário de 15 anos',
    description: 'A festa de aniversário de 15 anos é um momento especial na vida de qualquer jovem, marcando a transição para a vida adulta com estilo e elegância. No Buffet Caio Cozinha, estamos comprometidos em tornar esse dia ainda mais memorável, oferecendo um serviço excepcional e uma experiência gastronômica que encanta todos os convidados.',
    qty_min: 50,
    qty_max: 100,
    duration: 180,
    menu: 'Uma variedade exuberante de entradas, como canapés de salmão defumado e cestinhas de camarão, seguidas por pratos principais refinados, incluindo filé mignon ao molho de vinho tinto e risoto de funghi porcini. Sobremesas irresistíveis, como mini tortinhas de frutas vermelhas e brigadeiros gourmet, completam o cardápio.',
    service_options: [decoration_service],
    buffet: caio_buffet
  )
  caio_anniversary_party.photos.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'buffet-para-festa-15-anos.jpg')), filename: 'buffet-para-festa-15-anos.jpg')
  
  puts "Adiciona Eventos"
  puts "Quantidade: #{Event.all.count}"
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= PREÇOS BASE =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= PREÇOS BASE DO BUFFET TULIPAS  =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  BasePrice.create!(
    min_price: 4000,
    chosen_category_day: 'weekend',
    extra_price_per_person: 100,
    extra_price_per_duration: 150,
    event: tulipas50anniversary_event
  )
  
  BasePrice.create!(
    min_price: 3500,
    chosen_category_day: 'weekdays',
    extra_price_per_person: 90,
    extra_price_per_duration: 130,
    event: tulipas50anniversary_event
  )
  
  BasePrice.create!(
    min_price: 3500,
    chosen_category_day: 'weekend',
    extra_price_per_person: 50,
    extra_price_per_duration: 90,
    event: tulipas_graduation_event
  )
  
  BasePrice.create!(
    min_price: 3000,
    chosen_category_day: 'weekdays',
    extra_price_per_person: 30,
    extra_price_per_duration: 50,
    event: tulipas_graduation_event
  )
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= PREÇOS BASE DO BUFFET GRENAH  =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  BasePrice.create!(
    min_price: 10_000,
    chosen_category_day: 'weekdays',
    extra_price_per_person: 250,
    extra_price_per_duration: 1000,
    event: grenah_wedding_party
  )
  
  BasePrice.create!(
    min_price: 14_000,
    chosen_category_day: 'weekend',
    extra_price_per_person: 300,
    extra_price_per_duration: 1500,
    event: grenah_wedding_party
  ) 
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= PREÇOS BASE DO BUFFET CAIO COZINHA  =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  BasePrice.create!(
    min_price: 1_000,
    chosen_category_day: 'weekdays',
    extra_price_per_person: 10,
    extra_price_per_duration: 50,
    event: caio_anniversary_party
  )
  
  BasePrice.create!(
    min_price: 2_000,
    chosen_category_day: 'weekend',
    extra_price_per_person: 20,
    extra_price_per_duration: 50,
    event: caio_anniversary_party
  )
  
  puts "Adiciona Preços Base"
  puts "Quantidade: #{BasePrice.all.count}"
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= PEDIDOS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= PEDIDOS PARA O BUFFET TULIPAS  =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  travel_to(3.weeks.ago) do
    Sale.create!(
      name: 'MEGA Oferta Tulipas',
      start_date: 1.day.from_now,
      end_date: 3.week.from_now,
      discount_percentage: 50,
      on_weekdays: true,
      on_weekend: true,
      event: tulipas50anniversary_event,
      buffet: tulipas_buffet
    )
    
    Sale.create!(
      name: 'MEGA Oferta de Fim de Semana',
      start_date: 1.day.from_now,
      end_date: 3.week.from_now,
      discount_percentage: 60,
      on_weekdays: false,
      on_weekend: true,
      event: tulipas50anniversary_event,
      buffet: tulipas_buffet
    )
  end
  
  travel_to(2.weeks.ago) do
    anniversary_order = Order.create!(
      event_date: Date.today.next_occurring(:wednesday), 
      qty_invited: 50, 
      event_details: '#1 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: tulipas_buffet,
      event: tulipas50anniversary_event,
      client: manu,
      status: :confirmed
    )
  
    anniversary_chat = Chat.create!(
      order: anniversary_order
    )
    
    Message.create!(
      chat: anniversary_chat,
      sender: fernando_tulipas,
      content: 'Olá, bom dia. Gostaria de saber mais detalhes sobre a decoração temática da festa, se há alguma restrição alimentar por parte dos seus convidados ou preferências culinárias específicas. Além disso, qual seria a forma de pagamento desejada?'
    )
    
    Message.create!(
      chat: anniversary_chat,
      sender: manu,
      content: 'Olaaa, sobre a decoração, pode incluir mesas decoradas com toalhas longas, candelabros flutuantes e banners das quatro casas de Hogwarts (Gryffindor, Slytherin, Ravenclaw e Hufflepuff) pendurados nas paredes. Sobre o pagamento, gostaria que fosse via Pix.'
    )  
  
    OrderPayment.create!(
      extra_tax: 0,
      discount: 0,
      description: '...',
      validity_date: 1.week.from_now,
      payment_method: pix,
      order: anniversary_order,
      standard_price: 1_750,
      special_sale: true
    )
  end
  
  puts "Adiciona Promoções"
  puts "Quantidade: #{Sale.all.count}"
  
  puts "Adiciona Messagens"
  puts "Quantidade: #{Message.all.count}"
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= PEDIDOS PARA O BUFFET GRENAH  =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  grenah_wedding_party_event_order_weekend = Order.create!(
    event_date: Date.today.next_occurring(:sunday), 
    qty_invited: 30,
    event_details: '#1',
    event_address: 'Rua Biboca Diagonal, 934',
    buffet: grenah_buffet,
    event: grenah_wedding_party,
    client: manu,
    status: :confirmed
  )
  
  OrderPayment.create!(
    extra_tax: 0,
    discount: 0,
    description: '...',
    validity_date: 1.week.from_now,
    payment_method: pix,
    order: grenah_wedding_party_event_order_weekend,
    standard_price: 14_000
  )
  
  manu_order_evaluation = OrderEvaluation.create!(
    order: grenah_wedding_party_event_order_weekend,
    rating: 5,
    service_opinion: 'Estou muitooo satisfeita com o serviço, nada a reclamar!'
  )
  manu_order_evaluation.review_medias.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'festa_de_casamento.jpg')), filename: 'festa_de_casamento.jpg')
  
  grenah_wedding_party_event_order_weekdays = Order.create!(
    event_date: Date.today.next_occurring(:wednesday), 
    qty_invited: 30,
    event_details: '#2',
    event_address: 'Rua Biboca Diagonal, 934',
    buffet: grenah_buffet,
    event: grenah_wedding_party,
    client: ana,
    status: :confirmed
  )
  
  OrderPayment.create!(
    extra_tax: 0,
    discount: 0,
    description: '...',
    validity_date: 1.week.from_now,
    payment_method: pix,
    order: grenah_wedding_party_event_order_weekdays,
    standard_price: 10_000
  )
  
  OrderEvaluation.create!(
    order: grenah_wedding_party_event_order_weekdays,
    rating: 2,
    service_opinion: 'Estou extremamente insatisfeita com minha experiência. A qualidade da comida deixou muito a desejar e o atendimento foi deplorável.'
  )

  penalties_order = Order.create!(
    event_date: Date.today.next_occurring(:wednesday), 
    qty_invited: 50, 
    event_details: 'Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
    event_address: 'Rua Biboca Diagonal, 934',
    buffet: tulipas_buffet,
    event: tulipas50anniversary_event,
    client: manu,
    status: :approved
  )

  OrderPayment.create!(
    extra_tax: 0,
    discount: 0,
    description: 'nenhum desconto aplicado.',
    validity_date: 1.week.from_now,
    payment_method: pix,
    order: penalties_order,
    standard_price: 10_000
  )

  Penalty.create!(
    event: tulipas50anniversary_event,
    days_ago: 30,
    value_percentage: 50
  )
  
  Penalty.create!(
    event: tulipas50anniversary_event,
    days_ago: 20,
    value_percentage: 60
  )

  Penalty.create!(
    event: tulipas50anniversary_event,
    days_ago: 0,
    value_percentage: 100
  )
  
  # =-=-=-=-=-=-=-=-=-=-=-=-=-= AVALIAÇÕES DE PEDIDOS TULIPAS BUFFET  =-=-=-=-=-=-=-=-=-=-=-=-=-=
  
  travel_to(5.months.ago) do
    first_review = Order.create!(
      event_date: Date.today.next_occurring(:wednesday), 
      qty_invited: 50, 
      event_details: '#1 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: tulipas_buffet,
      event: tulipas50anniversary_event,
      client: ana,
      status: :confirmed
    )

    OrderPayment.create!(
      extra_tax: 0,
      discount: 0,
      description: '...',
      validity_date: 1.week.from_now,
      payment_method: pix,
      order: first_review,
      standard_price: 14_000
    )
    
    OrderEvaluation.create!(
      order: first_review,
      rating: 2,
      service_opinion: '...'
    )
  end
  
  travel_to(1.day.ago) do
    last_review = Order.create!(
      event_date: Date.today.next_occurring(:wednesday), 
      qty_invited: 50, 
      event_details: '#1 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
      event_address: 'Rua Biboca Diagonal, 934',
      buffet: tulipas_buffet,
      event: tulipas50anniversary_event,
      client: manu,
      status: :confirmed
    )

    OrderPayment.create!(
      extra_tax: 0,
      discount: 0,
      description: '...',
      validity_date: 1.week.from_now,
      payment_method: pix,
      order: last_review,
      standard_price: 10_000
    )
    
    OrderEvaluation.create!(
      order: last_review,
      rating: 5,
      service_opinion: 'Estou muitooo satisfeita com o serviço, nada a reclamar!'
    )
  end
  
  travel_to(5.weeks.ago) do
  
    reviews_array = []
  
    5.times do
      review = Order.create!(
        event_date: Date.today.next_occurring(:wednesday), 
        qty_invited: 50, 
        event_details: '#1 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
        event_address: 'Rua Biboca Diagonal, 934',
        buffet: tulipas_buffet,
        event: tulipas50anniversary_event,
        client: joao,
        status: :confirmed
      )

      OrderPayment.create!(
        extra_tax: 0,
        discount: 0,
        description: '...',
        validity_date: 1.week.from_now,
        payment_method: pix,
        order: review,
        standard_price: 10_000
      )
      
      reviews_array << review
    end
    
    evaluation1 = OrderEvaluation.create!(
      order: reviews_array[0],
      rating: 2,
      service_opinion: 'Estou extremamente insatisfeita com minha experiência. A qualidade da comida deixou muito a desejar e o atendimento foi deplorável.'
      )
    evaluation1.review_medias.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'placeholder_buffet_image.jpeg')), filename: 'placeholder_buffet_image.jpeg')
    evaluation1.review_medias.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'sobel_feldman_buffet_template.png')), filename: 'sobel_feldman_buffet_template.png')
  
    evaluation2 = OrderEvaluation.create!(
      order: reviews_array[1],
      rating: 5,
      service_opinion: 'A decoração estava impecável e a atenção aos detalhes foi incrível!'
    )
    evaluation2.review_medias.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'placeholder_buffet_image.jpeg')), filename: 'placeholder_buffet_image.jpeg')
  
    evaluation3 = OrderEvaluation.create!(
      order: reviews_array[2],
      rating: 3,
      service_opinion: 'Infelizmente, a organização do evento deixou a desejar, muitos detalhes foram negligenciados.'
    )
    evaluation3.review_medias.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'placeholder_buffet_image.jpeg')), filename: 'placeholder_buffet_image.jpeg')
  
    evaluation4 = OrderEvaluation.create!(
      order: reviews_array[3],
      rating: 4,
      service_opinion: 'Os convidados ficaram impressionados com a organização e o serviço.'
    )
    evaluation4.review_medias.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'placeholder_buffet_image.jpeg')), filename: 'placeholder_buffet_image.jpeg')
  
    evaluation5 = OrderEvaluation.create!(
      order: reviews_array[4],
      rating: 1,
      service_opinion: 'Nada a comentar!'
    )
    evaluation5.review_medias.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'placeholder_buffet_image.jpeg')), filename: 'placeholder_buffet_image.jpeg')
  end
  
  puts "Adiciona Pedidos"
  puts "Quantidade: #{Order.all.count}"
  
  puts "Adiciona Reviews"
  puts "Quantidade: #{OrderEvaluation.all.count}"  
end

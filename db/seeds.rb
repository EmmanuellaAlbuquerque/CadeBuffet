# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= MÉTODOS DE PAGAMENTO =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

pix = PaymentMethod.create!(name: 'Pix')
PaymentMethod.create!(name: 'Cartão de Crédito')
PaymentMethod.create!(name: 'Cartão de Débito')
PaymentMethod.create!(name: 'Boleto')
PaymentMethod.create!(name: 'Dinheiro')

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= OPÇÕES DE SERVIÇO EXTRAS (EVENTO) =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

valet_service = ServiceOption.create!(name: 'Serviço de Valet')
ServiceOption.create!(name: 'Serviço de Estacionamento')
ServiceOption.create!(name: 'Serviço de Decoração')
ServiceOption.create!(name: 'Distribuição de Bebidas Alcoólicas')

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

# =-=-=-=-=-=-=-=-=-=-=-=-=-= CLIENTES =-=-=-=-=-=-=-=-=-=-=-=-=-=

manu = Client.create!(
  name: 'Manu',
  itin: '00189137096',
  email: 'manu@contato.com', 
  password: 'u!Qm926Kz8qupGTPh'
)

Client.create!(
  name: 'Ana',
  itin: '29053152024',
  email: 'ana@example.com', 
  password: 'p@ssw0rd123'
)

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= BUFFETS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

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

Buffet.create!(        
  trading_name: 'Caio Cozinha & Eventos', 
  company_name: 'Caio Cozinha & Eventos Ltda.',
  registration_number: '92732949000102', 
  phone: '7723633113', 
  email: 'contato@caiocozinha.com', 
  address: 'Rua Comendador Bernardo Catarino, 89',
  neighborhood: 'Centro',
  state: 'BA', 
  city: 'Salvador', 
  zipcode: '12903834',
  description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
  buffet_owner: caio_cozinha,
  payment_methods: [pix]
)

grenah_buffet = Buffet.create!(        
  trading_name: 'Buffet Espaço Grenah | Gastronomia', 
  company_name: 'Buffet Espaço Grenah | Gastronomia Ltda.',
  registration_number: '00401207000178', 
  phone: '1430298587', 
  email: 'contato@grenahgastronomia.com', 
  address: 'Rua Azevedo Soares, 633',
  neighborhood: 'Jardim Anália Franco',
  state: 'SP', 
  city: 'São Paulo', 
  zipcode: '03322000',
  description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
  buffet_owner: grenah_gastronomia,
  payment_methods: [pix]
)

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= EVENTOS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

tulipas_graduation_event = Event.create!(
  name: 'Festa de Formatura',
  description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
  qty_min: 50,
  qty_max: 100,
  duration: 180,
  menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
  exclusive_location: true,
  service_options: [valet_service],
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
  service_options: [valet_service],
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
  service_options: [valet_service],
  buffet: tulipas_buffet
) 

grenah_wedding_party = Event.create!(
  name: 'Festa de Casamento',
  description: 'Uma jornada mágica onde dois corações se unem para compartilhar amor, risos e promessas eternas. Venha celebrar conosco este momento único e inesquecível.',
  qty_min: 100,
  qty_max: 500,
  duration: 180,
  menu: 'Entradas: Seleção de canapés gourmet e camarões ao molho de limão siciliano. Prato Principal: Medalhões de filé mignon com molho de cogumelos selvagens. Acompanhamentos: Risoto de aspargos e batatas rústicas. Sobremesa: Degustação de mini sobremesas, incluindo macarons, cheesecake de frutas vermelhas e torta de chocolate belga.',
  service_options: [valet_service],
  buffet: grenah_buffet
)

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= PREÇOS BASE =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

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

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= PEDIDOS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Order.create!(
  event_date: 1.week.from_now, 
  qty_invited: 50, 
  event_details: '#1 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
  event_address: 'Rua Biboca Diagonal, 934',
  buffet: tulipas_buffet,
  event: tulipas50anniversary_event,
  client: manu
)

Order.create!(
  event_date: 1.week.from_now, 
  qty_invited: 50, 
  event_details: '#2 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
  event_address: 'Rua Biboca Diagonal, 934',
  buffet: tulipas_buffet,
  event: tulipas50anniversary_event,
  client: manu,
  status: :confirmed
)

Order.create!(
  event_date: 1.week.from_now, 
  qty_invited: 50, 
  event_details: '#3 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
  event_address: 'Rua Biboca Diagonal, 934',
  buffet: tulipas_buffet,
  event: tulipas50anniversary_event,
  client: manu,
  status: :confirmed
)

Order.create!(
  event_date: 1.week.from_now, 
  qty_invited: 50, 
  event_details: '#4 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
  event_address: 'Rua Biboca Diagonal, 934',
  buffet: tulipas_buffet,
  event: tulipas50anniversary_event,
  client: manu,
  status: :canceled
)

Order.create!(
  event_date: 2.week.from_now, 
  qty_invited: 50,
  event_details: '#5 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
  buffet: tulipas_buffet,
  event: tulipas_graduation_event,
  client: manu,
  status: :confirmed
)

Order.create!(
  event_date: 2.week.from_now, 
  event_details: '#6 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
  qty_invited: 50,
  buffet: tulipas_buffet,
  event: tulipas50anniversary_event,
  client: manu
)

Order.create!(
  event_date: 2.week.from_now, 
  event_details: '#7 Gostaria de solicitar a inclusão de uma decoração temática no local do evento com mesas decoradas com toalhas longas.',
  qty_invited: 50,
  buffet: grenah_buffet,
  event: grenah_wedding_party,
  client: manu
)

<!-- ################### README DO PROJETO CADÊ BUFFET ################### -->

![Logo do projeto](.github/CadeBuffetTemplate.png)

<p align="center">
  <img src="https://img.shields.io/badge/ruby-3.0.0p0-%23CC0000.svg?style=for-the-badge&logo=ruby&logoColor=white"/>
  <img src="https://img.shields.io/badge/Ruby%20On%20Rails%20-7.1.3.2-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white"/>
  <img src="https://img.shields.io/badge/bootstrap-5.3.3-%238511FA.svg?style=for-the-badge&logo=bootstrap&logoColor=white"/>	
</p>

## Lista de Conteúdos

:pushpin: [Descrição do Projeto](#mag-descrição-do-projeto)

:pushpin: [Gems Utilizadas](#gems-utilizadas)

:pushpin: [Dependências](#dependêndias)

:pushpin: [Como Rodar o Projeto?](#rocket-como-rodar-o-projeto)

:pushpin: [Como Rodar os Testes?](#hammer_and_pick-como-rodar-os-testes)

:pushpin: [Logins de Contas (para testes)](#logins-de-contas-para-testes)

:pushpin: [Documentação da API (Cadê Buffet?)](#book-documentação-da-api-cadê-buffet)

## :mag: Descrição do Projeto

<div align="justify">
	O "Cadê Buffet?" é um sistema completo de gestão de buffets e reservas, ideal para quem busca facilitar a organização de eventos, com funcionalidades de reserva e avaliação integradas, torna-se a solução perfeita para eventos memoráveis.
</div>

##### Funcionalidades

###### Para Donos de Buffet
:sparkles: Criar conta como Dono de Buffet

:sparkles: Cadastrar seu Buffet

:sparkles: Adicionar Tipos de Eventos que seu Buffet oferece 

:sparkles: Adicionar Preços por Evento

:sparkles: Adicionar Fotos para Tipos de Eventos

:sparkles: Avaliar o Pedido feito pelo Cliente

:sparkles: Aprovar o Pedido feito pelo Cliente

:sparkles: Desativar seu Buffet, ou seus Tipos de Eventos

:sparkles: Criar Promoções para os Clientes

###### Para Clientes
:sparkles: Criar conta como Cliente

:sparkles: Ver os Buffets Cadastrados

:sparkles: Ver Tipos de Eventos Oferecidos para cada Buffet

:sparkles: Buscar Buffet (Por Nome Fantasia, Cidade, Nome do Evento)

:sparkles: Fazer um Pedido para um Buffet

:sparkles: Confirmar o Pedido, dado o orçamento enviado pelo Dono de Buffet

:sparkles: Avaliar o Buffet, após seu evento ter sido realizado

###### Para Ambos
:sparkles: Troca de mensagens entre os usuários

## Gems Utilizadas

- [Devise](https://github.com/heartcombo/devise) (Solução de autenticação para o rails)
- [Rspec](https://github.com/rspec/rspec-rails) (Framework de teste para o rails)
- [Capybara](https://github.com/teamcapybara/capybara) (Framework de teste de aceitação para aplicações web)

## Dependêndias

- libvips (lib de de processamento de imagens)
- - [Build VIPS for Ubuntu](https://github.com/libvips/libvips/wiki/Build-for-Ubuntu)

```sh
	# Instala o pacote padrão do VIPS
	sudo apt install libvips
```

## :rocket: Como Rodar o Projeto?

```sh
  # Faça o clone do projeto
  git clone git@github.com:EmmanuellaAlbuquerque/CadeBuffet.git

  # Entre na pasta do projeto
  cd CadeBuffet

  # Instale as dependências do projeto
  bundle install

  # Execute as migrations
  rails db:migrate

  # Executa as seeds para popular o banco de dados
  rails db:seed

  # Rode o servidor
  rails server

  # Acesse o servidor em
  http://localhost:3000
```

## :hammer_and_pick: Como Rodar os Testes?
```sh
cd CadeBuffet

rspec
```

## Logins de Contas (para testes)

#### Acessando o sistema como usuário "Cliente"
```yaml
  E-mail: manu@contato.com
  Senha: u!Qm926Kz8qupGTPh
```

#### Acessando o sistema como usuário "Dono de Buffet"
```yaml
  E-mail: contato@fernandotulipas.com
  Senha: fernandodastulipas123
```

## :book: Documentação da API (Cadê Buffet?)

### Endpoints

##### Buffets
###### 1.1 (GET /api/v1/buffets)
* [Listagem dos Buffets](#11-buffets--listagem-dos-buffets)

###### 1.2 (GET /api/v1/buffets/search/?query=value)
* [Busca por Buffets](#12-buffets--busca-por-buffets)

###### 1.3 (GET /api/v1/buffets/1)
* [Detalhes de um Buffet](#13-buffets--detalhes-de-um-buffet)

##### Eventos

###### 2.1 (GET /api/v1/buffets/1/events)
* [Listagem dos Eventos de um Buffet](#21-events--listagem-dos-eventos-de-um-buffet)

###### 2.2 (GET /api/v1/events/1/available?event_date=15/05/2025&qty_invited=100)
* [Consulta de Disponibilidade](#22-events--consulta-de-disponibilidade)

### 1. Buffets

Os buffets são empresas que oferecem uma variedade de serviços para eventos, desde alimentos e bebidas até serviços personalizados, como decoração, serviço de valet, entreterimento, entre outros.

##### Atributos do Buffet
| Atributo | Tipo | Descrição |
|:---:|:---:|:---:|
| id | integer | Identificador único do buffet |
| trading_name | string | Nome fantasia do buffet |
| company_name | string | Razão social do buffet |
| registration_number | string | CNPJ do buffet |
| phone | string | Telefone do buffet para contato |
| email | string | Email do buffet para contato |
| address | string | Endereço do buffet |
| neighborhood | string | Bairro do buffet |
| state | string | Estado do buffet (sigla, 2 caracteres) |
| city | string | Cidade do buffet |
| zipcode | string | CEP do buffet |
| description | string | Descrição do buffet |
| payment_methods | Array | Métodos de pagamento aceitos pelo buffet |

#### 1.1 Buffets | Listagem dos Buffets

Este endpoint retorna todos os buffets cadastrados.

##### HTTP Request
`GET /api/v1/buffets`

##### Response Format

HTTP/1.1 200 OK
```json
[
	{
		"id": 1,
		"trading_name": "Tulipas Buffef | O melhor buffet da região Sudeste",
		"phone": "(83) 9 9834-0345",
		"email": "contato@buffettulipas.com.br",
		"address": "Rua Valentim Magalhães, 293",
		"neighborhood": "Alto da Mooca",
		"state": "SP",
		"city": "São Paulo",
		"zipcode": "06397-410",
		"description": "O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.",
		"buffet_owner_id": 1,
		"average_rating": "Ainda não foram cadastradas avaliações!"
	},
	{
		"id": 2,
		"trading_name": "Caio Cozinha & Eventos",
		"phone": "(83) 9 9834-0345",
		"email": "contato@caiocozinha.com",
		"address": "Rua Comendador Bernardo Catarino, 89",
		"neighborhood": "Centro",
		"state": "BA",
		"city": "Salvador",
		"zipcode": "06397-600",
		"description": "O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.",
		"buffet_owner_id": 2,
		"average_rating": "Ainda não foram cadastradas avaliações!"
	},
	{
		"id": 3,
		"trading_name": "Buffet Espaço Grenah | Gastronomia",
		"phone": "(83) 9 9834-0345",
		"email": "contato@grenahgastronomia.com",
		"address": "Rua Azevedo Soares, 633",
		"neighborhood": "Jardim Anália Franco",
		"state": "SP",
		"city": "São Paulo",
		"zipcode": "06386-095",
		"description": "Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.",
		"buffet_owner_id": 3,
		"average_rating": 3.5
	},
	{
		"id": 4,
		"trading_name": "Sabores Buffet",
		"phone": "1234567890",
		"email": "contato@saboresbuffet.com",
		"address": "Rua dos Sabores, 123",
		"neighborhood": "Bairro dos Sabores",
		"state": "SP",
		"city": "São Paulo",
		"zipcode": "12345000",
		"description": "O Sabores Buffet oferece uma ampla variedade de pratos, desde o tradicional até o contemporâneo, garantindo uma experiência gastronômica única para todos os tipos de eventos.",
		"buffet_owner_id": 4,
		"average_rating": "Ainda não foram cadastradas avaliações!"
	},
	{
		"id": 5,
		"trading_name": "Delícias Buffet",
		"phone": "0987654321",
		"email": "contato@deliciasbuffet.com",
		"address": "Avenida das Delícias, 456",
		"neighborhood": "Vila Delícias",
		"state": "SP",
		"city": "São Paulo",
		"zipcode": "54321000",
		"description": "O Delícias Buffet oferece uma experiência culinária única, com um menu variado e personalizado para atender a todos os tipos de eventos, desde casamentos a festas corporativas.",
		"buffet_owner_id": 5,
		"average_rating": "Ainda não foram cadastradas avaliações!"
	},
	{
		"id": 6,
		"trading_name": "Encantos Buffet",
		"phone": "5678901234",
		"email": "contato@encantosbuffet.com",
		"address": "Rua dos Encantos, 789",
		"neighborhood": "Centro dos Encantos",
		"state": "SP",
		"city": "São Paulo",
		"zipcode": "67890000",
		"description": "O Encantos Buffet oferece uma experiência gastronômica única, combinando ingredientes frescos e técnicas culinárias modernas para criar pratos que encantam os paladares mais exigentes.",
		"buffet_owner_id": 6,
		"average_rating": "Ainda não foram cadastradas avaliações!"
	}
]
```

HTTP/1.1 500 Internal Server Error
```text
GET /api/v1/buffets
```

##### Códigos de Resposta

200 OK: A solicitação foi bem-sucedida.
500 Internal Server Error: Ocorreu um erro no servidor ao processar a solicitação.

#### 1.2 Buffets | Busca por Buffets

Este endpoint provê a busca de um buffet dado um filtro(valor) de busca. 

##### HTTP Request
`GET /api/v1/buffets/search/?query=value`

Exemplo:
`GET /api/v1/buffets/search/?query=Tulipas`

###### Parâmetros de Consulta

- `query` (string): O parâmetro de consulta usado para filtrar os buffets. O valor fornecido será usado para encontrar buffets que correspondam à consulta.

###### Opções de Consulta
* Filtro por Nome Fantasia
  * Exemplo: `GET /api/v1/buffets/search/?query=Tulipas`
* Filtro por Cidade
  * Exemplo: `GET /api/v1/buffets/search/?query=São Paulo`
* Filtro por Nome do Evento
  * Exemplo: `GET /api/v1/buffets/search/?query=Festa de Casamento`

##### Response Format

HTTP/1.1 200 OK
```json
[
	{
		"id": 1,
		"trading_name": "Tulipas Buffef | O melhor buffet da região Sudeste",
		"company_name": "Tulipas Buffef | O melhor buffet da região Sudeste Ltda.",
		"registration_number": "12345678000123",
		"phone": "(83) 9 9834-0345",
		"email": "contato@buffettulipas.com.br",
		"address": "Rua Valentim Magalhães, 293",
		"neighborhood": "Alto da Mooca",
		"state": "SP",
		"city": "São Paulo",
		"zipcode": "06397-410",
		"description": "O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.",
		"buffet_owner_id": 1
	}
]
```

##### Códigos de Resposta

200 OK: A solicitação foi bem-sucedida.

#### 1.3 Buffets | Detalhes de um Buffet

Este endpoint retorna detalhes de um buffet específico.

##### HTTP Request
`GET /api/v1/buffets/:id`

Exemplo:
`GET /api/v1/buffets/1`

##### Response Format

HTTP/1.1 200 OK
```json
{
	"id": 1,
	"trading_name": "Tulipas Buffef | O melhor buffet da região Sudeste",
	"phone": "(83) 9 9834-0345",
	"email": "contato@buffettulipas.com.br",
	"address": "Rua Valentim Magalhães, 293",
	"neighborhood": "Alto da Mooca",
	"state": "SP",
	"city": "São Paulo",
	"zipcode": "06397-410",
	"description": "O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.",
	"buffet_owner_id": 1,
	"payment_methods": [
		{
			"name": "Pix"
		},
		{
			"name": "Cartão de Crédito"
		},
		{
			"name": "Cartão de Débito"
		},
		{
			"name": "Boleto"
		},
		{
			"name": "Dinheiro"
		}
	],
	"average_rating": "Ainda não foram cadastradas avaliações!"
}
```

HTTP/1.1 404 Not Found
```text
GET /api/v1/buffets/99999999
```

##### Códigos de Resposta

200 OK: A solicitação foi bem-sucedida.
404 Not Found: O recurso solicitado não foi encontrado. Ocorre se o buffet específico solicitado não existir.

### 2. Events

Os Eventos são os tipos de festas oferecidas por esse Buffet. Desde casamentos e formaturas até aniversários e eventos corporativos.

##### Atributos do Evento
| Atributo | Tipo | Descrição |
|:---:|:---:|:---:|
| id | integer | Identificador único do evento |
| name | string | Nome do evento |
| description | string | Descrição do evento |
| qty_min | integer | Quantidade mínima de pessoas que podem ser atendidas |
| qty_max | integer | Quantidade máxima de pessoas que podem ser atendidas |
| duration | integer | Duração padrão do evento em minutos |
| menu | string | Cardápio para o evento |
| exclusive_location | boolean | Se o evento possui localização exclusiva, i.e somente no endereço padrão do Buffet |
| service_options | Array | Opções de serviço extra disponíveis no Evento |

#### 2.1 Events | Listagem dos Eventos de um Buffet

Este endpoint retorna todos os eventos de um buffet específico.

##### HTTP Request
`GET /api/v1/buffets/:id/events`

Exemplo:
`GET /api/v1/buffets/1/events`

##### Responses Format

HTTP/1.1 200 OK
```json
[
	{
		"id": 1,
		"name": "Festa de Formatura",
		"description": "Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.",
		"qty_min": 50,
		"qty_max": 100,
		"duration": 180,
		"menu": "Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.",
		"buffet_id": 1,
		"exclusive_location": true,
		"service_options": [
			{
				"name": "Serviço de Valet"
			},
			{
				"name": "Serviço de Estacionamento"
			},
			{
				"name": "Serviço de Decoração"
			},
			{
				"name": "Distribuição de Bebidas Alcoólicas"
			}
		]
	},
	{
		"id": 2,
		"name": "Gala de Aniversário de 50 Anos",
		"description": "Uma noite de elegância e celebração em honra do 50º aniversário de uma pessoa especial.",
		"qty_min": 50,
		"qty_max": 200,
		"duration": 120,
		"menu": "Prato Principal: Salmão grelhado com molho de manteiga de limão e ervas. Acompanhamentos: Risoto de cogumelos selvagens.",
		"buffet_id": 1,
		"exclusive_location": false,
		"service_options": [
			{
				"name": "Serviço de Valet"
			},
			{
				"name": "Serviço de Decoração"
			},
			{
				"name": "Distribuição de Bebidas Alcoólicas"
			}
		]
	},
	{
		"id": 3,
		"name": "Festa de Casamento",
		"description": "Um dia especial para celebrar o amor e a união.",
		"qty_min": 50,
		"qty_max": 250,
		"duration": 240,
		"menu": "Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.",
		"buffet_id": 1,
		"exclusive_location": false,
		"service_options": [
			{
				"name": "Serviço de Valet"
			},
			{
				"name": "Serviço de Estacionamento"
			},
			{
				"name": "Serviço de Decoração"
			},
			{
				"name": "Distribuição de Bebidas Alcoólicas"
			}
		]
	}
]
```

HTTP/1.1 404 Not Found
```text
GET /api/v1/buffets/99999999/events
```

##### Códigos de Resposta

200 OK: A solicitação foi bem-sucedida.
404 Not Found: O recurso solicitado não foi encontrado. Ocorre se o buffet específico solicitado não existir. Se o buffet não existir, não será possível consultar seus eventos associados.

#### 2.2 Events | Consulta de Disponibilidade

Este endpoint realiza uma consulta para verificar a disponibilidade para realização de um Evento, dados o id do tipo do evento, a data do evento e a quantidade de convidados.


##### HTTP Request
`GET /api/v1/events/:id/available?event_date=DD/MM/AAAA&qty_invited=100`

Exemplo:
`GET /api/v1/events/1/available?event_date=15/05/2025&qty_invited=100`

###### Parâmetros de Consulta
- `event_date` (string): A data desejada para realização do evento no formato DD/MM/AAAA, YYYY-MM-DD.
- `qty_invited` (integer): A quantidade estimada de convidados para o evento.

##### Responses Format

HTTP/1.1 200 OK
```json
{
	"status": true,
	"total_price": 4500.0
}
```

HTTP/1.1 406 Not Acceptable
`GET /api/v1/events/1/available?event_date=15/05/2024&qty_invited=500`
```json
{
	"status": false,
	"msg": "O evento não pode ser agendado para a data e horário solicitados no Buffet: Tulipas Buffef | O melhor buffet da região Sudeste. Por favor, escolha uma data e horário disponíveis."
}
```

HTTP/1.1 406 Not Acceptable
`GET /api/v1/events/1/available?event_date=06/05/2011&qty_invited=100`
```json
{
	"error": "a data escolhida para realização do evento já passou!"
}
```

HTTP/1.1 406 Not Acceptable
`GET /api/v1/events/1/available?event_date=afadfadf&qty_invited=500`
```json
{
	"error": "a data informada é inválida"
}
```

HTTP/1.1 404 Not Found
`GET /api/v1/events/9999999/available?event_date=15/05/2024&qty_invited=100`

##### Códigos de Resposta

200 OK: A solicitação foi bem-sucedida.

404 Not Found: O recurso solicitado não foi encontrado. Ocorre se o evento específico solicitado não existir.

406 Not Acceptable: A solicitação não pode ser aceita pelo servidor. Ocorre se os parâmetros da solicitação (ex.: a data) não estiverem corretos. Ou devido a restrições específicas do servidor.

## ✍️ Autor

<a href="https://github.com/EmmanuellaAlbuquerque">
  <img style="border-radius: 50%;" src="https://avatars1.githubusercontent.com/u/57198678?s=460&u=18118f08f358d2615421a0694cc00b1c10b8bba0&v=4" width="100px;" alt="eu"/>
</a>

Made with ❤️ by <a href="https://github.com/EmmanuellaAlbuquerque">Manu</a>

:green_heart: Don't believe the hype. Just code. Campus Code.
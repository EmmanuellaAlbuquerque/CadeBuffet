# Cadê Buffet?
> Sistema de gestão de buffets e reservas

## :rocket: Como rodar o projeto?

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

## :computer: Tecnologias Utilizadas

* Ruby version 3.0.0p0
* Rails version 7.1.3.2 
* Bootstrap 5.3.3

## :book: Documentação da API (Cadê Buffet?)

### Endpoints
* [Listagem dos Buffets (GET /api/v1/buffets)](#11-buffets--listagem-dos-buffets)
* [Busca por Buffets (GET /api/v1/buffets?query=value)](#12-buffets--busca-por-buffets)
* [Detalhes de um Buffet (GET /api/v1/buffets/1)](#13-buffets--detalhes-de-um-buffet)
* [Listagem dos Eventos de um Buffet (GET /api/v1/buffets/1/events)](#21-events--listagem-dos-eventos-de-um-buffet)
* [Consulta de Disponibilidade (GET /api/v1/events/1/available?event_date=15/05/2025&qty_invited=100)](#22-events--consulta-de-disponibilidade)

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
		"company_name": "Tulipas Buffef | O melhor buffet da região Sudeste Ltda.",
		"registration_number": "12345678000123",
		"phone": "1129663900",
		"email": "contato@buffettulipas.com.br",
		"address": "Rua Valentim Magalhães, 293",
		"neighborhood": "Alto da Mooca",
		"state": "SP",
		"city": "São Paulo",
		"zipcode": "01234567",
		"description": "O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.",
		"buffet_owner_id": 1
	},
	{
		"id": 2,
		"trading_name": "Caio Cozinha & Eventos",
		"company_name": "Caio Cozinha & Eventos Ltda.",
		"registration_number": "92732949000102",
		"phone": "7723633113",
		"email": "contato@caiocozinha.com",
		"address": "Rua Comendador Bernardo Catarino, 89",
		"neighborhood": "Centro",
		"state": "BA",
		"city": "Salvador",
		"zipcode": "12903834",
		"description": "O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.",
		"buffet_owner_id": 2
	},
	{
		"id": 3,
		"trading_name": "Buffet Espaço Grenah | Gastronomia",
		"company_name": "Buffet Espaço Grenah | Gastronomia Ltda.",
		"registration_number": "00401207000178",
		"phone": "1430298587",
		"email": "contato@grenahgastronomia.com",
		"address": "Rua Azevedo Soares, 633",
		"neighborhood": "Jardim Anália Franco",
		"state": "SP",
		"city": "São Paulo",
		"zipcode": "03322000",
		"description": "Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.",
		"buffet_owner_id": 3
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
`GET /api/v1/buffets?query=value`

Exemplo:
`GET /api/v1/buffets?query=Tulipas`

###### Parâmetros de Consulta

- `query` (string): O parâmetro de consulta usado para filtrar os buffets. O valor fornecido será usado para encontrar buffets que correspondam à consulta.

###### Opções de Consulta
* Filtro por Nome Fantasia
  * Exemplo: `GET /api/v1/buffets?query=Tulipas`
* Filtro por Cidade
  * Exemplo: `GET /api/v1/buffets?query=São Paulo`
* Filtro por Nome do Evento
  * Exemplo: `GET /api/v1/buffets?query=Festa de Casamento`

##### Response Format

HTTP/1.1 200 OK
```json
[
	{
		"id": 1,
		"trading_name": "Tulipas Buffef | O melhor buffet da região Sudeste",
		"company_name": "Tulipas Buffef | O melhor buffet da região Sudeste Ltda.",
		"registration_number": "12345678000123",
		"phone": "1129663900",
		"email": "contato@buffettulipas.com.br",
		"address": "Rua Valentim Magalhães, 293",
		"neighborhood": "Alto da Mooca",
		"state": "SP",
		"city": "São Paulo",
		"zipcode": "01234567",
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
    "phone": "1129663900",
    "email": "contato@buffettulipas.com.br",
    "address": "Rua Valentim Magalhães, 293",
    "neighborhood": "Alto da Mooca",
    "state": "SP",
    "city": "São Paulo",
    "zipcode": "01234567",
    "description": "O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.",
    "buffet_owner_id": 1,
    "payment_methods": [
        {
            "name": "Pix"
        }
    ]
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

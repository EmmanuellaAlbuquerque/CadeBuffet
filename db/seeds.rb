# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

PaymentMethod.create!(name: 'Pix')
PaymentMethod.create!(name: 'Cartão de Crédito')
PaymentMethod.create!(name: 'Cartão de Débito')
PaymentMethod.create!(name: 'Boleto')
PaymentMethod.create!(name: 'Dinheiro')

ServiceOption.create!(name: 'Serviço de Valet')
ServiceOption.create!(name: 'Serviço de Estacionamento')
ServiceOption.create!(name: 'Serviço de Decoração')
ServiceOption.create!(name: 'Distribuição de Bebidas Alcoólicas')

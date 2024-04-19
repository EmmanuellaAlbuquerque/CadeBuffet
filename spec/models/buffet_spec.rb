require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'O Nome Fantasia é obrigatório' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: '', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :trading_name).to be true
        expect(buffet.errors[:trading_name]).to include 'não pode ficar em branco'
      end
  
      it 'A Razão Social é obrigatória' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: '',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :company_name).to be true
        expect(buffet.errors[:company_name]).to include 'não pode ficar em branco'
      end 
      
      it 'O CNPJ é obrigatório' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :registration_number).to be true
        expect(buffet.errors[:registration_number]).to include 'não pode ficar em branco'
      end  
      
      it 'O Telefone é obrigatório' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :phone).to be true
        expect(buffet.errors[:phone]).to include 'não pode ficar em branco'
      end  
      
      it 'O E-mail é obrigatório' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: '', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :email).to be true
        expect(buffet.errors[:email]).to include 'não pode ficar em branco'
      end    
      
      it 'O Endereço é obrigatório' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: '',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :address).to be true
        expect(buffet.errors[:address]).to include 'não pode ficar em branco'
      end  
      
      it 'O Bairro é obrigatório' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: '',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :neighborhood).to be true
        expect(buffet.errors[:neighborhood]).to include 'não pode ficar em branco'
      end    
      
      it 'O Estado é obrigatório' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: '', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors[:state]).to include 'não pode ficar em branco'
        expect(buffet.errors.include? :state).to be true
      end    
      
      it 'A Cidade é obrigatória' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: '',
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :city).to be true
        expect(buffet.errors[:city]).to include 'não pode ficar em branco'
      end 
      
      it 'O CEP é obrigatório' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :zipcode).to be true
        expect(buffet.errors[:zipcode]).to include 'não pode ficar em branco'
      end
      
      it 'A Descrição é obrigatória' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: '',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :description).to be true
        expect(buffet.errors[:description]).to include 'não pode ficar em branco'
      end    
    end

    context 'length' do
      it 'O valor do Estado deve ter apenas 2 caracteres' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'São Paulo', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Reconhecido por sua excelência em serviços de buffet.',
          buffet_owner: buffet_owner
        )
  
        buffet.valid?
        
        expect(buffet.errors.include? :state).to be true
        expect(buffet.errors[:state]).to include 'não possui o tamanho esperado (2 caracteres)'
      end
      
      it 'A Descrição de um Buffet não deve ser maior do que 300 caracteres' do
  
        buffet_owner = BuffetOwner.create!(
          email: 'support@wolfgangpuck.com', 
          password: 'biE@u4&mZ5G3p3')
  
        buffet = Buffet.new(        
          trading_name: 'Wolfgang Puck Catering', 
          company_name: 'Wolfgang Puck Catering Ltd.',
          registration_number: '12345678000190', 
          phone: '551112345678', 
          email: 'contato@pucksgastronomy.com', 
          address: 'Avenida 9 de Julho, 342',
          neighborhood: 'Praça da Bandeira',
          state: 'SP', 
          city: 'São Paulo', 
          zipcode: '01153000',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
          Suspendisse eget facilisis ex. Praesent hendrerit luctus rhoncus. Donec 
          ut bibendum quam, a condimentum sapien. Aliquam fringilla dictum ipsum, 
          vitae posuere lectus aliquam sed. Nulla facilisi. Integer iaculis cursus 
          dolor, id sodales orci nunc atom.',
          buffet_owner: buffet_owner
        )
  
        buffet.valid?
        
        expect(buffet.errors.include? :description).to be true
        expect(buffet.errors[:description]).to include 'é muito longo (máximo: 300 caracteres)'
      end      
    end
  end
end

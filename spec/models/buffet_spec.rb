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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
          description: '',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :description).to be true
        expect(buffet.errors[:description]).to include 'não pode ficar em branco'
      end   
      
      it 'Os Meios de Pagamento são obrigatórios' do
  
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
          zipcode: '06331-060',
          description: '',
          buffet_owner: buffet_owner)
  
        buffet.valid?
        
        expect(buffet.errors.include? :payment_methods).to be true
        expect(buffet.errors[:payment_methods]).to include 'não pode ficar em branco'
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
          zipcode: '06331-060',
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
          zipcode: '06331-060',
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

    context 'CEP é válido' do
      it 'e não deve ter letras' do
        buffet = Buffet.new(zipcode: '589Q0L0P0')
    
        buffet.valid?
        
        expect(buffet.errors.include? :zipcode).to be true
        expect(buffet.errors[:zipcode]).to include 'não é válido, deve ter o formato XXXXX-YYY'
      end

      it 'e deve ser inválido caso esteja no formato errado' do
        buffet = Buffet.new(zipcode: '000-58900')
    
        buffet.valid?
        
        expect(buffet.errors.include? :zipcode).to be true
        expect(buffet.errors[:zipcode]).to include 'não é válido, deve ter o formato XXXXX-YYY'
      end
      
      it 'e deve ser inválido caso tenha mais valores do que o permitido' do
        buffet = Buffet.new(zipcode: '58900-0009')
    
        buffet.valid?
        
        expect(buffet.errors.include? :zipcode).to be true
        expect(buffet.errors[:zipcode]).to include 'não possui o tamanho esperado (9 caracteres)'
      end       

      it 'e deve estar no formato XXXXX-YYY' do
        buffet = Buffet.new(zipcode: '58900-000')
    
        buffet.valid?
        
        expect(buffet.errors.include? :zipcode).to be false
      end
    end 
  end

  describe '.alphabetic_search' do
    it 'retorna buffets específicos em ordem alfabética, considerando o nome fantasia' do
      
      pix = PaymentMethod.create!(name: 'Pix')
  
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

      buffet_c = Buffet.create!(        
        trading_name: 'C', 
        company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
        registration_number: '12345678000123', 
        phone: '1129663900', 
        email: 'contato@buffettulipas.com.br', 
        address: 'Rua Valentim Magalhães, 293',
        neighborhood: 'Alto da Mooca',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '06246-172',
        description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
        buffet_owner: fernando_tulipas,
        payment_methods: [pix]
      )
      
      buffet_b = Buffet.create!(        
        trading_name: 'B', 
        company_name: 'Caio Cozinha & Eventos Ltda.',
        registration_number: '92732949000102', 
        phone: '7723633113', 
        email: 'contato@caiocozinha.com', 
        address: 'Rua Comendador Bernardo Catarino, 89',
        neighborhood: 'Centro',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '06243-250',
        description: 'O Buffet Caio Cozinha & Eventos traz ao seu evento uma proposta gastronômica de primeira linha, preparada e executada com todo carinho, cuidado e qualidade para seu grande dia.',
        buffet_owner: caio_cozinha,
        payment_methods: [pix]
      )      
  
      buffet_a = Buffet.create!(        
        trading_name: 'A', 
        company_name: 'Espaço Grenah | Gastronomia Ltda.',
        registration_number: '00401207000178', 
        phone: '1430298587', 
        email: 'contato@grenahgastronomia.com', 
        address: 'Rua Azevedo Soares, 633',
        neighborhood: 'Jardim Anália Franco',
        state: 'SP', 
        city: 'São Paulo', 
        zipcode: '06240-220',
        description: 'Os profissionais do buffet confeccionam pratos artesanais da alta gastronomia e que agradam a todos os paladares. Para cada evento é preparado um menu personalizado, que reflita as preferências do anfitriões, mas que conquiste a todos os convidados.',
        buffet_owner: grenah_gastronomia,
        payment_methods: [pix]
      )

      ordered_buffets = Buffet.alphabetic_search('São Paulo')

      expect(ordered_buffets).to eq [buffet_a, buffet_b, buffet_c]
    end
  end   
end
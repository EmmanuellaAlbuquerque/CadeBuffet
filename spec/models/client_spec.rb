require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'O Nome do Cliente é obrigatório' do
        client = Client.new(
          name: '',
          itin: '74643026057',
          email: 'manu@contato.com', 
          password: 'ede@6FNQ2Pxm#i$TR'
        )

        client.valid?
        
        expect(client.errors.include? :name).to be true
        expect(client.errors[:name]).to include 'não pode ficar em branco'
      end

      it 'O CPF do Cliente é obrigatório' do
        client = Client.new(
          name: 'Manu',
          itin: '',
          email: 'manu@contato.com', 
          password: 'ede@6FNQ2Pxm#i$TR'
        )

        client.valid?
        
        expect(client.errors.include? :itin).to be true
        expect(client.errors[:itin]).to include 'não pode ficar em branco'
      end     
    end

    context 'uniqueness' do
      it 'O CPF do Cliente deve ser único' do
        Client.create!(
          name: 'Arthur',
          itin: '74643026057',
          email: 'arthur@contato.com', 
          password: 'ede@6FNQ2Pxm#i$TR'
        )
      
        client2 = Client.new(
          name: 'Manu',
          itin: '74643026057',
          email: 'manu@contato.com', 
          password: 'FBC$F4ptfn4Fr!&#r'
        )
      
        client2.valid?
        
        expect(client2.errors.include? :itin).to be true
        expect(client2.errors[:itin]).to include 'já está em uso'
      end       
    end

    it 'CPF deve ser válido' do
      client = Client.new(
        name: 'Arthur',
        itin: '198882380-FT',
        email: 'arthur@contato.com', 
        password: 'ede@6FNQ2Pxm#i$TR'
      )
    
      client.valid?
      
      expect(client.errors.include? :itin).to be true
      expect(client.errors[:itin]).to include 'deve ser válido XXX.XXX.XXX-YY'
    end    
  end
end

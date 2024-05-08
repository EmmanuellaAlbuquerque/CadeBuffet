require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'O nome do evento é obrigatório' do

        event = Event.new(
          name: '',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :name).to be true
        expect(event.errors[:name]).to include 'não pode ficar em branco'
      end

      it 'A descrição do evento é obrigatória' do

        event = Event.new(
          name: 'Festa de formatura',
          description: '',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :description).to be true
        expect(event.errors[:description]).to include 'não pode ficar em branco'
      end
      
      it 'A quantidade mínima de pessoas que podem participar do evento é obrigatória' do

        event = Event.new(
          name: 'Festa de formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: '',
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :qty_min).to be true
        expect(event.errors[:qty_min]).to include 'não pode ficar em branco'
      end  
      
      it 'A quantidade máxima de pessoas que podem participar do evento é obrigatória' do

        event = Event.new(
          name: 'Festa de formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: '',
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :qty_max).to be true
        expect(event.errors[:qty_max]).to include 'não pode ficar em branco'
      end   
      
      it 'A duração do evento é obrigatória' do

        event = Event.new(
          name: 'Festa de formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: '',
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :duration).to be true
        expect(event.errors[:duration]).to include 'não pode ficar em branco'
      end 
      
      it 'O cardápio do evento é obrigatório' do

        event = Event.new(
          name: 'Festa de formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: 180,
          menu: ''
        )

        event.valid?
        
        expect(event.errors.include? :menu).to be true
        expect(event.errors[:menu]).to include 'não pode ficar em branco'
      end       
    end
    
    context 'numericality' do

      it 'A duração do evento deve ser um número maior que zero' do

        event = Event.new(
          name: 'Festa de formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100,
          duration: -240,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?

        expect(event.errors.include? :duration).to be true
        expect(event.errors[:duration]).to include 'deve ser maior que 0'
      end       

      it 'A quantidade mínima de pessoas que podem participar do evento deve ser um número inteiro' do

        event = Event.new(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50.5,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :qty_min).to be true
        expect(event.errors[:qty_min]).to include 'não é um número inteiro'
      end
      
      it 'A quantidade mínima de pessoas que podem participar do evento deve ser um número inteiro maior que zero' do

        event = Event.new(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: -50,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :qty_min).to be true
        expect(event.errors[:qty_min]).to include 'deve ser maior que 0'
      end       

      it 'A quantidade máxima de pessoas que podem participar do evento deve ser um número inteiro' do

        event = Event.new(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: 100.5,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :qty_max).to be true
        expect(event.errors[:qty_max]).to include 'não é um número inteiro'
      end

      it 'A quantidade máxima de pessoas que podem participar do evento deve ser um número inteiro maior que zero' do

        event = Event.new(
          name: 'Festa de Formatura',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 50,
          qty_max: -100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :qty_max).to be true
        expect(event.errors[:qty_max]).to include 'deve ser maior que 0'
      end      
      
      it 'A quantidade máxima de pessoas que podem participar do evento deve maior ou igual a quantidade mínima' do

        event = Event.new(
          name: '',
          description: 'Uma celebração emocionante para marcar o fim de uma jornada educacional e o início de novos horizontes.',
          qty_min: 200,
          qty_max: 100,
          duration: 180,
          menu: 'Prato Principal: Filé Mignon ao molho madeira. Acompanhamentos: Batatas rústicas assadas e Legumes grelhados.',
        )

        event.valid?
        
        expect(event.errors.include? :qty_max).to be true
        expect(event.errors[:qty_max]).to include 'deve ser maior ou igual a 200'
      end
    end
  end  
end

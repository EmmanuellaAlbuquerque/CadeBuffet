require 'rails_helper'

RSpec.describe BasePrice, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'O preço mínimo do evento é obrigatório' do

        base_price = BasePrice.new(
          min_price: '',
          chosen_category_day: 'weekend',
          extra_price_per_person: 100,
          extra_price_per_duration: 150,
        )

        base_price.valid?
        
        expect(base_price.errors.include? :min_price).to be true
        expect(base_price.errors[:min_price]).to include 'não pode ficar em branco'        
      end

      it 'O período para realização do evento é obrigatório' do

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: '',
          extra_price_per_person: 100,
          extra_price_per_duration: 150,
        )

        base_price.valid?
        
        expect(base_price.errors.include? :chosen_category_day).to be true
        expect(base_price.errors[:chosen_category_day]).to include 'não pode ficar em branco'        
      end      

      it 'A taxa adicional por pessoa extra do evento é obrigatória' do

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: '',
          extra_price_per_duration: 150
        )

        base_price.valid?
        
        expect(base_price.errors.include? :extra_price_per_person).to be true
        expect(base_price.errors[:extra_price_per_person]).to include 'não pode ficar em branco'             
      end   
      
      it 'A taxa adicional por hora extra do evento é obrigatória' do

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: 100,
          extra_price_per_duration: '',
        )

        base_price.valid?
        
        expect(base_price.errors.include? :extra_price_per_duration).to be true
        expect(base_price.errors[:extra_price_per_duration]).to include 'não pode ficar em branco'             
      end       
    end

    context 'numericality' do

      it 'O preço mínimo do evento deve ser um número' do

        base_price = BasePrice.new(
          min_price: '',
          chosen_category_day: 'weekend',
          extra_price_per_person: 100,
          extra_price_per_duration: 150,
        )

        base_price.valid?
        
        expect(base_price.errors.include? :min_price).to be true
        expect(base_price.errors[:min_price]).to include 'não é um número'        
      end      

      it 'A taxa adicional por pessoa extra do evento deve ser um número' do

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: '',
          extra_price_per_duration: 150,
        )

        base_price.valid?
        
        expect(base_price.errors.include? :extra_price_per_person).to be true
        expect(base_price.errors[:extra_price_per_person]).to include 'não é um número'             
      end   
      
      it 'A taxa adicional por hora extra do evento deve ser um número' do

        base_price = BasePrice.new(
          min_price: 4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: 100,
          extra_price_per_duration: '',
        )

        base_price.valid?
        
        expect(base_price.errors.include? :extra_price_per_duration).to be true
        expect(base_price.errors[:extra_price_per_duration]).to include 'não é um número'             
      end

      it 'O preço mínimo, a taxa adicional por pessoa e a taxa adicional por hora extra devem ser maiores que zero' do

        base_price = BasePrice.new(
          min_price: -4000,
          chosen_category_day: 'weekdays',
          extra_price_per_person: -100,
          extra_price_per_duration: -200,
        )

        base_price.valid?
        
        expect(base_price.errors.include? :min_price).to be true
        expect(base_price.errors[:min_price]).to include 'deve ser maior que 0'
        expect(base_price.errors.include? :extra_price_per_person).to be true
        expect(base_price.errors[:extra_price_per_person]).to include 'deve ser maior que 0'
        expect(base_price.errors.include? :extra_price_per_duration).to be true
        expect(base_price.errors[:extra_price_per_duration]).to include 'deve ser maior que 0'            
      end      
    end
  end
end

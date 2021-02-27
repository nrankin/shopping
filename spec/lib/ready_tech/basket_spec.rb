# frozen_string_literal: true

require 'ready_tech/item'
require 'ready_tech/basket'

RSpec.describe ReadyTech::Basket do
  let(:items) do
    [
      ReadyTech::Item.new({ quantity: 1, product: 'imported bottle of perfume', price: '27.99' }),
      ReadyTech::Item.new({ quantity: 2, product: 'bottle of perfume', price: '18.99' }),
      ReadyTech::Item.new({ quantity: 1, product: 'packet of headache pills', price: '9.75' }),
      ReadyTech::Item.new({ quantity: 1, product: 'box of imported chocolates', price: '11.25' })
    ]
  end

  let!(:basket) { described_class.new(items) }

  describe '#receipt' do
    it 'creates a receipt' do
      basket.calculate_taxes

      expect(basket.receipt).not_to be_nil
    end

    it 'has a correct total tax' do
      basket.calculate_taxes

      expect(basket.receipt).to include('Sales Taxes: 6.70')
    end

    it 'has a correct total' do
      basket.calculate_taxes

      expect(basket.receipt).to include('Total: 74.68')
    end
  end
end

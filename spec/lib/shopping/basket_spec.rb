# frozen_string_literal: true

require 'shopping/item'
require 'shopping/basket'

RSpec.describe Shopping::Basket do
  let(:items) do
    [
      Shopping::Item.new({ quantity: 1, product: 'imported bottle of perfume', price: '27.99' }),
      Shopping::Item.new({ quantity: 2, product: 'bottle of perfume', price: '18.99' }),
      Shopping::Item.new({ quantity: 1, product: 'packet of headache pills', price: '9.75' }),
      Shopping::Item.new({ quantity: 1, product: 'box of imported chocolates', price: '11.25' })
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

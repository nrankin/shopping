# frozen_string_literal: true

require 'ready_tech/item'
require 'ready_tech/basket'

RSpec.describe ReadyTech::Basket do
  let(:items) do
    [
      ReadyTech::Item.new({ quantity: 1, product: 'sweater', price: '22.34' }),
      ReadyTech::Item.new({ quantity: 2, product: 'books', price: '32.50' }),
      ReadyTech::Item.new({ quantity: 1, product: 'headache pills', price: '12.45' })
    ]
  end

  let(:basket) { described_class.new(items) }

  describe '#receipt' do
    it 'creates a receipt' do
      basket.calculate_taxes
      expect(basket.receipt).not_to be_nil
    end

    it 'has a correct total tax' do
      basket.calculate_taxes
      expect(basket.receipt).to include('Sales Taxes: 3.48')
    end

    it 'has a correct total' do
      basket.calculate_taxes
      expect(basket.receipt).to include('Total: 70.77')
    end
  end
end

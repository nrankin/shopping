# frozen_string_literal: true

require 'ready_tech/item'

RSpec.describe ReadyTech::Item do
  let(:item) { described_class.new({ quantity: 1, product: 'sweater', price: '22.34' }) }

  it 'has access to quantity' do
    expect(item.quantity).to eq(1)
  end

  it 'has access to product' do
    expect(item.product).to eq('sweater')
  end

  it 'has access to price' do
    expect(item.price).to eq(BigDecimal('22.34'))
  end

  describe '#product_type' do
    it 'returns food for apples' do
      item = described_class.new({ quantity: 1, product: 'apples', price: '22.34' })

      expect(item.product_type).to eq('food')
    end

    it 'returns book for books' do
      item = described_class.new({ quantity: 1, product: 'book', price: '22.34' })

      expect(item.product_type).to eq('book')
    end

    it 'returns medical for headache pills' do
      item = described_class.new({ quantity: 1, product: 'headache pills', price: '22.34' })

      expect(item.product_type).to eq('medical')
    end
  end

  describe '#imported?' do
    it 'returns true for imported?' do
      item = described_class.new({ quantity: 1, product: 'imported perfume', price: '22.34' })

      expect(item.imported?).to eq(true)
    end
  end

  it 'produces a correct receipt line' do
    item.tax = item.price * BigDecimal('0.15') # ugh.
    expect(item.receipt_line).to eq("1, sweater, #{item.price_with_tax}")
  end

  pending it 'handles quantities > 1'
  
end

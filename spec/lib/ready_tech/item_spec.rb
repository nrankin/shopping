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
end

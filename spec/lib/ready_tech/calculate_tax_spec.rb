# frozen_string_literal: true

require 'ready_tech/calculate_tax'
require 'bigdecimal'

RSpec.describe ReadyTech::CalculateTax do
  let!(:ten_dollars) { Money.new('1000') }

  it 'calculates tax correctly for regular items' do
    calc = described_class.new(ten_dollars, 'general', false)

    expected_tax = ten_dollars * BigDecimal('.1')

    expect(calc.taxes).to eq(expected_tax)
  end

  it 'calculates tax correctly for exempt items' do
    calc = described_class.new(ten_dollars, 'food', false)

    expected_tax = Money.new('0')

    expect(calc.taxes).to eq(expected_tax)
  end

  it 'applies no tax to medical items that arent imported' do
    price = Money.new('975')
    calc = described_class.new(price, 'medical', false)

    expected_tax = BigDecimal('0.0')
    expect(calc.taxes).to eq(expected_tax)
  end

  describe 'imported items' do
    it 'applies import and base tax rate to non-exempt items' do
      calc = described_class.new(ten_dollars, 'general', true)

      expected_tax = ten_dollars * BigDecimal('.15')

      expect(calc.taxes).to eq(expected_tax)
    end

    it 'applies only imported tax rate to exempt items' do
      calc = described_class.new(ten_dollars, 'book', true)

      expected_tax = ten_dollars * BigDecimal('.05')

      expect(calc.taxes).to eq(expected_tax)
    end

    it 'rounds from 56 up to 60 cents' do
      price = Money.new('1125')
      calc = described_class.new(price, 'food', true)

      expected_tax = Money.new('60')

      expect(calc.taxes).to eq(expected_tax)
    end

    it 'rounds from 13 up to 15 cents' do
      price = Money.new('4750')
      calc = described_class.new(price, 'general', true)

      expected_tax = Money.new('715')

      expect(calc.taxes).to eq(expected_tax)
    end
  end
end

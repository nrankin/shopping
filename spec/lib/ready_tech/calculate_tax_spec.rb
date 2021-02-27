# frozen_string_literal: true

require 'ready_tech/calculate_tax'
require 'bigdecimal'

RSpec.describe ReadyTech::CalculateTax do
  it 'calculates tax correctly for regular items' do
    calc = described_class.new(BigDecimal('10'), 'general', false)

    expected_tax = BigDecimal('10') * BigDecimal('.1')

    expect(calc.taxes).to eq(expected_tax)
  end

  it 'calculates tax correctly for exempt items' do
    calc = described_class.new(BigDecimal('10'), 'food', false)

    expected_tax = BigDecimal('0')

    expect(calc.taxes).to eq(expected_tax)
  end

  describe 'impoted items' do
    it 'applies import and base tax rate to non-exempt items' do
      calc = described_class.new(BigDecimal('10'), 'general', true)

      expected_tax = BigDecimal('10') * BigDecimal('.15')

      expect(calc.taxes).to eq(expected_tax)
    end

    it 'applies only imported tax rate to exempt items' do
      calc = described_class.new(BigDecimal('10'), 'book', true)

      expected_tax = BigDecimal('10') * BigDecimal('.05')

      expect(calc.taxes).to eq(expected_tax)
    end
  end
end

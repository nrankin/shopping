# frozen_string_literal: true

require 'ready_tech/calculate_tax'
require 'bigdecimal'

RSpec.describe ReadyTech::CalculateTax do
  it 'calculates tax correctly for regular items' do
    calc = described_class.new(BigDecimal('10'), 'general')

    expect(calc.taxes).to eq(BigDecimal('1.5'))
  end

  it 'calculates tax correctly for exempt items' do
    calc = described_class.new(BigDecimal('10'), 'book')
    expect(calc.taxes).to eq(BigDecimal('0.5'))
  end
end

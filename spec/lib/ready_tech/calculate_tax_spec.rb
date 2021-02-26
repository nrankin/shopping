# frozen_string_literal: true

require 'ready_tech/calculate_tax'
require 'bigdecimal'

RSpec.describe ReadyTech::CalculateTax do
  it 'calculates tax correctly for regular items' do
    tax = described_class.taxes(BigDecimal('10'))
    expect(tax).to eq(BigDecimal('1.5'))
  end
end

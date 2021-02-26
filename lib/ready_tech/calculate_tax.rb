# frozen_string_literal: true

require 'bigdecimal'

module ReadyTech
  # Calculates and sums taxes appropriate for the item
  class CalculateTax
    BASE_TAX_RATE = BigDecimal('0.1')
    IMPORT_TAX_RATE = BigDecimal('0.05')
    ZERO_TAX = BigDecimal('0')

    def self.taxes(price)
      price * total_tax_rate
    end

    def self.total_tax_rate
      BASE_TAX_RATE + IMPORT_TAX_RATE
    end
  end
end

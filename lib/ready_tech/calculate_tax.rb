# frozen_string_literal: true

require 'bigdecimal'
require 'money'

Money.locale_backend = nil
Money.default_currency = Money::Currency.new('AUD')
Money.rounding_mode = BigDecimal::ROUND_HALF_UP

module ReadyTech
  # Calculates and sums taxes appropriate for the item
  class CalculateTax
    attr_reader :price, :product_type, :is_imported

    BASE_TAX_RATE = BigDecimal('0.1')
    ADDITIONAL_IMPORT_TAX = BigDecimal('0.05')
    ZERO_TAX = BigDecimal('0')

    def initialize(price, product_type, is_imported)
      @price = price
      @product_type = product_type
      @is_imported = is_imported
    end

    def taxes
      price * total_tax_rate
    end

    def total_tax_rate
      base_tax_rate + imported_tax_rate
    end

    def base_tax_rate
      exempt? ? ZERO_TAX : BASE_TAX_RATE
    end

    def imported_tax_rate
      is_imported ? ADDITIONAL_IMPORT_TAX : ZERO_TAX
    end

    def exempt?
      /(book|food|medical)/.match?(product_type)
    end
  end
end

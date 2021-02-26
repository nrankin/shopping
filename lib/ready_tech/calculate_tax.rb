# frozen_string_literal: true

require 'bigdecimal'

module ReadyTech
  # Calculates and sums taxes appropriate for the item
  class CalculateTax
    attr_reader :price, :product_type

    BASE_TAX_RATE = BigDecimal('0.1')
    ADDITIONAL_IMPORT_TAX = BigDecimal('0.05')
    ZERO_TAX = BigDecimal('0')

    def initialize(price, product_type)
      @price = price
      @product_type = product_type
    end

    def taxes
      price * total_tax_rate(product_type)
    end

    def total_tax_rate(_product_type)
      base_tax_rate + imported_tax_rate
    end

    def base_tax_rate
      exempt? ? ZERO_TAX : BASE_TAX_RATE
    end

    def imported_tax_rate
      ADDITIONAL_IMPORT_TAX
    end

    def exempt?
      /(book|food)/.match?(product_type)
    end
  end
end

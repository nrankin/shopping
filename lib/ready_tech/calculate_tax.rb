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
      tax = price * total_tax_rate
      Money.new(special_rounding_to_nearest05(tax))
    end

    def special_rounding_to_nearest05(tax)
      tax_as_cents = (tax * 100).to_i
      last_digit = tax_as_cents.digits[0]
      truncated_tax_as_cents = tax_as_cents.truncate(-1)
      last_digit_replacement = up_to_nearest_divisible_by5(last_digit)
      truncated_tax_as_cents + last_digit_replacement
    end

    def up_to_nearest_divisible_by5(int)
      return int if (int % 5).zero?

      rounded = int.round(-1)
      rounded > int ? rounded : rounded + 5
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

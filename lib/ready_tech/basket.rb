# frozen_string_literal: false

require 'bigdecimal'
require 'money'
require_relative 'calculate_tax'

Money.locale_backend = nil
Money.default_currency = Money::Currency.new('AUD')
Money.rounding_mode = BigDecimal::ROUND_HALF_UP

module ReadyTech
  # A shopping basket containing items
  class Basket
    attr_reader :items, :total_tax, :total_sale

    def initialize(items)
      @items = items
    end

    def calculate_taxes
      @total_tax = Money.new('0')
      @total_sale = Money.new('0')
      items.each do |item|
        calc = CalculateTax.new(item.price, item.product_type, item.imported?)
        item.tax = calc.taxes
        @total_tax += item.tax
        @total_sale += item.price + item.tax
      end
    end

    def total_taxes_string
      Money.new(total_tax, "AUD").format(symbol: false)
    end

    def total_sale_string
      Money.new(total_sale, "AUD").format(symbol: false)
    end

    def receipt
      receipt = ''
      items.each do |item|
        receipt << item.receipt_line << "\n"
      end
      receipt << 'Sales Taxes: ' << total_taxes_string << "\n"
      receipt << 'Total: ' << total_sale_string
      receipt
    end
  end
end

# frozen_string_literal: false

require 'bigdecimal'

BigDecimal.mode(BigDecimal::ROUND_HALF_UP)

module ReadyTech
  # A shopping basket containing items
  class Basket
    attr_reader :items, :total_tax, :total_sale

    def initialize(items)
      @items = items
    end

    def calculate_taxes
      @total_tax = BigDecimal('0')
      @total_sale = BigDecimal('0')
      items.each do |item|
        calc = CalculateTax.new(item.price, item.product_type)
        item.tax = calc.taxes
        @total_tax += item.tax
        @total_sale += item.price + item.tax
      end
    end

    def total_taxes_string
      total_tax.round(2).to_s(' F')
    end

    def total_sale_string
      total_sale.round(2).to_s(' F')
    end

    def receipt
      receipt = ''
      items.each do |item|
        receipt << item.receipt_line << "\n"
      end
      receipt << 'Sales Taxes:' << total_taxes_string << "\n"
      receipt << 'Total:' << total_sale_string
      receipt
    end
  end
end

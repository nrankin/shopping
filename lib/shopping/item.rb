# frozen_string_literal: true

# require 'money'

module Shopping
  # An item represents one product, with it's quantity and price
  class Item
    attr_accessor :row, :tax

    def initialize(row)
      @row = row
    end

    def quantity
      row[:quantity]
    end

    def product
      row[:product].strip
    end

    def product_print
      if imported?
        prod = product.dup
        imported = prod.slice!('imported')
        to_print = imported << ' ' << prod
        return to_print.squeeze
      end
      product
    end

    def price
      price ||= parse_price
    end

    def parse_price
      decimal = BigDecimal(row[:price])
      Money.new(decimal * 100)
    end

    def price_with_tax
      Money.new(price + tax).format(symbol: false)
    end

    def receipt_line
      "#{quantity}, #{product_print}, #{price_with_tax}"
    end

    def product_type
      return 'book' if book?
      return 'food' if food?
      return 'medical' if medical?

      'general'
    end

    def book?
      /book/.match?(product)
    end

    def food?
      /(chocolate|apple)/.match?(product)
    end

    def medical?
      /pills/.match?(product)
    end

    def imported?
      /imported/.match?(product)
    end
  end
end

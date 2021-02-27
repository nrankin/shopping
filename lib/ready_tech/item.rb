# frozen_string_literal: true

require 'bigdecimal'

module ReadyTech
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
      row[:product]
    end

    def price
      BigDecimal(row[:price])
    end

    def price_with_tax
      (price + tax).round(2).to_s(' F')
    end

    def receipt_line
      "#{quantity}, #{product}, #{price_with_tax}"
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

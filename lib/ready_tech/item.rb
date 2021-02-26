# frozen_string_literal: true

require 'bigdecimal'

module ReadyTech
  # An item represents one product, with it's quantity and price
  class Item
    attr_accessor :row

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

    def product_type
      'book' if book?
      'food' if food?
      'medical' if medical?
      'general'
    end

    def book?
      /book/.match?(product)
    end

    def food?
      /(chocolate)/.match?(product)
    end

    def medical?
      /pills/.match?(product)
    end
  end
end

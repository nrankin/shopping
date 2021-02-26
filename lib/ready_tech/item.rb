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
  end
end

# frozen_string_literal: false

module ReadyTech
  # A shopping basket containing items
  class Basket
    attr_reader :items

    def initialize(items)
      @items = items
    end

    def calculate_taxes
      items.each do |item|
        calc = CalculateTax.new(item.price, item.product_type)
        item.tax = calc.taxes
      end
    end

    def receipt
      receipt = ''
      items.each do |item|
        receipt << item.receipt_line << "\n"
      end
      # receipt << basket_taxes
      # receipt << basket_total
      receipt
    end
  end
end

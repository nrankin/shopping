# frozen_string_literal: true

require_relative 'shopping/csv_importer'
require_relative 'shopping/basket'

module Shopping
  class Shopping
    def self.process_baskets
      Dir.glob(files_to_import).each do |file_path|
        basket = import_basket(file_path)

        basket.calculate_taxes

        print basket.receipt
        print "\n\n"
      end

      'success'
    end

    def self.import_basket(file_path)
      items = CsvImporter.import(file_path)
      Basket.new(items)
    end

    def self.files_to_import
      File.join('data', '*.csv')
    end
  end
end

Shopping::Shopping.process_baskets

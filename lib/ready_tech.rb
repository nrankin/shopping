# frozen_string_literal: true

module ReadyTech
  # Processes baskets: imports from csv, calculates tax, and prints reciepts
  class ReadyTech
    def self.process_baskets
      Dir.glob(files_to_import).each do |file_path|
        # import one basket
        items = CsvImporter.import(file_path)
        # calculate taxes
        items.each do |item|
          calc = CalculateTax.new(item.price, item.product_type)
          item.tax = calc.taxes
        end
        # print reciepts
      end

      'success'
    end

    def self.files_to_import
      File.join('data', '*.csv')
    end
  end
end

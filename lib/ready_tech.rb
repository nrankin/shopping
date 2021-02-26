# frozen_string_literal: true

module ReadyTech
  # Processes baskets: imports from csv, calculates tax, and prints reciepts
  class ReadyTech
    def self.process_baskets
      # import baskets
      Dir.glob(files_to_import).each do |file_path|
        items = CsvImporter.import(file_path)
      end
      # calculate taxes
      # print reciepts
      'success'
    end

    def self.files_to_import
      File.join('data', '*.csv')
    end
  end
end

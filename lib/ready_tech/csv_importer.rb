# frozen_string_literal: true

require 'csv'
require_relative 'item'

module ReadyTech
  # Imports csv files representing shopping baskets of items
  class CsvImporter
    def self.import(file_path)
      items = []
      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        items << Item.new(row)
      end
      items
    end
  end
end

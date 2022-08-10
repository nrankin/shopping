# frozen_string_literal: true

require 'shopping/csv_importer'

RSpec.describe Shopping::CsvImporter do
  it 'imports data' do
    expect { described_class.import('data/input1.csv') }.not_to raise_error
  end

  describe 'imported items' do
    let(:items) { described_class.import('data/input1.csv') }

    it 'imports correct number of items' do
      expect(items.count).to eq(3)
    end
  end
end

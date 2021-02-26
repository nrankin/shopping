# frozen_string_literal: true

require 'ready_tech/csv_importer'

RSpec.describe ReadyTech::CsvImporter do
  it 'imports data' do
    expect { described_class.import('data/input1.csv') }.not_to raise_error
  end

  it 'imports correct number of items' do
    items = described_class.import('data/input1.csv')
    expect(items.count).to eq(3)
  end
end

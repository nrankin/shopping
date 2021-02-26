# frozen_string_literal: true

require 'ready_tech'

RSpec.describe ReadyTech::ReadyTech do
  it 'doesnt raise an error' do
    expect { described_class.process_baskets }.not_to raise_error
  end

  it 'prints a success message' do
    message = described_class.process_baskets
    expect(message).to eq('success')
  end
end

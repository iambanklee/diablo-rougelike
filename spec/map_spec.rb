# frozen_string_literal: true

require 'rspec'
require 'map'

RSpec.describe Map do
  describe 'You can move between the rooms using some keyboard inputs'

  describe '.new' do
    let(:new_map) { described_class.new(rows: x, cols: y) }

    let(:x) { 4 }
    let(:y) { 3 }

    it 'generates map by given size' do
      expect(new_map.map[x - 1][y - 1]).to be_nil
      expect { new_map.map[x][y] }.to raise_error(NoMethodError)
    end
  end

  describe '#start' do
    subject(:enter) { map.start }
    let(:map) { described_class.new(rows: 3, cols: 3) }

    it 'go to first room' do
      subject

      expect(map.map[0][0]).to eq(map.current_room)
    end
  end
end

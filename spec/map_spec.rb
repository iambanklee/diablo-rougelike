# frozen_string_literal: true

require 'rspec'
require 'map'

RSpec.xdescribe Map do
  describe '.new' do
    let(:new_map) { described_class.new(rows: x, cols: y) }

    let(:x) { 4 }
    let(:y) { 3 }

    it 'generates map by given size' do
      expect(new_map.map[x - 1][y - 1]).to be_nil
      expect { new_map.map[x][y] }.to raise_error(NoMethodError)
    end
  end

  describe '#enter' do
    subject(:enter) { map.enter(x, y) }
    let!(:map) { described_class.new(rows: 4, cols: 3) }

    let(:x) { 2 }
    let(:y) { 2 }

    it 'enter the room' do
      subject

      expect(map.map[x][y]).to eq(true)
      expect(map.map[0][0]).to be_nil
    end
  end
end

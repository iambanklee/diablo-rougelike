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

  describe '#go_north' do
    subject(:go_north) { map.go_north }
    let(:map) { described_class.new(rows: 3, cols: 3) }

    it 'go north' do
      subject

      expect(map.current_room).to eq(map.map[0][1])
    end
  end

  describe '#go_direction' do
    subject(:go_north) { map.go_direction(direction: direction) }
    let(:map) { described_class.new(rows: 3, cols: 3) }

    context 'when direction is North' do
      let(:direction) { Map::NORTH }

      it 'goes North' do
        subject

        expect(map.current_room).to eq(map.map[0][1])
      end
    end

    context 'when direction is South' do
      let(:direction) { Map::SOUTH }

      context 'when no room at South' do
        it 'stays at current room' do
          subject

          expect(map.current_room).to eq(map.map[0][0])
        end
      end
    end

    context 'when direction is West' do
      let(:direction) { Map::WEST }

      it 'goes West' do
        map.go_direction(direction: Map::EAST)
        map.go_direction(direction: Map::NORTH)

        subject

        expect(map.current_room).to eq(map.map[0][1])
      end

      context 'when no room at West' do
        it 'stays at current room' do
          subject

          expect(map.current_room).to eq(map.map[0][0])
        end
      end
    end

    context 'when direction is East' do
      let(:direction) { Map::EAST }

      it 'goes East' do
        subject

        expect(map.current_room).to eq(map.map[1][0])
      end
    end
  end
end

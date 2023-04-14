# frozen_string_literal: true

require 'rspec'
require 'map'

RSpec.describe Map do
  describe '.new' do
    let(:new_map) { described_class.new(rows: x, cols: y) }

    let(:x) { 4 }
    let(:y) { 3 }

    it 'generates map by given size' do
      expect { new_map.rooms[x][y] }.to raise_error(NoMethodError)
    end

    it 'set final room' do
      expect(new_map.final_room).to eq(new_map.rooms[x - 1][y - 1])
    end
  end

  describe '#start' do
    subject(:map_start) { map.start(player:) }
    let(:map) { described_class.new(rows: 3, cols: 3) }
    let(:player) { Character.new(name: 'Player', character_class: 'Barbarian', hp: 200, damage: 100) }

    before do
      allow(Kernel).to receive(:gets).and_return('D', 'X', 'W', 'A', 'W', 'D', 'S', 'D', 'W')
      allow(Kernel).to receive(:rand).and_return(200)

      stub_const('Room::ROOM_PREFIX_MODIFIERS', ['old'])
      stub_const('Room::ROOM_MODIFIERS', ['medieval'])
      stub_const('Room::ROOM_LOCATIONS', ['castle'])
    end

    it 'goes through all rooms in the map' do
      expect { map_start }.to output(
        <<~OUTPUT

          You entered the room 0-0.
          You are in a room look like old medieval castle
          What do you do?
          [W] Go North
          [D] Go East
          Go East

          You entered the room 1-0.
          You are in a room look like old medieval castle
          What do you do?
          [W] Go North
          [A] Go West
          [D] Go East

          [X] isn't in the options
          What do you do?
          [W] Go North
          [A] Go West
          [D] Go East
          Go North

          You entered the room 1-1.
          You are in a room look like old medieval castle
          What do you do?
          [W] Go North
          [A] Go West
          [D] Go East
          [S] Go South
          Go West

          You entered the room 0-1.
          You are in a room look like old medieval castle
          What do you do?
          [W] Go North
          [D] Go East
          [S] Go South
          Go North

          You entered the room 0-2.
          You are in a room look like old medieval castle
          What do you do?
          [D] Go East
          [S] Go South
          Go East

          You entered the room 1-2.
          You are in a room look like old medieval castle
          What do you do?
          [A] Go West
          [D] Go East
          [S] Go South
          Go South

          You entered the room 1-1.
          You are in a room look like old medieval castle
          What do you do?
          [W] Go North
          [A] Go West
          [D] Go East
          [S] Go South
          Go East

          You entered the room 2-1.
          You are in a room look like old medieval castle
          What do you do?
          [W] Go North
          [A] Go West
          [S] Go South
          Go North

          You entered the room FINAL.
          You are in a room look like old medieval castle

          You have encountered an enemy: BOSS
          Battle started!
          Player attacked BOSS, caused 100 damages
          BOSS HP: 0
          Player has won the battle with 200 HP left
        OUTPUT
      ).to_stdout
    end
  end

  describe '#action_menu' do
    subject(:action_menu) { map.action_menu }
    let(:map) { described_class.new(rows: 3, cols: 3) }

    it 'returns actionable item of current room' do
      expect(action_menu).to eq("[W] Go North\n[D] Go East")
    end
  end

  describe '#action_items' do
    subject(:action_items) { map.action_items }
    let(:map) { described_class.new(rows: 3, cols: 3) }

    it 'returns actionable item of current room' do
      expect(action_items.map(&:input)).to match_array(%w[W D])
    end
  end

  describe '#available_directions' do
    subject(:available_directions) { map.available_directions }
    let(:map) { described_class.new(rows: 3, cols: 3) }

    it 'returns available directions of current room' do
      expect(available_directions).to match_array([Map::NORTH, Map::EAST])
    end
  end

  describe '#go_direction' do
    subject(:go_north) { map.go_direction(direction:) }
    let(:map) { described_class.new(rows: 3, cols: 3) }

    context 'when direction is North' do
      let(:direction) { Map::NORTH }

      it 'goes North' do
        subject

        expect(map.current_room).to eq(map.rooms[0][1])
      end
    end

    context 'when direction is South' do
      let(:direction) { Map::SOUTH }

      context 'when no room at South' do
        it 'stays at current room' do
          subject

          expect(map.current_room).to eq(map.rooms[0][0])
        end
      end
    end

    context 'when direction is West' do
      let(:direction) { Map::WEST }

      it 'goes West' do
        map.go_direction(direction: Map::EAST)
        map.go_direction(direction: Map::NORTH)

        subject

        expect(map.current_room).to eq(map.rooms[0][1])
      end

      context 'when no room at West' do
        it 'stays at current room' do
          subject

          expect(map.current_room).to eq(map.rooms[0][0])
        end
      end
    end

    context 'when direction is East' do
      let(:direction) { Map::EAST }

      it 'goes East' do
        subject

        expect(map.current_room).to eq(map.rooms[1][0])
      end
    end
  end
end

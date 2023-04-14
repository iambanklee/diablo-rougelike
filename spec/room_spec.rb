# frozen_string_literal: true

require 'rspec'
require 'room'

RSpec.describe Room do
  describe '.new' do
    subject(:new_room) { Room.new(name:, event_rate:) }

    let(:name) { 'Room A' }
    let(:event_rate) { -1 }

    it 'creates room by given name' do
      expect(new_room.name).to eq(name)
    end

    it 'sets room modifiers' do
      expect(new_room.description).to match(Regexp.new(Room::ROOM_PREFIX_MODIFIERS.join('|')))
      expect(new_room.description).to match(Regexp.new(Room::ROOM_MODIFIERS.join('|')))
      expect(new_room.description).to match(Regexp.new(Room::ROOM_LOCATIONS.join('|')))
    end
  end

  describe '#start' do
    subject(:enter_room) { room.start(player:) }

    let(:player) { Character.new(name: 'Player', character_class: 'Barbarian', hp: 200, damage: 100) }
    let(:room) { Room.new(name:, event_rate:) }
    let(:name) { 'Room A' }

    context 'when there is no event in the room' do
      let(:event_rate) { -1 }

      it 'output welcome message' do
        expect { enter_room }.to output(/You entered the room #{name}/).to_stdout
        expect(room.completed?).to eq(true)
      end

      it 'output room details' do
        expect { enter_room }.to output(Regexp.new(room.description)).to_stdout
        expect(room.completed?).to eq(true)
      end
    end

    context 'when there is event in the room' do
      let(:event_rate) { 1000 }

      before do
        stub_const('Challenge::CHALLENGE_OPERATORS', ['/'])
        allow(Random).to receive(:rand).and_return(67, 8)
        allow(Kernel).to receive(:gets).and_return('8')
      end

      it 'marks the room completed after challenge solved' do
        expect { enter_room }.to output(%r{67 / 8.*Challenge completed!}m).to_stdout

        expect(room.completed?).to eq(true)
      end
    end
  end
end

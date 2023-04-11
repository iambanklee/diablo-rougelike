# frozen_string_literal: true

require 'rspec'
require 'room'

RSpec.describe Room do
  describe '.new' do
    subject(:new_room) { Room.new(name: name) }

    let(:name) { 'Room A' }

    it 'creates room by given name' do
      expect(new_room.name).to eq(name)
    end

    it 'sets room modifiers' do
      expect(new_room.description).to match(Regexp.new(Room::ROOM_PREFIX_MODIFIERS.join('|')))
      expect(new_room.description).to match(Regexp.new(Room::ROOM_MODIFIERS.join('|')))
      expect(new_room.description).to match(Regexp.new(Room::ROOM_LOCATIONS.join('|')))
    end
  end

  describe '#enter' do
    subject(:enter_room) { room.enter }

    let(:room){ Room.new(name: name) }
    let(:name) { 'Room A' }

    it 'output welcome message' do
      expect { enter_room }.to output(/You entered the room #{name}/).to_stdout
    end

    it 'output room details' do
      expect { enter_room }.to output(Regexp.new(room.description)).to_stdout
    end
  end

  describe 'There could be some events in the rooms'
  describe 'You need to fight a final enemy'
end

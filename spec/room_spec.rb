# frozen_string_literal: true

require 'rspec'
require 'room'

RSpec.describe Room do
  describe 'A brief English sentence describes the room where you enter (ex. “You are in front of an old medieval castle…”)'

  describe '.new' do
    subject(:new_room) { Room.new(name: name) }

    let(:name) { 'Room A' }

    it 'creates room by given name' do
      expect(new_room.name).to eq(name)
    end
  end

  describe 'There could be some events in the rooms'
  describe 'You need to fight a final enemy'
end

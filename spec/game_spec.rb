# frozen_string_literal: true

require 'rspec'
require 'game'

RSpec.describe 'Game' do
  describe 'A brief English sentence describes the room where you enter (ex. “You are in front of an old medieval castle…”)'

  describe 'There should be at least 4 different rooms'
  describe 'There could be some events in the rooms'
  describe 'You need to fight a final enemy'
  describe 'A help section for the commands is necessary'

  describe '#start' do
    subject(:game_start) { game.start }
    let(:game) { Game.new }
    let(:map) { Map.new(rows: 3,cols: 3) }
    let(:room) { instance_double('Room', name: 'Room A', enter: true) }

    context 'when map is cleared' do
      before do
        allow(Map).to receive(:new).and_return(map)
        allow(map).to receive(:start).and_return(room)
        allow(room).to receive(:enter)
        allow(map).to receive(:current_room).and_return(room)
        allow(map).to receive(:cleared?).and_return(false, true)

        allow(Kernel).to receive(:gets).and_return('Bank', 'Mage', '1')
      end

      it 'prints game result' do
        expect { game_start }.to output(/Diablo Rougelike/).to_stdout
      end
      it 'prints game result' do
        expect { game_start }.to output(/Greetings travellers/).to_stdout
      end
      it 'prints game result' do
        expect { game_start }.to output(/Let's go for a run!/).to_stdout
      end
      it 'prints game result' do
        expect { game_start }.to output(/you are going/).to_stdout
      end
      it 'prints game result' do
        expect { game_start }.to output(/Game over/).to_stdout
      end
    end
  end
end

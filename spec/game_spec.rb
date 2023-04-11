# frozen_string_literal: true

require 'rspec'
require 'game'

RSpec.describe 'Game' do
  describe 'There should be at least 4 different rooms'
  describe 'A help section for the commands is necessary'

  describe '#start' do
    subject(:game_start) { game.start }
    let(:game) { Game.new }

    context 'when win condition achieved' do
      before do
        allow(Kernel).to receive(:gets).and_return('Bank', 'Mage', 'D', 'W', 'A', 'W', 'D', 'S', 'D', 'W')
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

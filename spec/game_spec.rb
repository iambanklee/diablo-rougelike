# frozen_string_literal: true

require 'rspec'
require 'game'

RSpec.describe 'Game' do
  describe 'A help section for the commands is necessary'

  describe '#start' do
    subject(:game_start) { game.start }
    let(:game) { Game.new }

    before do
      allow(Kernel).to receive(:gets).and_return('Bank', 'Sorcerer', 'D', 'X', 'help', 'W', 'A', 'W', 'D', 'S', 'D', 'W')
      allow(Kernel).to receive(:rand).and_return(200)

      stub_const('Room::ROOM_PREFIX_MODIFIERS', ['old'])
      stub_const('Room::ROOM_MODIFIERS', ['medieval'])
      stub_const('Room::ROOM_LOCATIONS', ['castle'])
    end

    context 'when win condition achieved' do
      it 'prints game result' do
        expect { game_start }.to output(
          <<~OUTPUT

            ========== Diablo Rougelike ==========

            Greetings adventurer, what's your name?

            Bank, what class do you want to play this time?
            There are 3 classes you can choose from: Barbarian, Sorcerer and Rouge
            Sorcerer - great choice! Let's go for a run!

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
            #{Game::HELP_TEXT.chomp}
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
            Bank attacked BOSS, caused 50 damages
            BOSS HP: 50
            BOSS attacked Bank, caused 20 damages
            Bank HP: 80
            Bank attacked BOSS, caused 50 damages
            BOSS HP: 0
            Bank has won the battle with 80 HP left
            Congratulations Bank, you have won the game by using Sorcerer
          OUTPUT
        ).to_stdout
      end
    end

    context 'when lose condition met' do
      before do
        expect(game).to receive(:win?).and_return(false)
      end

      it 'Game Over' do
        expect { game_start }.to output(/Game Over/).to_stdout
      end
    end
  end
end

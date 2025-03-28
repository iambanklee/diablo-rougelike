# frozen_string_literal: true

require 'rspec'
require 'battle'

RSpec.describe 'Battle' do
  describe 'You need to fight a final enemy'

  describe '#start' do
    subject(:battle_start) { battle.start }

    let(:battle) { Battle.new(player:, enemy: boss) }
    let(:player) { Character.new(name: 'Player', character_class: 'Rouge', hp: 100, damage: 30) }
    let(:boss) { Character.new(name: 'BOSS', character_class: 'Monster', hp: 50, damage: 25) }

    context 'when player wins the battle' do
      it 'returns the battle result' do
        expect { battle_start }.to output(
          <<~OUTPUT

            You have encountered an enemy: BOSS
            Battle started!
            Player attacked BOSS, caused 30 damages
            BOSS HP: 20
            BOSS attacked Player, caused 25 damages
            Player HP: 75
            Player attacked BOSS, caused 30 damages
            BOSS HP: -10
            Player has won the battle with 75 HP left
          OUTPUT
        ).to_stdout

        expect(battle.winner).to eq(player)
        expect(battle.completed?).to eq(true)
      end
    end

    context 'when boss wins the battle' do
      let(:boss) { Character.new(name: 'BOSS', character_class: 'Monster', hp: 500, damage: 50) }
      it 'returns the battle result' do
        expect { battle_start }.to output(
          <<~OUTPUT

            You have encountered an enemy: BOSS
            Battle started!
            Player attacked BOSS, caused 30 damages
            BOSS HP: 470
            BOSS attacked Player, caused 50 damages
            Player HP: 50
            Player attacked BOSS, caused 30 damages
            BOSS HP: 440
            BOSS attacked Player, caused 50 damages
            Player HP: 0
            BOSS has won the battle with 440 HP left
          OUTPUT
        ).to_stdout

        expect(battle.winner).to eq(boss)
        expect(battle.completed?).to eq(true)
      end
    end
  end
end

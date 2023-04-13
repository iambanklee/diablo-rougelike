# frozen_string_literal: true

require 'rspec'
require 'character'

RSpec.describe Character do
  subject(:character_attack) { character.attack(other) }

  let(:character) { Character.new(name: 'Player', character_class: 'Rouge', hp: 100, damage: 10) }
  let(:other) { Character.new(name: 'BOSS', character_class: 'Monster', hp: 50, damage: 20) }

  it 'attacks other and reduces their HP' do
    expect { character_attack }.to output(
      <<~OUTPUT
        Player attacked BOSS, caused 10 damages
        BOSS HP: 40
      OUTPUT
    ).to_stdout
  end
end

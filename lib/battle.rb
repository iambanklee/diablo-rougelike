# frozen_string_literal: true

require_relative 'completable'
require_relative 'character'

# Represents an auto battle system of 2 characters
class Battle
  include Completable

  attr_reader :player, :enemy, :winner

  def initialize(player:, enemy:)
    @player = player
    @enemy = enemy
    @winner = nil
  end

  def start
    puts
    puts "You have encountered an enemy: #{enemy.name}"
    puts 'Battle started!'

    attack_sequence = [player, enemy]

    until completed?
      attacker = attack_sequence.shift
      receiver = attack_sequence.shift
      attack_sequence << receiver
      attack_sequence << attacker

      attacker.attack(receiver)
      if receiver.hp <= 0
        @winner = attacker
        break
      end
    end

    result
    mark_as_completed
  end

  private

  def result
    puts "#{winner.name} has won the battle with #{winner.hp} HP left"
  end
end

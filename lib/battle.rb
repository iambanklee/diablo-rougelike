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
    print_start_message

    auto_battle until completed?

    print_result
  end

  private

  def auto_battle
    attacker = attack_sequence.shift
    receiver = attack_sequence.shift
    attack_sequence.push(receiver).push(attacker)

    attacker.attack(receiver)
    return unless receiver.hp <= 0

    @winner = attacker
    mark_as_completed
  end

  def attack_sequence
    @attack_sequence ||= [player, enemy]
  end

  def print_result
    puts "#{winner.name} has won the battle with #{winner.hp} HP left"
  end

  def print_start_message
    puts
    puts "You have encountered an enemy: #{enemy.name}"
    puts 'Battle started!'
  end
end

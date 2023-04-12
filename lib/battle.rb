# frozen_string_literal: true

require_relative 'character'

class Battle
  attr_reader :player, :enemy

  def initialize(player:, enemy:)
    @player = player
    @enemy = enemy
    @winner = nil
    @completed = false
  end

  def completed?
    @completed
  end

  def start
    until completed?
      player.attack(enemy)
      if enemy.hp <= 0
        @winner = player
        break
      end

      enemy.attack(player)
      if player.hp <= 0
        @winner = enemy
        break
      end
    end

    result
    @completed = true
  end

  private

  def result
    puts "#{@winner.name} has won the battle with #{@winner.hp} HP left"
  end
end

# frozen_string_literal: true

# Represents either player or NPC/enemy
class Character
  attr_reader :name, :character_class, :damage
  attr_accessor :hp

  def initialize(name:, character_class:, hp:, damage:) # rubocop:disable Naming/MethodParameterName
    @name = name
    @character_class = character_class
    @hp = hp
    @damage = damage
  end

  def attack(other)
    puts "#{name} attacked #{other.name}, caused #{damage} damages"
    other.hp -= damage
    puts "#{other.name} HP: #{other.hp}"
  end
end

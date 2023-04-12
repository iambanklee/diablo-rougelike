# frozen_string_literal: true

class Character
  attr_reader :name, :damage
  attr_accessor :hp

  def initialize(name:, hp:, damage:)
    @name = name
    @hp = hp
    @damage = damage
  end

  def attack(other)
    puts "#{name} attacked #{other.name}, caused #{damage} damages"
    other.hp -= damage
    puts "#{other.name} HP: #{other.hp}"
  end
end

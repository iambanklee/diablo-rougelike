# frozen_string_literal: true
require_relative 'map'

class Game
  attr_reader :map, :player_name, :player_class
  def initialize
    @map = Map.new(rows: 3, cols: 3)
  end

  def start
    puts
    puts "========== Diablo Rougelike =========="
    puts
    puts "Greetings travellers, what's your name?"
    @player_name = Kernel.gets.chomp

    puts "#{player_name}, what class do you want to play this time?"
    @player_class = Kernel.gets.chomp

    puts "#{player_class} - great choice! Let's go for a run!"

    room = @map.start

    until map.cleared?
      room.enter

      begin
        puts "[0] Go up"
        puts "[1] Go left"
        puts "[2] Go down"
        puts "[3] Go right"
        puts "where do you go?"
        move_direction = Kernel.gets.chomp
      end until move_direction.match(/[0-9]/)

      puts "you are going #{move_direction}"

      case move_direction
      when '0'
        @map.go_north
      when '1'
        @map.go_left
      when '2'
        @map.go_down
      when '3'
        @map.go_right
      end

      room = @map.current_room
    end

    puts 'Game over'
  end
end

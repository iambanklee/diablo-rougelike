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

      if room == @map.final_room
        # TODO: final boss
        map.cleared = true
        next
      end

      begin
        puts "[W] Go North"
        puts "[A] Go West"
        puts "[S] Go South"
        puts "[D] Go East"
        puts "where do you go?"
        move_direction = Kernel.gets.chomp
      end until move_direction.match(/[WASD]/)

      puts "you are going #{move_direction}"

      case move_direction
      when 'W'
        @map.go_direction(direction: Map::NORTH)
      when 'A'
        @map.go_direction(direction: Map::WEST)
      when 'S'
        @map.go_direction(direction: Map::SOUTH)
      when 'D'
        @map.go_direction(direction: Map::EAST)
      end

      room = @map.current_room
    end

    puts 'Game over'
  end
end

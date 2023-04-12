# frozen_string_literal: true
require_relative 'map'
require_relative 'character'

class Game
  attr_reader :map, :player

  CLASS_LIST = {
    'Barbarian' => {
      hp: 200,
      damage: 15,
    },
    'Sorcerer' => {
      hp: 100,
      damage: 50,
    },
    'Rouge' => {
      hp: 150,
      damage: 35,
    },
  }.freeze

  def initialize
    @map = Map.new(rows: 3, cols: 3)
  end

  def start
    puts
    puts "========== Diablo Rougelike =========="
    puts
    puts "Greetings adventurer, what's your name?"
    player_name = Kernel.gets.chomp

    puts "#{player_name}, what class do you want to play this time?"
    player_class = ''

    until CLASS_LIST[player_class]
      puts "There are #{CLASS_LIST.keys.size} classes you can choose from: #{CLASS_LIST.keys.join(', ')}"
      player_class = Kernel.gets.chomp
    end

    puts "#{player_class} - great choice! Let's go for a run!"

    @player = Character.new(name: player_name,
                            hp: CLASS_LIST[player_class][:hp],
                            damage: CLASS_LIST[player_class][:damage])

    room = @map.start

    until map.cleared?
      room.enter

      if room == @map.final_room
        # TODO: final boss
        map.cleared = true
        next
      end

      begin
        map.display_action_menu
        puts "where do you go?"
        move_direction = Kernel.gets.chomp
      end until move_direction.match(Regexp.new(map.action_items.map { |action| action.key }.join('|')))

      puts "you are going #{move_direction}"
      map.action_items.detect { |item| item.key == move_direction }.execute(map)

      room = @map.current_room
    end

    puts 'Game over'
  end
end

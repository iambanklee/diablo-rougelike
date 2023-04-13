# frozen_string_literal: true

require_relative 'battle'
require_relative 'character'
require_relative 'map'

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

  CLASS_OPTIONS = CLASS_LIST.keys.freeze

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
      puts "There are #{CLASS_OPTIONS.size} classes you can choose from: #{CLASS_OPTIONS.join(', ')}"
      player_class = Kernel.gets.chomp
    end

    puts "#{player_class} - great choice! Let's go for a run!"

    @player = Character.new(name: player_name,
                            hp: CLASS_LIST[player_class][:hp],
                            damage: CLASS_LIST[player_class][:damage])

    until map.completed?
      room = map.current_room
      room.enter

      if room == map.final_room
        boss = Character.new(name: 'BOSS', hp: 100, damage: 20)
        battle = Battle.new(player: player, enemy: boss)
        battle.start

        if battle.completed? && room.completed?
          map.mark_as_completed
          next
        end
      end

      begin
        map.display_action_menu
        puts "where do you go?"
        move_direction = Kernel.gets.chomp
      end until move_direction.match(Regexp.new(map.action_items.map { |action| action.key }.join('|')))

      puts "you are going #{move_direction}"
      map.action_items.detect { |item| item.key == move_direction }.execute(map)
    end

    if battle.winner == player
      puts "Congratulations #{player.name}, you have won the game by using #{player_class}"
    else
      puts "Game Over"
    end
  end
end

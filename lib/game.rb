# frozen_string_literal: true

require_relative 'battle'
require_relative 'character'
require_relative 'map'

# The main entry point of game. Controls game flow and player inputs
class Game
  attr_reader :map, :player

  CLASS_LIST = {
    'Barbarian' => {
      hp: 200,
      damage: 15
    },
    'Sorcerer' => {
      hp: 100,
      damage: 50
    },
    'Rouge' => {
      hp: 150,
      damage: 35
    }
  }.freeze

  CLASS_OPTIONS = CLASS_LIST.keys.freeze
  CLASS_OPTIONS_TEXT = "#{CLASS_OPTIONS.first(CLASS_OPTIONS.size - 1).join(', ')} and #{CLASS_OPTIONS.last}"

  def initialize
    @map = Map.new(rows: 3, cols: 3)
  end

  def start
    puts
    puts '========== Diablo Rougelike =========='
    puts
    puts "Greetings adventurer, what's your name?"
    player_name = Kernel.gets.chomp

    puts
    puts "#{player_name}, what class do you want to play this time?"
    player_class = ''

    until CLASS_LIST[player_class]
      puts "There are #{CLASS_OPTIONS.size} classes you can choose from: #{CLASS_OPTIONS_TEXT}"
      player_class = Kernel.gets.chomp
    end

    puts "#{player_class} - great choice! Let's go for a run!"

    @player = Character.new(name: player_name,
                            character_class: player_class,
                            hp: CLASS_LIST[player_class][:hp],
                            damage: CLASS_LIST[player_class][:damage])

    until map.completed?
      room = map.current_room
      room.enter

      if room == map.final_room
        boss = Character.new(name: 'BOSS', character_class: 'Monster', hp: 100, damage: 20)
        battle = Battle.new(player: player, enemy: boss)
        battle.start

        if battle.completed? && room.completed?
          map.mark_as_completed
          next
        end
      end

      action_input = ''
      loop do
        puts 'What do you do?'
        map.display_action_menu
        action_input = Kernel.gets.chomp
        if action_input.match(Regexp.new(map.action_items.map(&:key).join('|')))
          break
        else
          puts
          puts "[#{action_input}] isn't in the options"
        end
      end

      puts "you are going #{action_input}"
      map.action_items.detect { |item| item.key == action_input }.execute(map)
    end

    if battle.winner == player
      puts "Congratulations #{player.name}, you have won the game by using #{player.character_class}"
    else
      puts 'Game Over'
    end
  end
end

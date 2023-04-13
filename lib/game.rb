# frozen_string_literal: true

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
    prepare_player

    map.start(player: player) { |action_input| process_input(action_input) }

    display_game_result
  end

  private

  def print_title
    puts
    puts '========== Diablo Rougelike =========='
    puts
  end

  def prepare_player
    print_title
    player_name = player_name_input

    puts
    puts "#{player_name}, what class do you want to play this time?"
    player_class = player_class_input

    puts "#{player_class} - great choice! Let's go for a run!"

    @player = Character.new(name: player_name,
                            character_class: player_class,
                            hp: CLASS_LIST[player_class][:hp],
                            damage: CLASS_LIST[player_class][:damage])
  end

  def player_name_input
    puts "Greetings adventurer, what's your name?"
    Kernel.gets.chomp
  end

  def player_class_input
    player_class = ''

    until CLASS_LIST[player_class]
      puts "There are #{CLASS_OPTIONS.size} classes you can choose from: #{CLASS_OPTIONS_TEXT}"
      player_class = Kernel.gets.chomp
    end

    player_class
  end

  def process_input(input)
    processed = false

    if input.match(/help/i)
      display_help_menu
      processed = true
    end

    processed
  end

  def display_help_menu
    puts 'Help menu'
  end

  def display_game_result
    if player.hp.positive?
      puts "Congratulations #{player.name}, you have won the game by using #{player.character_class}"
    else
      puts 'Game Over'
    end
  end
end

# frozen_string_literal: true

require_relative 'battle'
require_relative 'character'
require_relative 'room'

# Represents the overview of rooms and responsible for moving around rooms
class Map
  include Completable

  NORTH = [0, 1].freeze
  SOUTH = [0, -1].freeze
  WEST = [-1, 0].freeze
  EAST = [1, 0].freeze
  DIRECTIONS = [NORTH, WEST, EAST, SOUTH].freeze
  DIRECTION_MAPPING = {
    NORTH => {
      input: 'W',
      text: 'Go North'
    },
    WEST => {
      input: 'A',
      text: 'Go West'
    },
    SOUTH => {
      input: 'S',
      text: 'Go South'
    },
    EAST => {
      input: 'D',
      text: 'Go East'
    }
  }.freeze

  ActionItem = Struct.new(:input, :text, :action) do
    def execute(*arg)
      action&.call(*arg)
    end
  end

  attr_reader :rooms, :rows, :cols, :current_room, :current_x, :current_y, :final_room

  def initialize(rows:, cols:)
    @rooms = Array.new(rows) { Array.new(cols) }
    @rows = rows
    @cols = cols
    @current_x = 0
    @current_y = 0
    @cleared = false

    set_entry_point
    set_final_point
  end

  def start(player:)
    until completed?
      current_room.enter

      final_battle(player: player) if current_room == final_room
      break if completed?

      loop do
        display_action_menu

        action_input = Kernel.gets.chomp
        next if action_input.empty?

        if block_given?
          processed = yield action_input # pass back to game for input checking
          next if processed
        end

        if action_input.match(Regexp.new(action_items.map(&:input).join('|')))
          action_item = action_items.detect { |item| item.input == action_input }
          puts action_item.text
          action_item.execute
          break
        else
          puts
          puts "[#{action_input}] isn't in the options"
        end
      end
    end
  end

  def display_action_menu
    puts 'What do you do?'
    puts action_menu
  end

  def action_menu
    action_items.map { |action| "[#{action.input}] #{action.text}" }.join("\n")
  end

  def action_items
    available_directions.map do |direction|
      item = DIRECTION_MAPPING[direction]
      ActionItem.new(item[:input], item[:text], -> { go_direction(direction: direction) })
    end
  end

  def available_directions
    DIRECTIONS.select { |direction| valid_direction?(direction: direction) }
  end

  def go_direction(direction:)
    return unless valid_direction?(direction: direction)

    @current_x += direction.first
    @current_y += direction.last
    rooms[current_x][current_y] ||= Room.new(name: "#{current_x}-#{current_y}")
    set_current_room
  end

  private

  def set_entry_point
    @rooms[current_x][current_y] = Room.new(name: "#{current_x}-#{current_y}")
    set_current_room
  end

  def set_final_point
    @final_room = Room.new(name: 'FINAL')
    @rooms[rows - 1][cols - 1] = @final_room
  end

  def set_current_room
    @current_room = rooms[current_x][current_y]
  end

  def valid_direction?(direction:)
    adjacent_x = current_x + direction.first
    adjacent_y = current_y + direction.last

    (adjacent_x >= 0 && adjacent_x <= rows - 1) && (adjacent_y >= 0 && adjacent_y <= cols - 1)
  end

  def final_battle(player:)
    boss = Character.new(name: 'BOSS', character_class: 'Monster', hp: 100, damage: 20)
    battle = Battle.new(player: player, enemy: boss)
    battle.start

    mark_as_completed if battle.completed?
  end
end

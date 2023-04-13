# frozen_string_literal: true

require_relative 'room'

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
    },
  }

  ActionItem = Struct.new(:key, :value, :action) do
    def execute(*arg)
      action.call(*arg) if action
    end
  end

  attr_reader :rooms, :rows, :cols,
              :current_room, :current_x, :current_y, :final_room

  attr_accessor :cleared

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

  def start
    current_room
  end

  def display_action_menu
    puts action_menu
  end

  def action_menu
    action_items.map { |action| "[#{action.key}] #{action.value}" }.join("\n")
  end

  def action_items
    actions = []

    available_directions.each do |direction|
      item = DIRECTION_MAPPING[direction]
      actions << ActionItem.new(item[:input], item[:text], ->(map) { map.go_direction(direction: direction) } )
    end

    actions
  end

  def available_directions
    DIRECTIONS.select do |direction|
      adjacent_x = @current_x + direction.first
      adjacent_y = @current_y + direction.last

      (adjacent_x >= 0 && adjacent_x <= rows - 1) && (adjacent_y >= 0 && adjacent_y <= cols - 1)
    end
  end

  def go_direction(direction:)
    adjacent_x = @current_x + direction.first
    adjacent_y = @current_y + direction.last

    if (adjacent_x >= 0 && adjacent_x <= rows - 1) && (adjacent_y >= 0 && adjacent_y <= cols - 1)
      rooms[adjacent_x][adjacent_y] ||= Room.new(name: "#{adjacent_x}-#{adjacent_y}")

      @current_x = adjacent_x
      @current_y = adjacent_y
      set_current_room
    end
  end

  private

  def set_entry_point
    @rooms[current_x][current_y] = Room.new(name: "#{current_x}-#{current_y}")
    set_current_room
  end

  def set_final_point
    @rooms[rows - 1][cols - 1] ||= Room.new(name: "#{rows - 1}-#{cols - 1}")
    @final_room = @rooms[rows - 1][cols - 1]
  end

  def set_current_room
    @current_room = rooms[current_x][current_y]
  end
end

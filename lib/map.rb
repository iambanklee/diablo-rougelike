# frozen_string_literal: true

require_relative 'room'

class Map
  NORTH = [0, 1].freeze
  SOUTH = [0, -1].freeze
  WEST = [-1, 0].freeze
  EAST = [1, 0].freeze
  DIRECTIONS = [NORTH, WEST, EAST, SOUTH].freeze

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

  def cleared?
    @cleared
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

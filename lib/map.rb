# frozen_string_literal: true

class Map
  NORTH = [0, 1].freeze
  SOUTH = [0, -1].freeze
  WEST = [-1, 0].freeze
  EAST = [1, 0].freeze
  DIRECTIONS = [NORTH, WEST, EAST, SOUTH].freeze

  attr_reader :rooms, :rows, :cols,
              :current_room, :current_x, :current_y

  # TODO: Extract
  Room = Struct.new(:name) do
    def enter
      puts "Enter #{name}"
    end
  end

  def initialize(rows:, cols:)
    @rooms = Array.new(rows) { Array.new(cols) }
    @rows = rows
    @cols = cols
    @current_x = 0
    @current_y = 0

    set_entry_point
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
      rooms[adjacent_x][adjacent_y] ||= Room.new("#{adjacent_x}-#{adjacent_y}")

      @current_x = adjacent_x
      @current_y = adjacent_y
      set_current_room
    end
  end

  private

  def set_entry_point
    @rooms[current_x][current_y] = Room.new("#{current_x}-#{current_y}")
    set_current_room
  end

  def set_current_room
    @current_room = rooms[current_x][current_y]
  end
end

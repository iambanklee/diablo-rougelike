# frozen_string_literal: true

class Map
  NORTH = [0, 1].freeze
  SOUTH = [0, -1].freeze
  WEST = [-1, 0].freeze
  EAST = [1, 0].freeze
  DIRECTIONS = [NORTH, WEST, EAST, SOUTH].freeze

  attr_reader :map, :rows, :cols,
              :current_room, :current_x, :current_y

  # TODO: Extract
  Room = Struct.new(:name) do
    def enter
      puts "Enter #{name}"
    end
  end

  def initialize(rows:, cols:)
    @map = Array.new(rows) { Array.new(cols) }
    @rows = rows
    @cols = cols

    set_entry_point
  end

  def start
    current_room
  end

  def cleared?
    @cleared
  end

  def go_north
    adjacent_y = current_y + NORTH.last

    if adjacent_y >= 0 && adjacent_y <= cols - 1
      map[current_x][adjacent_y] ||= Room.new("#{current_x}-#{adjacent_y}")

      @current_y = adjacent_y
      @current_room = @map[current_x][current_y]
    end
  end

  def go_left
  end

  def go_down
  end

  def go_right
  end

  private

  def set_entry_point
    @current_x = 0
    @current_y = 0

    @map[@current_x][@current_y] = Room.new("#{@current_x}-#{@current_y}")
    @current_room = @map[current_x][current_x]
  end
end

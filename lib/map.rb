# frozen_string_literal: true

class Map
  attr_reader :map, :current_room

  # TODO: Extract
  Room = Struct.new(:name) do
    def enter
      puts "Enter #{name}"
    end
  end

  def initialize(rows:, cols:)
    @map = Array.new(rows) { Array.new(cols) }

    set_entry_point
  end

  def start
    current_room
  end

  def cleared?
    @cleared
  end

  def go_up
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
    @current_room = @map[@current_x][@current_y]
  end
end

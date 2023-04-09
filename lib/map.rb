# frozen_string_literal: true

class Map
  attr_reader :map

  def initialize(rows:, cols:)
    @map = Array.new(rows) { Array.new(cols) }
  end

  def enter(x, y)
    @map[x][y] = true # TODO: replace with Room.new
  end
end

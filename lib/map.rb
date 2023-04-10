# frozen_string_literal: true

class Map
  attr_reader :map

  def initialize(rows:, cols:)
    @map = Array.new(rows) { Array.new(cols) }
  end

  def start
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
end

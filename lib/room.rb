# frozen_string_literal: true

class Room
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def enter
    puts "room #{name}"
  end
end

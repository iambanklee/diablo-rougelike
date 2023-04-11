# frozen_string_literal: true

class Room
  attr_reader :name

  ROOM_PREFIX_MODIFIERS = %w[old new terrible scary light warm].freeze
  ROOM_MODIFIERS = %w[medieval cyberpunk stoneage darkside].freeze
  ROOM_LOCATIONS = %w[castle dungeon room barrier].freeze

  def initialize(name:)
    @name = name
  end

  def enter
    print "You entered the room #{name}."
    puts description
  end

  def description
    @description ||= "You are in a room look like #{room_prefix_modifier} #{room_modifier} #{room_location}"
  end

  private

  def room_prefix_modifier
    @room_prefix_modifier ||= ROOM_PREFIX_MODIFIERS.sample
  end

  def room_modifier
    @room_modifier ||= ROOM_MODIFIERS.sample
  end

  def room_location
    @room_location ||= ROOM_LOCATIONS.sample
  end
end

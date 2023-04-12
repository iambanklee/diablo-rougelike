# frozen_string_literal: true

require_relative 'challenge'

class Room
  attr_reader :name, :event_rate, :event

  ROOM_PREFIX_MODIFIERS = %w[old new terrible scary light warm].freeze
  ROOM_MODIFIERS = %w[medieval cyberpunk stoneage darkside].freeze
  ROOM_LOCATIONS = %w[castle dungeon room barrier].freeze

  def initialize(name:, event_rate: 50)
    @name = name
    @event_rate = event_rate
    @completed = false

    initialize_challenge
  end

  def enter
    puts "You entered the room #{name}."
    puts description
    event.start if event
    @completed = true
  end

  def description
    @description ||= "You are in a room look like #{room_prefix_modifier} #{room_modifier} #{room_location}"
  end

  def completed?
    @completed
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

  def initialize_challenge
    @event ||= event_rate >= Kernel.rand(100) ? Challenge.new : nil
  end
end

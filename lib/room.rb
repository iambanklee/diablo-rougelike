# frozen_string_literal: true

require_relative 'completable'
require_relative 'challenge'
require_relative 'character'

# Represents every room that player can travel around.
# Based on RNG, a room might contain challenge for player to resolve or a enemy to fight
class Room
  include Completable

  attr_reader :name, :event_rate, :event, :enemy

  ROOM_PREFIX_MODIFIERS = %w[old new terrible scary light warm].freeze
  ROOM_MODIFIERS = %w[medieval cyberpunk stoneage darkside].freeze
  ROOM_LOCATIONS = %w[castle dungeon room barrier].freeze

  def initialize(name:, event_rate: 50, enemy: nil)
    @name = name
    @event_rate = event_rate
    @enemy = enemy

    initialize_challenge
  end

  def start(player:)
    puts
    puts "You entered the room #{name}."
    puts description

    until completed?
      start_battle(player: player) if enemy
      is_final_room = yield if block_given?

      event&.start unless is_final_room
      mark_as_completed
    end
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

  def initialize_challenge
    @event = event_rate >= Kernel.rand(100) ? Challenge.new : nil
  end

  def start_battle(player:)
    battle = Battle.new(player: player, enemy: enemy)
    battle.start
  end
end

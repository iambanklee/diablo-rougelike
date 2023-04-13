# frozen_string_literal: true

# Extend class to be completable
module Completable
  def completed?
    return @completed if defined? @completed

    @completed = false
  end

  def mark_as_completed
    @completed = true
  end
end

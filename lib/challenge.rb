# frozen_string_literal: true

require_relative 'completable'

class Challenge
  include Completable

  CHALLENGE_OPERATORS = %w[+ - * /].freeze

  def formula
    @formula ||= "#{Random.rand(100)} #{CHALLENGE_OPERATORS.sample} #{Random.rand(100)}"
  end

  def expected_result
    @expected_result ||= eval(formula)
  end

  def start
    until completed?
      puts 'You need to solve this challenge before you can go anywhere'
      puts formula
      input = Kernel.gets.chomp

      if correct_answer?(input)
        mark_as_completed
        puts 'Challenge completed!'
      end
    end
  end

  private

  def correct_answer?(input)
    return true if input == formula # for cheating purpose on complex calculations lol

    input == expected_result.to_s
  end
end

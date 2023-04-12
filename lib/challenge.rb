# frozen_string_literal: true

class Challenge
  CHALLENGE_OPERATORS = %w[+ - * /].freeze

  def initialize
    @completed = false
  end

  def formula
    @formula ||= "#{Random.rand(100)} #{CHALLENGE_OPERATORS.sample} #{Random.rand(100)}"
  end

  def expected_result
    @expected_result ||= eval(formula)
  end

  def completed?
    @completed
  end

  def start
    until completed?
      puts 'You need to solve this challenge before you can go anywhere'
      puts formula
      input = Kernel.gets.chomp

      if input == expected_result.to_s
        @completed = true
        puts 'Challenge completed!'
      end
    end
  end
end

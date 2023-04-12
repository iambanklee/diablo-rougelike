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
end

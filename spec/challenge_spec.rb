# frozen_string_literal: true

require 'rspec'
require 'challenge'

RSpec.describe Challenge do
  describe '.new' do
    subject(:new_Challenge) { Challenge.new }

    it 'generate an random event' do
      allow(Random).to receive(:rand).and_return(50, 20)
      stub_const('Challenge::CHALLENGE_OPERATORS', ['-'])

      event = new_Challenge

      expect(event.formula).to eq('50 - 20')
      expect(event.expected_result).to eq(30)
      expect(event.completed?).to eq(false)
    end
  end
end

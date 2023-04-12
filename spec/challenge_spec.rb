# frozen_string_literal: true

require 'rspec'
require 'challenge'

RSpec.describe Challenge do
  describe '.new' do
    subject(:new_challenge) { Challenge.new }

    it 'generate an random event' do
      allow(Random).to receive(:rand).and_return(50, 20)
      stub_const('Challenge::CHALLENGE_OPERATORS', ['-'])

      event = new_challenge

      expect(event.formula).to eq('50 - 20')
      expect(event.expected_result).to eq(30)
      expect(event.completed?).to eq(false)
    end
  end

  describe '#start' do
    subject(:challenge_start) { challenge.start }

    let(:challenge) { Challenge.new }

    context 'when challenge solved' do
      before do
        stub_const('Challenge::CHALLENGE_OPERATORS', ['*'])
        allow(Random).to receive(:rand).and_return(5, 15)
        allow(Kernel).to receive(:gets).and_return('100', '75')
      end

      it 'marks the challenge completed' do
        expect{ challenge_start }.to output(<<~OUTPUT
          You need to solve this challenge before you can go anywhere
          5 * 15
          You need to solve this challenge before you can go anywhere
          5 * 15
          Challenge completed!
          OUTPUT
        ).to_stdout
        expect(challenge.completed?).to eq(true)
      end
    end
  end
end

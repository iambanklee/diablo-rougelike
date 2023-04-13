# frozen_string_literal: true

require 'rspec'
require 'completable'


RSpec.describe Completable do
  describe '.included' do
    class DummyGame
    end

    subject(:completable_included) do
      class DummyGame
        include Completable
      end
    end

    let(:dummy_instance) { DummyGame.new }

    it 'extends the class to be completable' do
      expect { dummy_instance.completed? }.to raise_error(NoMethodError)

      completable_included

      expect(dummy_instance.completed?).to eq(false)

      dummy_instance.mark_as_completed

      expect(dummy_instance.completed?).to eq(true)
    end
  end
end
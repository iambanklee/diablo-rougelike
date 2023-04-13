# frozen_string_literal: true

require 'rspec'
require 'completable'

RSpec.describe Completable do
  describe '.included' do
    let(:dummy_class) { Class.new { include Completable } }
    let(:dummy_instance) { dummy_class.new }

    it 'extends the class to be completable' do
      expect { Class.new.completed? }.to raise_error(NoMethodError)

      expect(dummy_instance.completed?).to eq(false)
      dummy_instance.mark_as_completed
      expect(dummy_instance.completed?).to eq(true)
    end
  end
end

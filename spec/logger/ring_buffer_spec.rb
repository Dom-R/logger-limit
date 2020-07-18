# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RingBuffer do
  describe '.new' do
    it 'creates a buffer of type Array' do
      buffer = described_class.new

      buffer_type = buffer.instance_variable_get('@buffer').class

      expect(buffer_type).to eq Array
    end

    context 'when total_size argument is defined' do
      it 'limits the total size of the buffer to the passed value' do
        buffer = described_class.new(total_size: 5)

        6.times { |value| buffer.add(value) }

        buffer_content = buffer.flush

        expect(buffer_content.size).to eq 5
      end
    end

    context 'when total_size argument is not defined' do
      it 'limits the total size of the buffer to 20' do
        buffer = described_class.new

        21.times { |value| buffer.add(value) }

        buffer_content = buffer.flush

        expect(buffer_content.size).to eq 20
      end
    end
  end

  describe '#flush' do
    context 'when buffer has no objects' do
      it 'returns empty array' do
        buffer = described_class.new

        buffer_content = buffer.flush

        expect(buffer_content).to eq []
      end
    end

    context 'when buffer has objects' do
      it 'returns the objects of the buffer' do
        buffer = described_class.new

        buffer.add(1)
        buffer.add(2)

        buffer_content = buffer.flush

        expect(buffer_content).to eq [1, 2]
      end
    end

    it 'clears the buffer' do
      buffer = described_class.new

      buffer.add(1)

      buffer_content = buffer.flush

      expect(buffer_content).to eq [1]

      buffer_content = buffer.flush

      expect(buffer_content).to eq []
    end
  end

  describe '#add' do
    it 'add object to buffer' do
      buffer = described_class.new

      buffer.add(5)

      buffer_content = buffer.flush

      expect(buffer_content).to eq [5]
    end

    context 'when buffer is full' do
      it 'removes the oldest object and add object to buffer' do
        buffer = described_class.new(total_size: 2)

        buffer.add(1)
        buffer.add(2)
        buffer.add(3)

        buffer_content = buffer.flush

        expect(buffer_content).to eq [2, 3]
      end
    end
  end
end

# frozen_string_literal: true

class RingBuffer
  def initialize(total_size: 20)
    @buffer = []
    @total_size = total_size
  end

  def add(object)
    @buffer.shift if @buffer.size == @total_size

    @buffer.push object
  end

  def flush
    objects = @buffer.clone
    @buffer.clear

    objects
  end
end

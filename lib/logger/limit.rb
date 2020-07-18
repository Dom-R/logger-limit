# frozen_string_literal: true

require 'logger'
require 'logger/limit/version'
require 'logger/limit/ring_buffer'

class Logger
  module Limit
    @@storage = RingBuffer.new # rubocop:disable Style/ClassVars

    def add(*args, &block)
      severity = args.first

      if severity < Logger::ERROR
        @@storage.add({ args: args, block: block })
      else
        @@storage.flush.each do |stored_log|
          super(*stored_log[:args], &stored_log[:block])
        end

        clear_stored_logs

        super
      end
    end

    module_function

    def clear_stored_logs
      @@storage.flush
    end
  end

  prepend Logger::Limit
end

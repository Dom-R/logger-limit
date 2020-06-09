# frozen_string_literal: true

require 'logger'
require 'logger/limit/version'

class Logger
  module Limit
    @@storage = [] # rubocop:disable Style/ClassVars

    def add(*args, &block)
      severity = args.first

      if severity < Logger::ERROR
        @@storage << { args: args, block: block }
      else
        @@storage.each do |stored_log|
          super(*stored_log[:args], &stored_log[:block])
        end

        clear_stored_logs

        super
      end
    end

    module_function

    def clear_stored_logs
      @@storage.clear
    end
  end

  prepend Logger::Limit
end

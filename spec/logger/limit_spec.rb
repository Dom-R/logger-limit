# frozen_string_literal: true

RSpec.describe Logger::Limit do
  let(:stub_output_class) do
    Class.new do
      class << self
        def write(message); end

        def close; end
      end
    end
  end

  it 'has a version number' do
    expect(Logger::Limit::VERSION).to eq '0.1.0'
  end

  context 'when there is no log of severity ERROR or higher' do
    after do
      Logger::Limit.clear_stored_logs
    end

    it 'supresses all log messages' do
      allow(stub_output_class).to receive(:write).and_call_original

      logger = Logger.new(stub_output_class)

      logger.debug { 'A debug log' }
      logger.info 'A info log'
      logger.warn('foo') { 'A warn log' }
      logger.add(Logger::INFO) { 'A info log' }

      expect(stub_output_class).not_to have_received(:write)
    end
  end

  context 'when there is a log of severity ERROR or higher' do
    after do
      Logger::Limit.clear_stored_logs
    end

    it 'outputs all stored logs and the error log' do
      allow(stub_output_class).to receive(:write).and_call_original

      logger = Logger.new(stub_output_class)

      logger.debug { 'A debug log' }
      logger.info 'A info log'
      logger.warn('foo') { 'A warn log' }
      logger.add(Logger::ERROR) { 'A  log' }

      expect(stub_output_class).to have_received(:write).exactly(4).times
    end
  end
end

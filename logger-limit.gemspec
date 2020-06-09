# frozen_string_literal: true

require_relative 'lib/logger/limit/version'

Gem::Specification.new do |spec|
  spec.name          = 'logger-limit'
  spec.version       = Logger::Limit::VERSION
  spec.authors       = ['Dominik Reller']
  spec.email         = ['Dom-R@users.noreply.github.com']

  spec.summary       = 'This gem changes Logger behaviour to only output previous log messages when a log of ERROR severity or higher occurs.' # rubocop:disable Layout/LineLength
  spec.description   = 'This gem changes Logger behaviour to only output previous log messages when a log of ERROR severity or higher occurs. This gem is an implementation based on the idea proposed by the following blog post: https://www.komu.engineer/blogs/log-without-losing-context/log-without-losing-context' # rubocop:disable Layout/LineLength
  spec.homepage      = 'https://www.github.com/Dom-R/logger-limit'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://www.github.com/Dom-R/logger-limit'
  spec.metadata['changelog_uri'] = 'https://www.github.com/Dom-R/logger-limit/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'logger'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end

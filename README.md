# Logger::Limit

Logger::Limit changes [Logger](https://github.com/ruby/logger) behavior to only output previous log messages when a log of ERROR severity or higher occurs.

This gem is an implementation based on the idea proposed by the following blog post: https://www.komu.engineer/blogs/log-without-losing-context/log-without-losing-context

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logger-limit'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install logger-limit

## Usage

**WARNING**: The current version of `logger-limit` does not correctly support parallelism due to how messages are saved. Basic tests with `Process` and `Thread` show that `Process.fork` seems to work correctly.

All you need to do is require `logger-limit` on your application:

```ruby
require 'logger/limit'
```

By requiring this gem, you are monkey patching `Logger` to store every log message with severity lower than `Logger::ERROR`. Once a log of severity `Logger::ERROR` or higher happens, all the stored messages will become visible in the correct order.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Dom-R/logger-limit.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

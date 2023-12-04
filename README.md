# FailingSpecDetector
  A rspec extension introdusing a custom formatter, to detect failing specs and group them by exception.

### Output Example
> log.txt:

```txt
Failing spec detector:
Test Exception 1:

/spec/one_spec.rb:11:in `some_method':
/spec/two_spec.rb:20:in `some_method':



Test Exception 2:

/spec/one_spec.rb:14:in `some_method':
/spec/three_spec.rb:4:in `some_method':



Test Exception 3:

/spec/three_spec.rb:4:in `some_method':



----------------------------------------------------------------
```
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'failing_spec_detector', github: 'nebulab/failing_spec_detector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install failing_spec_detector

## Usage

Add this lines to your application's .rspec file:

```ruby
  --require failing_spec_detector/failing_spec_formatter.rb
  --format FailingSpecDetector::FailingSpecFormatter
```

And run your test suite:

    $ rspec spec

Or run your test suite using this command:

    $ rspec spec --require failing_spec_detector/failing_spec_formatter.rb --format FailingSpecDetector::FailingSpecFormatter

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nebulab/failing_spec_detector/issues.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

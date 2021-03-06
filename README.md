# Yodlee [![Build Status](https://travis-ci.org/AquilaLoans/yodlee-ruby.svg?branch=develop)](https://travis-ci.org/AquilaLoans/yodlee-ruby) [![Maintainability](https://api.codeclimate.com/v1/badges/adc029c5a680adf8ca72/maintainability)](https://codeclimate.com/github/AquilaLoans/yodlee-ruby/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/adc029c5a680adf8ca72/test_coverage)](https://codeclimate.com/github/AquilaLoans/yodlee-ruby/test_coverage) [![Dependency Status](https://gemnasium.com/badges/github.com/AquilaLoans/yodlee-ruby.svg)](https://gemnasium.com/github.com/AquilaLoans/yodlee-ruby)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yodlee'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yodlee

## Usage

### Sessions
Yodlee requires that cobrand and user respective sessions to be rotated every 100 and 30 minutes. In order to service this requirement this gem makes no assumption about the use of these sessions and provides an objective interface starting with the `Cobrand` object.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AquilaLoans/yodlee-ruby.

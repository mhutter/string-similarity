# String::Similarity [![Build Status](https://travis-ci.org/mhutter/string-similarity.svg)](https://travis-ci.org/mhutter/string-similarity)

Library for calculating the similarity of two strings.

## State

- Cosine: **done**
- Hamming: _todo_
- Levenshtein: _todo_

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'string-similarity'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install string-similarity

## Usage

```ruby
require 'string-similarity'

# Call the methods on the module
String::Similarity.cosine 'foo', 'bar'
# => 0.0
String::Similarity.cosine 'mine', 'thyne'
# => 0.4472135954999579
String::Similarity.cosine 'foo', 'foo'
# => 1.0

# or call on a string directly
'string'.cosine_similarity_to 'strong'
# => 0.8333333333333335
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/string-similarity.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# String::Similarity

[![Gem Version](https://badge.fury.io/rb/string-similarity.svg)](http://badge.fury.io/rb/string-similarity)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://rubydoc.org/gems/string-similarity/frames)
[![Build Status](https://travis-ci.org/mhutter/string-similarity.svg)](https://travis-ci.org/mhutter/string-similarity)
[![Code Climate](https://codeclimate.com/github/mhutter/string-similarity/badges/gpa.svg)](https://codeclimate.com/github/mhutter/string-similarity)
[![Test Coverage](https://codeclimate.com/github/mhutter/string-similarity/badges/coverage.svg)](https://codeclimate.com/github/mhutter/string-similarity/coverage)

Library for calculating the similarity of two strings.

## State

- [x] Cosine
- [ ] Hamming
- [x] Levenshtein

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


# Same for Levenshtein:
String::Similarity.levenshtein_distance('kitten', 'sitting') # or ...
'kitten'.levenshtein_distance_to('sitting')
# => 3
String::Similarity.levenshtein('foo', 'far') # or ...
'far'.levenshtein_similarity_to('foo')
# => 0.5
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

1. Fork it ( https://github.com/mhutter/string-similarity/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


Bug reports and pull requests are welcome on GitHub at https://github.com/mhutter/string-similarity.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

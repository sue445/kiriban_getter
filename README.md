# Kiriban
Check number whether **Kiriban (キリ番)**

Add `#kiriban?`, `#kuraiban?` and `#zorome?` methods to `Integer`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kiriban'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kiriban

## Usage
```ruby
require "kiriban"

using Kiriban
```

### #kiriban? (キリ番?)
`#kiriban?` is `#kuraiban?` or `#zorome?`

```ruby
100.kiriban?
#=> true

101.kiriban?
#=> false

111.kiriban?
#=> true
```

### #kuraiban? (位番?)
```ruby
100.kuraiban?
#=> true

101.kuraiban?
#=> false

111.kuraiban?
#=> false

2000.kuraiban?
#=> true
```

### #zorome? (ゾロ目?)
```ruby
111.zorome?
#=> true

2222.zorome?
#=> true

2223.zorome?
#=> false
```

Also aliased as: `#repdigit?`, `#monodigit?`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Benchmark
run [benchmark/kiriban.rb](benchmark/kiriban.rb)

```sh
bundle exec ruby benchmark/kiriban.rb
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/kiriban.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


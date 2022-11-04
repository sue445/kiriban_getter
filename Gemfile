source 'https://rubygems.org'

# Specify your gem's dependencies in kiriban_getter.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.5.0")
  # NOTE: unparser v0.3.0+ requires Ruby 2.5+
  gem "unparser", "< 0.3.0"

  # NOTE: docile v1.4.0+ requires Ruby 2.5+
  gem "docile", "< 1.4.0"

  # NOTE: simplecov v0.19.0+ requires Ruby 2.5+
  gem "simplecov", "< 0.19.0"
end

# Iora

Issue Oracle

This gem interfaces with external issue repositories, extracts issue data and
emits a Bugmark-compatible hash.

```ruby
# Iora.new(<repo_type>, "repo_id")
repo = Iora.new(:github, "bugmark/exchange")
repo.issues          #> an array with a hash for each issue
repo.issue("<exid>") #> a hash with data for one issue
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iora', github: "andyl/iora"
```

And then execute:

    $ bundle
    
## Details

Valid repo types are `:github` and `:test`.

Repo credentials are stored in a hash:
`{github: {name: "name", pass: "pass"}, test: {name: "name", pass: "pass"}}`

Here are the options for specifying repo credentials:
1) as an optional hash during object creation 
  `Iora.new(<repo_type>, <repo_id>, {credentials})`
2) as a yaml file in the current directory `./.iora_credentials.yaml`
3) as a yaml file in your home directory `~/.iora_credentials.yaml`

If `name` or `pass` is not found, an exception is raised.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andyl/iora.

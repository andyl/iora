# Iora

Bugmark Issue Oracle (`pronounced 'eye-ora'`)

This gem interfaces with issue sources, extracts issue data and
emits a Bugmark-compatible hash.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iora', github: 'bugmark/iora'
```

And then execute:

    $ bundle
    
## Details

Valid repo types are `:github` and `:yaml`.

Repo credentials are stored in a hash:
   
```ruby
{
   github: {username: "name", password: "pass"}, 
   yaml: {} # no credentials needed for YAML 
}
```

Here are the options for specifying repo credentials (in priority order):

1) as an optional parameter during object creation 

    `Iora.new(<repo_type>, <repo_id>, [{credentials hash}])`
  
2) as a yaml file in the current directory `./.iora_rc.yml`
3) as a yaml file in your home directory `~/.iora_rc.yml`

### Github Issue Repository

Use `Iora` to pull issues from any Github repository.
Specify the Github repo path `<user_name>/<repo_name>`. (eg
`bugmark/iora`)

```ruby
repo = Iora.new(:github, "bugmark/exchange")
repo.issues          #> an array with a hash for each issue
repo.issue("<exid>") #> a hash with data for one issue
```

### Yaml Issue Repository

For testing, you can store issue data in a YAML file.  

```ruby
repo = Iora.new(:yaml, "~/issue_data.yml")
repo.issues          #> an array with a hash for each issue
repo.issue("<exid>") #> a hash with data for one issue
```

See the `data` directory for sample issue files.

## Development

After checking out the repo, run `bundle install`
to install dependencies. Then, run `rake spec` to
run the tests. You can also run `bin/iconsole` for
an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run
`bundle exec rake install`. To release a new
version, update the version number in `iora.rb`,
and then run `bundle exec rake release`, which
will create a git tag for the version, push git
commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on
GitHub at https://github.com/bugmark/iora.

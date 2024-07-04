# SaferMigrations

`SaferMigrations` provides safer methods for Active Record Migrations.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add safer_migrations

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install safer_migrations

## Usage

This gem provides the following methods for Active Record Migrations.

* `safer_remove_column`
* `safer_remove_columns`
* `safer_rename_column`
* `t.safer_remove`
* `t.safer_rename`

These methods check whether a column that will be removed is still used in a model. If a model uses it, these methods raise an error. In that case, you should specify a column to `ignored_columns` first.

Except for checking it, the behavior is same as well as the Rail's default methods.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/y-yagi/safer_migrations.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

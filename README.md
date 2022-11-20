# Irbs

***Inline RBS***

This gem generate rbs code from ruby source code with signature annotation comment.
## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add irbs

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install irbs

## Usage

Prepare ruby code with signature annotation comment

```rb:example.rb
module App
  # @sig (Integer) -> String
  def some_method(arg)
    arg.to_s
  end

  # @sig (String) -> Integer
  def some_private_method(arg)
    arg.to_i
  end
end
```

and run `irbs example.rb -o example.rbs`,
then rbs code will be generated

```rbs:example.rbs
module ::App
  public def some_method: (Integer) -> String
  private def some_private_method: (String) -> Integer
end
```

See example task in `Rakefile` and `exmaple/` for more examples.

This library uses itself for type checking.
See typecheck task in `Rakefile`.

## Development

```
bundle install
rake setup
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/diaphragm/irbs.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

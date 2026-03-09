# RBS::Siggen

RBS::Siggen generates RBS type signatures by statically analyzing Ruby source code AST with RBS signatures, resolving type information for methods dynamically defined through declarative DSL calls.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add rbs-siggen
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install rbs-siggen
```

## Usage

### 1. Annotate your RBS file

Add `%a{siggen: ...}` annotations with ERB templates to the method definitions whose call sites should generate signatures:

```rbs
# sig/a.rbs
class A
  %a{siggen:
    def self.<%= name %>: () -> void
  }
  def self.foo: (Symbol name) -> void
end
```

### 2. Analyze Ruby code and generate

```ruby
require "rbs/siggen"

siggen = RBS::Siggen.new
siggen.add_signature(File.read("sig/a.rbs"))
siggen.analyze_ruby(File.read("a.rb"))
puts siggen.generate
```

Given the following Ruby code:

```ruby
# a.rb
class A
  foo :bar
  foo :baz
end
```

Output:

```rbs
class A
  def self.bar: () -> void

  def self.baz: () -> void
end
```

### Template variables

Inside the ERB template, method arguments are available by their parameter names as declared in the RBS signature. Keyword arguments and rest keyword arguments are also accessible:

```rbs
class A
  %a{siggen:
    # baz     = <%= baz %>
    # options = <%= options.to_json %>
    def self.<%= name %>: () -> void
  }
  def self.foo: (Symbol name, baz: bool, **untyped options) -> void
end
```

### Special variables

| Variable | Description |
|---|---|
| `___source` | Source text of the call site, formatted as comment lines |
| `___comment_of["Type#method"]` | RBS comment of an existing method definition (`Type#method` for instance, `Type.method` for singleton) |

### CLI

```
Usage: rbs-siggen [options] <lib-path>
    --sig-dir DIR                Path to RBS signature directory (can be specified multiple times)
    --rails                      Preset to generate signatures for Rails applications
    -v, --version                Show version
    -h, --help                   Show this help
```

Analyze a Ruby file or directory and print the generated RBS to stdout:

```bash
rbs-siggen lib/my_dsl.rb
```

By default, signatures are loaded from the `sig/` directory. Use `--sig-dir` to specify a different directory (repeatable):

```bash
rbs-siggen --sig-dir sig --sig-dir other_sig_dir/generated lib/my_dsl.rb
```

#### Rails preset

The `--rails` flag enables a built-in preset for Rails applications. It loads the bundled RBS annotations for ActiveRecord and, when no `<lib-path>` is given, automatically analyzes `db/schema.rb`:

```bash
rbs-siggen --rails
```

This generates RBS signatures (e.g. `GeneratedAttributeMethods`) from the schema definition.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kozy4324/rbs-siggen.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

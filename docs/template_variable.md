# Template Variables

This document describes all variables available inside ERB templates in `%a{siggen: ...}` annotations.

## Method argument variables

Each parameter declared in the RBS method signature is available in the ERB template by its name. The value is the actual argument passed at the Ruby call site.

| RBS parameter kind | Example declaration | Available as |
|---|---|---|
| Required positional | `(Symbol name)` | `name` |
| Optional positional | `(?String label)` | `label` |
| Rest positional | `(*Symbol names)` | `names` (Array) |
| Required keyword | `(foo: Integer)` | `foo` |
| Optional keyword | `(?bar: String)` | `bar` |
| Rest keyword | `(**untyped options)` | `options` (Hash) |

Example:

```rbs
class A
  %a{siggen:
    def self.<%= name %>: () -> void
    # options = <%= options.inspect %>
  }
  def self.foo: (Symbol name, **untyped options) -> void
end
```

## Block context variables

When a method is called inside a block, the template can also access variables from the **outer block's call site**. The outer method's arguments are available under the outer method's name as a Data object, allowing attribute-style access.

This is particularly useful when a DSL uses nested blocks — for example, Rails `create_table`:

```ruby
# db/schema.rb
create_table "articles" do |t|
  t.text "body", null: false
end
```

If `t.text` has a siggen annotation, the template can reference `create_table.table_name`:

```rbs
class ActiveRecord::ConnectionAdapters::TableDefinition
  %a{siggen:
    def <%= create_table.table_name.classify %>#body: () -> String?
  }
  def text: (String name, **untyped options) -> void
end
```

Here `create_table` is a Data object whose attributes correspond to the parameter names declared in the RBS signature for `create_table`. For example, if `create_table` is declared as:

```rbs
def create_table: (String table_name, **untyped options) -> void
```

then the following attributes are available on the `create_table` Data object:

| Attribute | Value in example |
|---|---|
| `create_table.table_name` | `"articles"` |
| `create_table.options` | `{}` |

Nesting is handled recursively: if there are multiple levels of nested blocks, all ancestor calls are available, each keyed by their method name.

## Special variables

| Variable | Type | Description |
|---|---|---|
| `___source` | `String` | Source text of the call site, formatted as Ruby comment lines (each line prefixed with `# `) |
| `___comment_of["Type#method"]` | `String` | RBS doc comment of an existing method definition. Use `Type#method` for instance methods and `Type.method` for singleton methods. |

Example using `___source`:

```rbs
class A
  %a{siggen:
    <%= ___source %>
    def self.<%= name %>: () -> void
  }
  def self.foo: (Symbol name) -> void
end
```

Example using `___comment_of`:

```rbs
class A
  %a{siggen:
    <%= ___comment_of["A#some_method"] %>
    def self.<%= name %>: () -> void
  }
  def self.foo: (Symbol name) -> void
end
```

## Internals (for LLM / tooling reference)

This section documents the internal representation to aid LLM-based code generation and tooling.

### Variable binding construction

When siggen renders an ERB template for a call site, it builds a flat Hash and passes it to `ERB#result_with_hash`. The hash is constructed as follows:

1. **Direct arguments**: `create_arg_hash(node, method_decl)` extracts the call-site AST arguments and maps them to the parameter names from the RBS method declaration. Each value is the evaluated Ruby literal from the AST (String, Symbol, Integer, Array, Hash, etc.).

2. **Block context arguments**: The AST traversal maintains a stack of ancestor `[block_node, method_call]` pairs. For each ancestor, the same `create_arg_hash` is applied, and the result is stored under the ancestor method's name (as a Symbol key).

3. **Data wrapping**: All argument hashes — both direct and block-context — are converted to `Data` objects via `Data.define(*keys).new(**values)`. This allows `method_call_syntax` (e.g., `create_table.table_name`) instead of hash access inside the ERB template.

4. **Special keys**: The following keys are merged into the binding hash:
   - `:___source` — `String`; call-site source lines joined as `# line\n` comments.
   - `:___comment_of` — a callable object; `___comment_of["Type#method"]` returns the RBS comment string for that method.

### ERB binding structure (pseudo-type)

```
binding = {
  # --- direct method arguments (one key per RBS parameter name) ---
  param_name: <literal value from call site>,
  ...

  # --- ancestor block calls (one key per ancestor method name) ---
  ancestor_method_name: Data(param_name: value, ...),
  ...

  # --- special variables ---
  ___source:     String,
  ___comment_of: ^(String) -> String,
}
```

### RBS parameter kinds recognized

`create_arg_hash` processes the following parameter kinds from `RBS::Types::Function`:

- `required_positionals` / `optional_positionals` / `rest_positionals` — mapped positionally from AST `:send` children
- `required_keywords` / `optional_keywords` — extracted from keyword pairs in the AST
- `rest_keywords` — collected from remaining keyword pairs not matched by named keywords

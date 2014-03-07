# BetterHelpers

It is a better way to organize and maintain your Rails helpers. It's provide a simple pattern to keep your helpers scoped, avoiding conflicts in the global namespace.

## Installation

Add this line to your application's Gemfile:

    gem 'better_helpers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install better_helpers

## Usage

BetterHelpers is magic free, it does nothing if you do not want. It is 100% compatible with your old helpers and will only activate under your command.

The usage is very simple, add the module **BetterHelpers::Base** in your helper module and create the methods inside the "DSL" **better_helpers**, like:

```ruby
module ProfileHelper
  include BetterHelpers::Base

  better_helpers do

    def username string
      link_to(string, "/username/#{string}")
    end

  end
end
```

It will create the namespace *profile_helper* based on the underscore name of module, to use in your views is as simple as:

```sh
<%= profile_helper.username "name" %>
```

It also work with modules, consider the example:

```ruby
module Admin
  module Users
    module ProfileHelper
      include BetterHelpers::Base

      better_helpers do

        def username string
          "admin #{string}"
        end

      end
    end
  end
end
```

```sh
<%= admin.users.profile_helper.username "name" %>
```

By default, it will create the whole hierarchy but it is possible to define the namespace, check the section **Defining the namespace** to understand how to proceed.

BetterHelpers will include in the namespace just the methods inside the "DSL", you could keep your "old fashion" helpers inside the module without problems.

### Defining the namespace

Just pass a symbol to the "DSL" and it's done.

```ruby
module HomeHelper
  include BetterHelpers::Base

  better_helpers :custom_namespace do

    def title
      "<h1>HOME</h1>".html_safe
    end

  end
end
```

```sh
<%= custom_namespace.title %>
```

```ruby
module MyModule
  module MyHelper
    include BetterHelpers::Base

    better_helpers :custom do

      def helper_method
      end

    end
  end
end
```

```sh
<%= custom.helper_method %>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

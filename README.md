# BetterHelpers

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'better_helpers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install better_helpers

## Usage

TODO: Write usage instructions here

```ruby
module ProfileHelper
  include BetterHelpers::Base

  better_helpers do

    def profile_1
      link_to("A", "#").html_safe
    end

  end
end
```

```ruby
module HomeHelper
  include BetterHelpers::Base

  better_helpers :custom_namespace do

    def home_1
      "<h1>HOME</h1>".html_safe
    end

  end
end
```

```html
<%= profile_helper.profile_1 %>
<%= custom_namespace.home_1 %>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

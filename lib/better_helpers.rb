require "active_support/core_ext/string/inflections"
require "active_support/core_ext/object/try"
require "action_view"

require "better_helpers/version"
require "better_helpers/base"
require "better_helpers/namespace_to_hash"
require "better_helpers/hash_hierarchy_to_class"
require "better_helpers/railties/filter"
require "better_helpers/railties/request_context"
require "better_helpers/railtie" if defined? ::Rails

module BetterHelpers
end

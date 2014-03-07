module InsideModuleHelper
  module A
    module B
      include BetterHelpers::Base

      better_helpers do

        def helper_method
          "test3"
        end

      end
    end
  end
end

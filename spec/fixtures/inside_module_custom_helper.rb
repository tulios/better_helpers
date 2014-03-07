module InsideModuleCustomHelper
  module A
    module B
      include BetterHelpers::Base

      better_helpers :custom_helper do

        def helper_method
          "test4"
        end

      end
    end
  end
end

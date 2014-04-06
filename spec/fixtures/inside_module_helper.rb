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

    module C
      include BetterHelpers::Base

      better_helpers do

        def helper_method
          "test6"
        end

      end
    end
  end
end

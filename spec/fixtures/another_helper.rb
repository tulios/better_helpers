module AnotherHelper
  include BetterHelpers::Base

  def global_helper_method
    "test5"
  end

  better_helpers :another do

    def helper_method
      "test2"
    end

  end
end

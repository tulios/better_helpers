module BetterHelpers
  module Railties

    module Filter
      extend ActiveSupport::Concern

      included do
        prepend_before_filter :better_helpers_store_request
      end

      def better_helpers_store_request
        Thread.current[RequestContext::NAME] = self
      end
    end

  end
end

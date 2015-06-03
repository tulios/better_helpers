module BetterHelpers
  module Railties

    module RequestContext
      NAME = :better_helpers_request_controller

      def controller
        Thread.current[NAME]
      end

      def view_context
        controller.try(:view_context)
      end

      def method_missing method, *args, &block
        if view_context.respond_to?(method)
          # Sends helper methods to the view context and cache the used
          # methods to improve performance in the next calls
          self.class.send(:define_method, method) do |*args, &block|
            view_context.send(method, *args, &block)
          end

          self.send(method, *args, &block)

        else
          super(method, *args, &block)
        end
      end
    end

  end
end

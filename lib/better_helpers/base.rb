module BetterHelpers
  module Base

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods
      def better_helpers namespace = nil, &block
        helper_class = Class.new(&block)
        helper_class.class_eval do
          include ActionView::Helpers
          include ActionView::Context
          extend ActionView::Helpers
          extend ActionView::Context
        end

        namespace ||= self.to_s.underscore
        names = namespace.to_s.split("/")
        name = names.shift

        hash = NamespaceToHash.new(helper_class, names).perform
        value = HashToObject.new(hash).perform

        self.send(:define_method, name) { value }
      end
    end

  end
end

module BetterHelpers
  module Base

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods
      def self.extended base
        @@BetterHelpersMasterHelper ||= Class.new
      end

      def better_helpers namespace = nil, &block
        helper_class = Class.new(&block)
        helper_class.class_eval do
          include BetterHelpers::Railties::RequestContext
        end

        namespace ||= self.to_s.underscore
        names = namespace.to_s.split("/")
        name = names.shift

        hash = NamespaceToHash.new(helper_class, names).perform
        value = HashHierarchyToClass.new(hash, @@BetterHelpersMasterHelper).apply

        self.send(:define_method, name) { value }
      end
    end

  end
end

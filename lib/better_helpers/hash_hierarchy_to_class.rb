module BetterHelpers
  class HashHierarchyToClass

    def initialize hash, parent_class
      @hash = hash
      @parent_class = parent_class
    end

    def apply
      value = apply_to_class @hash, @parent_class.new
      @hash.keys.first.nil? ? value : @parent_class.new
    end

    private
    def apply_to_class obj, parent_obj
      if obj.is_a? Hash
        key = obj.keys.first
        value = obj[key]

        return value if key.nil?

        if parent_obj.respond_to?(key)
          apply_to_class value, parent_obj.send(key)
        else

          klass = Class.new
          instance = klass.new
          return_obj = apply_to_class value, instance

          parent_obj.class.send(:define_method, key) { return_obj }
          return parent_obj
        end
      end

      obj
    end

  end
end

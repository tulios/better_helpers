module BetterHelpers
  class HashToObject
    def initialize obj
      @obj = obj
    end

    def perform
      generate_obj @obj
    end

    private
    def generate_obj obj
      if obj.is_a? Hash
        key = obj.keys.first
        value = obj[key]

        return value if key.nil?
        return_obj = generate_obj value

        c = Class.new
        c.send(:define_method, key) { return_obj }
        return c.new
      end

      obj
    end
  end
end

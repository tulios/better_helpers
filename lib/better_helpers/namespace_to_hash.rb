module BetterHelpers
  class NamespaceToHash
    def initialize helper_class, names
      @helper_class = helper_class
      @names = names.clone
    end

    def perform
      generate_hash @names.shift, @names, {}
    end

    private
    def generate_hash name, names, hash
      if names.empty?
        hash[name] = @helper_class.new

      else
        hash[name] = {}
        generate_hash(names.shift, names, hash[name])
      end

      hash
    end
  end
end

module SimpleSearch
  class Filter

    attr_reader :compound, :attribute, :method, :value, :model

    def initialize(*attrs)
      @attribute = attrs[:attribute]
      @compound = attrs[:compound]
      @method = attrs[:method]
      @value = attrs[:value]
      @model = attrs[:model]
    end

    def custom_mthod?
    end

    def filter?
    end

    def value_from_compound(compound)
    end

  end
end

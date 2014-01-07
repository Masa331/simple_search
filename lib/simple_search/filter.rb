module SimpleSearch
  class Filter

    attr_reader :compound, :attribute, :method, :value, :model

    def initialize(attrs)
      @attribute = attrs[:attribute]
      @compound = attrs[:compound]
      @method = attrs[:method]
      @value = attrs[:value]
      @model = attrs[:model]
    end

    def custom_method?
      attribute == 'custom_scope'
    end

    def filter?
      !custom_method?
    end

  end
end

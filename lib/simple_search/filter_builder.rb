module SimpleSearch
  module FilterBuilder

    extend SimpleSearch::CompoundMethods

    def self.from_controller_params(model, params)
      @model = model
      filter_params = whitelist(params.fetch('filters', {}))
      assemble_filters(filter_params)
    end

    private

    def self.assemble_filters(params)
      params.collect do |p|
        search_method?(p[0]) ? custom_method_filter(p) : simple_filter(p)
      end
    end

    def self.custom_method_filter(p)
      { attribute: 'custom_scope', method: p[0], value: p[1], compound: p[0] }
      # Filter.new()
    end

    def self.simple_filter(p)
      { attribute: extract_attribute(p[0]), method: extract_filter_method(p[0]), value: p[1], compound: p[0]}
      # Filter.new()
    end

    def self.whitelist(params)
      params.select do |key,_|
        searchable?(extract_attribute(key.to_sym)) ||
        search_method?(key)
      end
    end

    def self.search_method?(method)
      @model.search_methods.include? method.to_sym
    end

    def self.searchable?(attr)
      @model.searchables.include? attr.to_sym
    end
  end
end

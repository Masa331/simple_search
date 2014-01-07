module SimpleSearch
  module FilterBuilder

    def self.filters_from_controller_params(params)
      @model = model_from_controller_params params
      filter_params = permit_filters(params.fetch('filters', {}))
      assemble_filters(filter_params)
    end

    def self.model_from_controller_params(params)
      params['controller'].classify.constantize
    end

    private

    def self.permit_filters(params)
      params.select do |key,_|
        searchable_attr?(extract_attr(key)) || search_method?(key)
      end
    end

    def self.assemble_filters(params)
      params.collect do |p|
        search_method?(p[0]) ? build_model_scope_filter(p) : build_simple_filter(p)
      end
    end

    def self.build_model_scope_filter(p)
      Filter.new(attribute: 'custom_scope', method: p[0], value: p[1], compound: p[0])
    end

    def self.build_simple_filter(p)
      Filter.new(attribute: extract_attr(p[0]), method: extract_filter_method(p[0]), value: p[1], compound: p[0])
    end

    def self.search_method?(method)
      @model.search_methods.include? method.to_sym
    end

    def self.searchable_attr?(attr)
      @model.searchables.include? attr.to_sym
    end

    def self.extract_attr(compound)
      compound.to_s.rpartition('_').first
    end

    def self.extract_filter_method(compound)
      compound.to_s.rpartition('_').last
    end
  end
end

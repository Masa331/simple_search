require 'active_model'

module SimpleSearch
  class Search
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_reader :filters, :model

    def initialize(params)
      @model = FilterBuilder::model_from_controller_params(params)
      @filters = FilterBuilder::filters_from_controller_params(params)
    end

    def result
      return model.all if filters.empty?
      apply_filters
    end

    private

    def apply_filters(searched = model.all, conditions = filters.dup)
      filter = conditions.pop
      searched = search(searched, filter)

      return searched if conditions.empty?
      apply_filters(searched, conditions)
    end

    def search(searched, filter)
      if filter.custom_method?
        searched.send(filter.method, filter.value)
      else
        FilterMethods.send(filter.method, searched, { filter.attribute => filter.value })
      end
    end

    def method_missing(meth, *args, &block)
      if filters.any? { |f| f.compound == meth.to_s }
        filters.find { |f| f.compound == meth.to_s }.value
      else
        super
      end
    end

  end
end

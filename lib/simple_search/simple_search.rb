require 'active_model'

module SimpleSearch
  class Search
    include SimpleSearch::CompoundMethods
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_reader :filters, :model

    def initialize(params)
      @model = params['controller'].classify.constantize
      @filters = FilterBuilder::from_controller_params(model, params)
      # @filters = Filter::from_controller_params(params)
    end

    def result
      return model.all if filters.empty?
      search
    end

    private

    def method_missing(meth, *args, &block)
      if model.searchables.include? extract_attribute(meth).to_sym
        filters.select { |f| f[:compound] == meth.to_s }.first[:value]
      else
        super
      end
    end

    def search(searched = model.all, conditions = filters.dup)
      filter = conditions.pop

      if filter[:attribute] == 'custom_scope'
        searched = searched.send(filter[:method], filter[:value])
      else
        searched = FilterMethods.send(filter[:method], searched, { filter[:attribute] => filter[:value] })
      end

      return searched if conditions.empty?
      search(searched, conditions)
    end

  end
end

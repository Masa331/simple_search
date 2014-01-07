module SimpleSearch
  module ModelAdditions

    def searchables(*attributes)
      if attributes.any?
        @searchables = attributes
      else
        @searchables
      end
    end

    def search_methods(*methods)
      if methods.any?
        @search_methods = methods
      else
        @search_methods
      end
    end

  end
end

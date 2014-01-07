module SimpleSearch
  module CompoundMethods
    def extract_attribute(compound)
      attribute, * = compound.to_s.rpartition '_'
      attribute
    end

    def extract_filter_method(compound)
      *, method = compound.to_s.rpartition '_'
      method
    end
  end
end

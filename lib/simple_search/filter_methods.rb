module SimpleSearch
  module FilterMethods
    def self.eq(searched, searching)
      searched.where(searching)
    end
  end
end

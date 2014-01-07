module SimpleSearch
  class Railtie < Rails::Railtie
    initializer 'simple_search.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end
  end
end

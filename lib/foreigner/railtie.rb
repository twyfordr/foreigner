module Foreigner
  class Railtie < Rails::Railtie
    initializer 'foreigner.load_adapter' do
      ActiveSupport.on_load :active_record do
        Foreigner.load_adapter!
      end
    end
  end
end
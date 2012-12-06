# coding: utf-8
module Rack
  class SmartphoneDetector
    class Railtie < ::Rails::Railtie
      initializer 'rack-smartphone_detector.configure_rails_initialization' do |app|
        app.config.middleware.insert_before('ActionDispatch::ParamsParser', 'Rack::SmartphoneDetector')
      end
    end
  end
end

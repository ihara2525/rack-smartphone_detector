# coding: utf-8
require 'rack/smartphone_detector'
require 'rack/smartphone_detector/checker'
require 'rack/smartphone_detector/version'
require 'rack/smartphone_detector/railtie' if defined?(Rails::Railtie)

module Rack
  class SmartphoneDetector
    SMARTPHONES_REGEXP = /(iPhone|iPad|Android|Windows Phone)/

    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      if env['HTTP_USER_AGENT'] =~ SMARTPHONES_REGEXP
        env['rack.smartphone_detector.device'] = $1
      end
      @app.call(env)
    end
  end

  class Request
    include Rack::SmartphoneDetector::Checker
  end
end

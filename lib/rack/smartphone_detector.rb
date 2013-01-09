# coding: utf-8
require 'rack/smartphone_detector'
require 'rack/smartphone_detector/checker'
require 'rack/smartphone_detector/version'
require 'rack/smartphone_detector/railtie' if defined?(Rails::Railtie)

module Rack
  class SmartphoneDetector
    SMARTPHONE_IDENTIFIERS = [
      { identifier: 'iPhone',         regexp: /iPhone/ },
      { identifier: 'iPad',           regexp: /iPad/ },
      { identifier: 'Android',        regexp: /Android.+Mobi(le)?/ },
      { identifier: 'Android Tablet', regexp: /Android/ },
      { identifier: 'Windows Phone',  regexp: /Windows Phone/ },
    ]

    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      SMARTPHONE_IDENTIFIERS.each do |i|
        if env['HTTP_USER_AGENT'] =~ i[:regexp]
          env['rack.smartphone_detector.device'] = i[:identifier]
          break
        end
      end
      @app.call(env)
    end
  end

  class Request
    include Rack::SmartphoneDetector::Checker
  end
end

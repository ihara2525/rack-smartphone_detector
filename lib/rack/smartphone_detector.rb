# coding: utf-8
require 'rack/smartphone_detector'
require 'rack/smartphone_detector/checker'
require 'rack/smartphone_detector/version'
require 'rack/smartphone_detector/railtie' if defined?(Rails::Railtie)

module Rack
  class SmartphoneDetector
    VERSION_PATTERNS = {
      ios:           /OS\s+([\d_]+)\s+like Mac OS X/,
      android:       /Android\s+([\d\.]+);/,
      windows_phone: /Windows Phone OS\s+([\d\.]+);/,
    }

    SMARTPHONE_IDENTIFIERS = [
      { identifier: 'iPhone',         regexp: /iPhone/,             version_type: :ios },
      { identifier: 'iPad',           regexp: /iPad/,               version_type: :ios },
      { identifier: 'Android',        regexp: /Android.+Mobi(le)?/, version_type: :android },
      { identifier: 'Android Tablet', regexp: /Android/,            version_type: :android },
      { identifier: 'Windows Phone',  regexp: /Windows Phone/,      version_type: :windows_phone },
    ]

    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      SMARTPHONE_IDENTIFIERS.each do |i|
        if env['HTTP_USER_AGENT'] =~ i[:regexp]
          env['rack.smartphone_detector.device'] = i[:identifier]
          detect_version(env, i[:version_type])
          break
        end
      end
      @app.call(env)
    end

    private

    def detect_version(env, version_type)
      if env['HTTP_USER_AGENT'] =~ VERSION_PATTERNS[version_type]
        env['rack.smartphone_detector.device_version'] = Regexp.last_match[1]
      end
    end
  end

  class Request
    include Rack::SmartphoneDetector::Checker
  end
end

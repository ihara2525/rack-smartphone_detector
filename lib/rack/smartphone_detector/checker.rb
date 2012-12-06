# coding: utf-8
module Rack
  class SmartphoneDetector
    module Checker
      def self.included(base)
        def from_smartphone?
          !env['rack.smartphone_detector.device'].nil?
        end
      end
    end
  end
end

# coding: utf-8
module Rack
  class SmartphoneDetector
    module Checker
      def self.included(base)
        def from_smartphone?
          !env['rack.smartphone_detector.device'].nil?
        end

        SMARTPHONE_IDENTIFIERS.each do |info|
          name = %Q{from_#{info[:identifier].downcase.gsub(' ', '_')}?}
          define_method(name) { env['rack.smartphone_detector.device'] == info[:identifier] }
        end
      end
    end
  end
end

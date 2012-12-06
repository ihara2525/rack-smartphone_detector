require 'minitest/spec'
require 'minitest/autorun'
require 'rack/test'
require_relative '../lib/rack/smartphone_detector'

describe 'Rack::SmartphoneDetector' do
  include Rack::Test::Methods

  SMARTPHONES = [
    { device: 'iPhone', user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25' },
    { device: 'iPad', user_agent: 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25' },
    { device: 'Android', user_agent: 'Mozilla/5.0 (Linux; Android 4.1.1; Nexus 7 Build/JRO03S) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Safari/535.19' },
    { device: 'Windows Phone', user_agent: 'Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0; FujitsuToshibaMobileCommun; IS12T; KDDI)' }
  ]

  let(:app) do
    dummy_app = ->(env) { [200, {}, 'Hello World'] }
    Rack::SmartphoneDetector.new(dummy_app)
  end

  it 'sets environment variable if the request comes from smartphone' do
    SMARTPHONES.each do |smartphone|
      header 'User-Agent', smartphone[:user_agent]
      get '/'
      last_request.env['rack.smartphone_detector.device'].must_equal smartphone[:device]
    end
  end

  describe '#from_smartphone?' do
    it 'returns true if the request comes from smartphone' do
      header 'User-Agent', SMARTPHONES.first[:device]
      get '/'
      last_request.from_smartphone?.must_equal true
    end

    it 'returns false if the request does not come from smartphone' do
      header 'User-Agent', 'DoCoMo/2.0 F01E(c500;TB;W24H16)'
      get '/'
      last_request.from_smartphone?.must_equal false
    end

    it 'returns false if the request comes from unknown device' do
      get '/'
      last_request.from_smartphone?.must_equal false
    end
  end
end

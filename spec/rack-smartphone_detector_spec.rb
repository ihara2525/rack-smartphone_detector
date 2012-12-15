require 'minitest/spec'
require 'minitest/autorun'
require 'rack/test'
require_relative '../lib/rack/smartphone_detector'

describe 'Rack::SmartphoneDetector' do
  include Rack::Test::Methods

  SMARTPHONES = [
    { name: 'iPhone', user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25' },
    { name: 'iPad', user_agent: 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25' },
    { name: 'Android', user_agent: 'Mozilla/5.0 (Linux; U; Android 4.0.1; ja-jp; Galaxy Nexus Build/ITL41D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30' },
    { name: 'Android Tablet', user_agent: 'Mozilla/5.0 (Linux; Android 4.1.1; Nexus 7 Build/JRO03S) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Safari/535.19' },
    { name: 'Windows Phone', user_agent: 'Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0; FujitsuToshibaMobileCommun; IS12T; KDDI)' }
  ]

  let(:app) do
    dummy_app = ->(env) { [200, {}, 'Hello World'] }
    Rack::SmartphoneDetector.new(dummy_app)
  end

  it 'sets environment variable if the request comes from smartphone' do
    SMARTPHONES.each do |info|
      header 'User-Agent', info[:user_agent]
      get '/'
      last_request.env['rack.smartphone_detector.device'].must_equal info[:name]
    end
  end

  describe '#from_smartphone?' do
    it 'returns true if the request comes from smartphone' do
      SMARTPHONES.each do |info|
        header 'User-Agent', info[:user_agent]
        get '/'
        last_request.from_smartphone?.must_equal true
      end
    end

    it 'returns false if the request does not come from smartphone' do
      header 'User-Agent', 'DoCoMo/2.0 F01E(c500;TB;W24H16)'
      get '/'
      last_request.from_smartphone?.must_equal false
    end

    it 'returns false if the request comes from device without user-agent' do
      get '/'
      last_request.from_smartphone?.must_equal false
    end
  end

  describe '#from_iphone?' do
    it 'returns true if the request comes from iphone' do
      header 'User-Agent', user_agent('iPhone')
      get '/'
      last_request.from_iphone?.must_equal true
    end
  end

  describe '#from_ipad?' do
    it 'returns true if the request comes from ipad' do
      header 'User-Agent', user_agent('iPad')
      get '/'
      last_request.from_ipad?.must_equal true
    end
  end

  describe '#from_android?' do
    it 'returns true if the request comes from android mobile' do
      header 'User-Agent', user_agent('Android')
      get '/'
      last_request.from_android?.must_equal true
    end
  end

  describe '#from_android_tablet?' do
    it 'returns true if the request comes from android tablet' do
      header 'User-Agent', user_agent('Android Tablet')
      get '/'
      last_request.from_android_tablet?.must_equal true
    end
  end

  describe '#from_windows_phone?' do
    it 'returns true if the request comes from windows phone' do
      header 'User-Agent', user_agent('Windows Phone')
      get '/'
      last_request.from_windows_phone?.must_equal true
    end
  end

  def user_agent(name)
    SMARTPHONES.find { |info| info[:name] == name }[:user_agent]
  end
end

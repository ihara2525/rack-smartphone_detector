# Rack::SmartphoneDetector [![Build Status](https://secure.travis-ci.org/ihara2525/rack-smartphone_detector.png?branch=master)](http://travis-ci.org/ihara2525/rack-smartphone_detector)

It's a very simple Rack middleware which detect the request comes from smartphones (iPhone/iPad/Android/Android Tablet/Windows Phone).  

You can use #from_smartphone? to detect the request.

```ruby
request.from_smartphone? # true if it comes from such devices
```

or, use methods for each devices.

```ruby
request.from_iphone?         # true if it comes from iphone
request.from_ipad?           # true if it comes from ipad
request.from_android?        # true if it comes from android mobile
request.from_android_tablet? # true if it comes from android tablet
request.from_windows_phone?  # true if it comes from windows phone
```

When you want to get the device version, use `smartphone_version`.

```ruby
# HTTP_USER_AGENT is 'Mozilla/5.0 (Linux; U; Android 4.0.1; ja-jp; Galaxy Nexus Build/ITL41D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30'
request.smartphone_version # => 4.0.1
```

What this middleware does is just matching HTTP_USER_AGENT with identifier of smartphones.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-smartphone_detector'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install rack-smartphone_detector
```

## Usage with Rails 4 or Rails 3

If you are using Rails 4 or Rails 3, you have no futher steps to do.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

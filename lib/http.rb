require 'httparty'

class MyHttp
  include HTTParty
  default_timeout 5
end


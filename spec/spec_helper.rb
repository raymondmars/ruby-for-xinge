$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xinge'

Xinge.configure do |config|
  config[:android_accessId] = Your android access id
  config[:android_secretKey] = 'xxxx'
  config[:ios_accessId] = Your ios access id
  config[:ios_secretKey] = 'xxxx'
end

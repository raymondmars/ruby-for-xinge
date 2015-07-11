$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xinge'

#将测试时用到的 accessid , secretkey 环境变量预先配置到你的 .bashrc 或者 .zshrc 文件当中
#example: export XINGE_ANDROID_ACCESSID=xxxx
Xinge.configure do |config|
  config[:android_accessId]  = ENV['XINGE_ANDROID_ACCESSID']
  config[:android_secretKey] = ENV['XINGE_ANDROID_SECRETKEY']
  config[:ios_accessId]      = ENV['IOS_ACCESSID']
  config[:ios_secretKey]     = ENV['IOS_SECRETKEY']
end


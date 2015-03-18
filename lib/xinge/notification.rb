require 'singleton'
require 'xinge/base'
require 'xinge/ios'
require 'xinge/android'

module Xinge

  class Notification
    include Singleton
    attr_reader :android, :ios
    def initialize
      @android = Xinge::Android.new(Xinge.config[:android_accessId], Xinge.config[:android_secretKey])
      @ios = Xinge::Ios.new(Xinge.config[:ios_accessId], Xinge.config[:ios_secretKey])
    end
    #发送简单消息到所有 android , ios 设备
    def send_simple_to_all(title, content)
      result = []
      [@android, @ios].each do |sender|
        result << sender.pushToAllDevice(title,content)
      end
      result
    end
    #发送简单消息到指定的设备
    #def send_simple_to_single(token, title, content)
      #result = []
      #[@android, @ios].each do |sender|
        #result << sender.pushToSingleDevice(token, title, content)
      #end
      #result
    #end

  end

end


require 'xinge/base'
module Xinge
  class Ios < Base
    def initialize(accessId = nil, secretKey = nil, options = {})
      super
    end
    def pushToSingleDevice(token, title, content, params={})
      self.push_single_device(token, 1, build_simple_message(title, content), {environment: 2})
    end
    def pushToAllDevice(title, content, params={})
      self.push_all_device(1, build_simple_message(title, content), {environment: 2})
    end

    protected

    def build_simple_message(title,content)
      {
        aps: {
          alert: {
            title: title,
            body: content
          },
          sound: 'default',
          badge: 5
        }
      }.to_json
    end
  end
end

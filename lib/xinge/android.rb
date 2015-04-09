require 'xinge/base'
module Xinge
  class Android < Base
    def initialize(accessId = nil, secretKey = nil, options = {})
      super
    end
    def pushToSingleDevice(token, title, content, params={}, custom_content={})
      self.push_single_device(token, 1, build_simple_message(title, content, custom_content), params)
    end
    def pushToAllDevice(title, content, params={}, custom_content={})
      self.push_all_device(1, build_simple_message(title, content, custom_content), params)
    end

    protected

    def build_simple_message(title, content, custom_content)
      {
        title: title, content: content, vibrate: 1
      }.merge(custom_content).to_json
    end
  end
end

require 'httparty'
require 'digest'

module Xinge

  @xinge_config = {env: 'development'}

  class << self
    def configure
      yield @xinge_config if block_given?
    end
    def config
      @xinge_config
    end
  end

  class Base
    include HTTParty
    base_uri  'http://openapi.xg.qq.com'    	
    
    DEFAULT_OPTIONS = {
      api_version: 'v2'
    }
    HOST = "openapi.xg.qq.com"
    HTTP_METHOD = :post

    def initialize(accessId = nil, secretKey = nil, options = {})
      raise 'accessId is invalid' unless accessId.is_a? Integer
      raise 'secretKey is invalid' if !secretKey.is_a?(String) or secretKey.strip.size == 0
      @accessId  =  accessId
      @secretKey =  secretKey.strip
      @options = DEFAULT_OPTIONS.merge options
    end


    #push消息（包括通知和透传消息）给单个设备
    def push_single_device(device_token, message_type, message, params = {})
      params.merge!({
        device_token: device_token,
        message: message,
        message_type: message_type
        })
      self.send_request('push','single_device',params)
    end

    #push消息（包括通知和透传消息）给单个账户或别名
    def push_single_account(account, message_type, message, params = {})
      params.merge!({
        account: account,
        message_type: message_type,
        message: message
        })
      self.send_request('push','single_account',params)
    end

    #push消息（包括通知和透传消息）给app的所有设备
    def push_all_device(message_type, message, params = {})
      params.merge!({
        message_type: message_type,
        message: message
        })
      self.send_request('push','all_device',params)
    end

    #push消息（包括通知和透传消息）给tags指定的设备
    def push_tags_device(message_type, message, tags_list, tags_op, params = {})
      params.merge!({
        message_type: message_type,
        message: message,
        tags_list: tags_list.to_json,
        tags_op: tags_op
        })
      self.send_request('push','tags_device',params)
    end

    #查询群发消息发送状态
    def push_get_msg_status(push_ids, params = {})
      params.merge!({
        push_ids: push_ids.to_json
        })
      self.send_request('push','get_msg_status',params)
    end

    #查询应用覆盖的设备数
    def application_get_app_device_num(params = {})
      self.send_request('application','get_app_device_num',params)
    end

    #查询应用的Tags
    def tags_query_app_tags(params = {})
      self.send_request('tags','query_app_tags',params)
    end

    #取消尚未触发的定时群发任务
    def push_cancel_timing_task(push_id, params = {})
      params.merge!({
        push_id: push_id
        })
      @request.fetch(params)
      self.send_request('push','cancel_timing_task',params)
    end

    #批量设置标签
    def tags_batch_set(tag_token_list, params = {})
      params.merge!({
        tag_token_list: tag_token_list
        })
      self.send_request('tags','batch_set',params)
    end

    #批量删除标签
    def tags_batch_del(tag_token_list, params = {})
      params.merge!({
        tag_token_list: tag_token_list
        })
      self.send_request('tags','batch_del',params)
    end

    #查询应用某token设置的标签
    def tags_query_token_tags(device_token, params = {})
      params.merge!({
        device_token: device_token
        })
      self.send_request('tags','query_token_tags',params)
    end

    #查询应用某标签关联的设备数量
    def tags_query_tag_token_num(tag, params = {})
      params.merge!({
        tag: tag
        })
      self.send_request('tags','query_tag_token_num',params)
    end

    protected

    def send_request(type,method,params = {})
      params.merge!({access_id: @accessId,
                     timestamp: Time.now.to_i})
      #sign params
      params_string = params.sort.map{ |h| h.join('=') }.join
      sign = Digest::MD5.hexdigest("#{HTTP_METHOD.to_s.upcase}#{HOST}#{self.get_request_url(type,method)}#{params_string}#{@secretKey}")
      
      params.merge!({ sign: sign })
      options = { body: params }
      
      result = JSON.parse(self.class.send(HTTP_METHOD,self.get_request_url(type,method), options))
      [result["ret_code"], result["err_msg"]]
    end

    def get_request_url(type,method)
      "/#{@options[:api_version]}/#{type}/#{method}"
    end

    def build_simple_message(title, content)
      raise 'let child class to implement it.'
    end

  end

end


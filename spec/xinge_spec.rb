require 'spec_helper'

#run bundle exec rspec spec 
#
describe Xinge do  
  before(:all) do 
    #将token环境变量预先配置到你的 .bashrc 或者 .zshrc 文件当中
    #example: export XINGE_TEST_TOKENS='xxxx,xxxx'
    @target_device_tokens = ENV['XINGE_TEST_TOKENS'].split(',')

  end
  it 'has a version number' do
    expect(Xinge::VERSION).not_to be nil
  end

  it 'can push to a android device' do 
    #puts Xinge.config
    @target_device_tokens.each do |token|
      expect(Xinge::Notification.instance.android.pushToSingleDevice(token, 'Xinge_Title', 'Xinge_测试内容')).to eq([0, nil])
    end
  end 

  #it 'can send message to all ios device' do
    #expect(Xinge::Notification.instance.ios.pushToAllDevice('','hello,ios device')).to eq([0,nil])
  #end
  #it 'can send message to all ios and android' do
    #expect(Xinge::Notification.instance.send_simple_to_all('','all device, 你们好吗？')).to eq([[0,nil],[0,nil]])
  #end

end

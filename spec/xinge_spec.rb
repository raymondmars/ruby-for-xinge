require 'spec_helper'

describe Xinge do
  it 'has a version number' do
    expect(Xinge::VERSION).not_to be nil
  end

  it 'can send message to all ios device' do
    expect(Xinge::Notification.instance.ios.pushToAllDevice('','hello,ios device')).to eq([0,nil])
  end
  it 'can send message to all ios and android' do
    expect(Xinge::Notification.instance.send_simple_to_all('','all device, 你们好吗？')).to eq([[0,nil],[0,nil]])
  end
end

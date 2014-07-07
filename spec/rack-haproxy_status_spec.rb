require 'rack/haproxy_status'
require 'json'

describe Rack::HaproxyStatus::Endpoint do
  let(:disk)             { double("File", read: "on") }
  let(:response)         { described_class.new(path: 'config/status', io: disk).call({}) }
  let(:response_status)  { response[0] }
  let(:response_headers) { response[1] }
  let(:response_body)    { response[2] }
  let(:result)           { JSON.load(response_body[0]) }

  it 'returns an ok status' do
    expect(result.fetch('status')).to eq("ok")
  end

  describe 'balancer memberness' do
    it 'should be in the balancer when balancer_status file is "on"' do
      allow(disk).to receive(:read).and_return("on")
      expect(response_status).to eq(200)
      expect(result.fetch('member')).to be_truthy
    end

    it 'should not be in the balancer when balancer_status file is "off"' do
      allow(disk).to receive(:read).and_return("off")
      expect(response_status).to eq(503)
      expect(result.fetch('member')).to be_falsey
    end

    it 'raises an exception when balancer_status file is anything else' do
      allow(disk).to receive(:read).and_return("something")
      expect(response_status).to eq(500)
    end
  end
end

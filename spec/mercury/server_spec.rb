require './lib/mercury'
require 'rack/test'

set :environment, :test

describe 'Mercury Server' do
  include Rack::Test::Methods

  def app
    Mercury::Server
  end

  it "should respond to the message later" do
    Mercury::Responder.should_receive(:delay).and_return(Mercury::Responder)
    Mercury::Responder.should_receive(:respond_to) do | message, params | 
      message.should == 'my_message'
      params["some"].should == "parameters"
    end
    post '/my_message', "some" => "parameters"
  end

  it "should return a successful status code" do
    post '/my_message', "some" => "parameters"

    last_response.should be_ok
  end

end

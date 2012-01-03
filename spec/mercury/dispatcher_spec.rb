require './lib/mercury'

describe Mercury::Dispatcher do
  it "should dispatch an HTTP POST to the given URL with the given parameters" do
    @url = 'http://example.com/whatever'
    @data = { 'some' => 'data' } 

    @request = mock 'request'
    EventMachine::HttpRequest.should_receive(:new).with(@url).and_return(@request)
    @request.should_receive(:post).with(:body => @data)

    @dispatcher = Mercury::Dispatcher.new @url
    @dispatcher.dispatch! @data
  end
end
require './lib/mercury'

describe Mercury::Responder do

  describe "creating an instance" do
    it "should build a responder and dispatch the given message" do
      @contents = { 'some' => 'data' }

      @responder = mock 'responder'
      Mercury::Responder.should_receive(:new).with('my_message').and_return(@responder)
      @responder.should_receive(:dispatch).with(@contents)

      Mercury::Responder.respond_to 'my_message', 'some' => 'data'
    end
  end

  describe "finding the destination URLs for a message" do
    it "should return an array of URLs if there is a configuration" do
      @urls = ['http://here.com', 'http://there.com']
      Mercury.configuration.should_receive(:urls_for).with('my_message').and_return(@urls)

      @responder = Mercury::Responder.new 'my_message'
      @responder.destination_urls.should == @urls
    end

    it "should return an empty array if there are no configuration" do
      Mercury.configuration.should_receive(:urls_for).with('my_message').and_return(nil)

      @responder = Mercury::Responder.new 'my_message'
      @responder.destination_urls.should == []
    end
  end

  describe "dispatching messages" do
    describe "when it has a valid configuration" do
      before :each do
        @responder = Mercury::Responder.new 'my_message'
      end

      it "should create a dispatcher for each URL" do
        @urls = ['http://here.com', 'http://there.com']
        @responder.stub!(:destination_urls).and_return(@urls)

        @dispatchers = @responder.dispatchers

        @dispatchers.should have(2).items
        @dispatchers.select { | d | d.url == @urls.first }.should_not be_nil
        @dispatchers.select { | d | d.url == @urls.last }.should_not be_nil
      end

      it "should dispatch the message" do
        @dispatchers = [mock('dispatcher'), mock('dispatcher')]
        @dispatchers.each { | d | d.should_receive(:dispatch!).with('some' => 'data') }
        @responder.should_receive(:dispatchers).and_return(@dispatchers)

        @responder.dispatch('some' => 'data')
      end
    end

    describe "when it has no valid configuration" do
      it "should do nothing" do
        @responder = Mercury::Responder.new 'my_message'
        @responder.stub!(:destination_urls).and_return([])
        @responder.dispatchers.should == []
        @responder.dispatch('some' => 'data')
      end
    end
  end
end
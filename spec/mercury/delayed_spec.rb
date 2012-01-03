require './lib/mercury'

describe Mercury::Delayed do
  class Test
    include Mercury::Delayed
    attr_accessor :message

    def remember message
      @message = message
    end

    def store
      @message = yield
    end
  end

  describe "in action" do
    it "should return a proxy" do
      @test = Test.new
      @test.delay.should be_kind_of(Mercury::Delayed::Proxy)
    end
  end

  describe "proxy" do
    before :each do
      EventMachine.should_receive(:next_tick).and_yield
      @test = Test.new
      @proxy = Mercury::Delayed::Proxy.new @test
    end

    it "should pass the call to EventMachine and invoke the given method" do
      @proxy.remember 'me'
      @test.message.should == 'me'
    end

    it "should pass the call to EventMachine, invoke the given method and handle any supplied blocks" do
      @proxy.store { 'my stuff' }
      @test.message.should == 'my stuff'
    end
  end
end
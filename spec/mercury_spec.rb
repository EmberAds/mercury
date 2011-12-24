require 'spec_helper'

describe Mercury do
  it "should build a Mercury::Configuration by default" do
    Mercury.configuration.should be_kind_of(Mercury::Configuration)
  end

  it "should allow the configuration to be overridden" do
    class FakeConfiguration; end

    @fake = FakeConfiguration.new
    Mercury.configuration = @fake
    Mercury.configuration.should == @fake
  end
end
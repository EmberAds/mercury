require 'lib/mercury'

describe Mercury::Job do
  describe "when given a valid category" do
    it "should send a POST to each URL within the configuration file" do
      Mercury::Configure.when_receiving "hello", send_to: ["http://www.example.com", "http://www.whatever.com/wherever"]
    end
  end

  describe "when given an invalid category" do
    it "should do nothing"
  end
end
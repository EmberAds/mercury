require './lib/mercury'

describe Mercury::Job do
  describe "when given a valid category" do
    it "should send a POST to each URL within the configuration file" do
      Mercury::Configuration.forward 'my_message', to: ['http://example.com']

      # fakeweb here for testing the post to example.com
      Mercury::Job.perform 'my_message', { :field => 'value', :this => 'that' }
    end
  end

  describe "when given an invalid category" do
    it "should log an error message"
  end
end
require 'spec_helper'

describe Mercury::Configuration do
  before :each do
    @configuration = Mercury::Configuration.new
  end
  
  it "should set up a response to a given message" do
    @configuration.forward 'my_message', to: ['http://www.example.com', 'http://whatever.com/wherever']

    @configuration.urls_for('my_message').should == ['http://www.example.com', 'http://whatever.com/wherever']
  end

  it "should load a configuration from a hash" do
    @configuration.load_from({
      "endpoints" => { 
        "my_message" => { 1 => 'http://www.example.com', 2 => 'http://somewhere.com' },
        "another_message" => { 1 => 'http://this.com', 2 => 'http://that.com' }
      }
    })

    @configuration.urls_for('my_message').should == ['http://www.example.com', 'http://somewhere.com']
    @configuration.urls_for('another_message').should == ['http://this.com', 'http://that.com']
  end

  it "should load a configuration from a YAML file" do
    @configuration.load_from File.join('spec', 'fixtures', 'config.yml')

    @configuration.urls_for('my_message').should == ['http://this.com', 'http://that.com']
    @configuration.urls_for('another_message').should == ['http://theother.com']
  end

  it "should store and retrieve arbitrary data" do
    @configuration.load_from some: { arbitrary: :data }
    @configuration[:some][:arbitrary].should == :data
  end


end
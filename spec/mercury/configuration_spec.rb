require './lib/mercury'

describe Mercury::Configuration do
  after :each do
    Mercury::Configuration.reset
  end
  
  it "should set up a response to a given message" do
    Mercury::Configuration.forward 'my_message', to: ['http://www.example.com', 'http://whatever.com/wherever']

    Mercury::Configuration.urls_for('my_message').should == ['http://www.example.com', 'http://whatever.com/wherever']
  end

  it "should load a configuration from a hash" do
    Mercury::Configuration.load_from({
      "my_message" => { 1 => 'http://www.example.com', 2 => 'http://somewhere.com' },
      "another_message" => { 1 => 'http://this.com', 2 => 'http://that.com' }
    })

    Mercury::Configuration.urls_for('my_message').should == ['http://www.example.com', 'http://somewhere.com']
    Mercury::Configuration.urls_for('another_message').should == ['http://this.com', 'http://that.com']
  end

  it "should load a configuration from a YAML file" do
    Mercury::Configuration.load_from File.join('spec', 'fixtures', 'config.yml')

    Mercury::Configuration.urls_for('my_message').should == ['http://this.com', 'http://that.com']
    Mercury::Configuration.urls_for('another_message').should == ['http://theother.com']
  end
end
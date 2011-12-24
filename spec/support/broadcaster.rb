shared_examples_for 'a broadcaster' do
  it "should push a message onto the queue" do
    @broadcaster.should_receive(:push).with('my_message', { my: :data })
    @broadcaster.queue 'my_message', my: :data
  end

  it "should take a message off the queue" do
    @broadcaster.should_receive(:pop_from).with('my_message')
    @broadcaster.retrieve_next_message_from 'my_message'
  end

  it "should push and pop messages" do
    @broadcaster.push('my_message', { my: :data })
    @broadcaster.pop_from('my_message').should == { my: :data }
  end
end
require 'spec_helper'

describe Mercury::FileSystemBroadcaster do
  before :each do
    @broadcaster = Mercury::FileSystemBroadcaster.new './tmp'
  end
  it_should_behave_like 'a broadcaster'

  it "should take its storage location from the current configuration" do
    Mercury.configuration.load_from 'file_system_broadcaster' =>  { 'location' => 'wherever' }
    @broadcaster = Mercury::FileSystemBroadcaster.new 
    @broadcaster.path.should == 'wherever'
  end
  it "should write jobs to the file system"
  it "should read jobs from the file system"
  it "should delete the jobs files when done"
end
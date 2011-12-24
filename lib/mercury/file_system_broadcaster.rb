=begin rdoc
The FileSystemBroadcaster uses the file system to queue messages.
They are stored in the given path (defaulting to ./tmp), with a folder created for each message type received.
The data is serialised to a file and then the file is deleted when the message is retrieved
=end

class Mercury::FileSystemBroadcaster
  include Mercury::Broadcaster

  attr_accessor :path

  def initialize storage_location = nil
    storage_location = Mercury.configuration['file_system_broadcaster']['location'] if storage_location.nil? && !Mercury.configuration['file_system_broadcaster'].nil?
      
    @path = storage_location
  end

  def push message_queue, data
    serialised_data = data.to_yaml
    File.open message_name_for(message_queue), 'w+' do | f | 
      f.write serialised_data
    end
  end

  def pop_from message_queue
    filename = Dir["#{path_for(message_queue)}/*.fsbm"].first
    data = YAML.load File.open(filename, 'r')
    `rm #{filename}`
    return data
  end

  def path_for message_queue
    path = File.join @path, message_queue.to_s
    `mkdir -p #{path}`
    return path
  end

  def message_name_for message_queue
    File.join path_for(message_queue), "#{Time.now.to_i.to_s}.fsbm"
  end

end
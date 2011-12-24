=begin rdoc
The configuration defines which messages should be POSTed to which URLs.  
It allows these messages to be defined individually, from a Hash or loaded from a YAML file.   
=end

class Mercury::Configuration

  # Set up the destinations for an individual message
  # USAGE:
  #     @configuration.forward 'my_message', to: ['http://here.com/endpoint', 'http://there.com/endpoint']
  def forward message, options
    endpoints[message.to_s] = options[:to]
  end

  # Which URLs are defined for the given message?
  def urls_for message
    endpoints[message.to_s]
  end

  # Load the options from a Hash or a file
  # If a string is passed in then that is assumed to be the filename of a YAML file that will be loaded
  def load_from options
    if options.is_a? String
      load_from_file options
    else
      load_from_hash options
    end
  end

  # Override the default broadcaster that the system uses
  def broadcaster= broadcaster_instance
    @broadcaster = broadcaster_instance
  end

  # Access the current broadcaster (using a Mercury::FileSystemBroadcaster by default)
  def broadcaster
    @broadcaster ||= Mercury::FileSystemBroadcaster.new
  end

  # Access any aribtrary data stored within the system
  def [] key
    options[key]
  end

  protected

  def endpoints
    options["endpoints"] ||= {}
  end

  def options
    @options ||= {}
  end

  def load_from_hash options
    @options = options
    self.broadcaster = options["broadcaster"].constantise.new unless options["broadcaster"].blank?
    endpoint_data = options["endpoints"]
    endpoint_data.each do | message, urls | 
      forward message, to: urls.values
    end unless endpoint_data.nil?
  end

  def load_from_file filename
    require 'yaml'
    load_from_hash YAML::load(File.open(filename))
  end

end
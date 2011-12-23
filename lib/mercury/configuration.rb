class Mercury::Configuration
  def self.forward message, options
    config[message.to_s] = options[:to]
  end

  def self.urls_for message
    config[message.to_s]
  end

  def self.load_from options
    if options.is_a? String
      load_from_file options
    else
      load_from_hash options
    end
  end

  def self.reset
    @@config = {}
  end

  protected

  def self.config
    @@config ||= {}
  end

  def self.load_from_hash options
    options.each do | message, urls | 
      forward message, to: urls.values
    end
  end

  def self.load_from_file filename
    require 'yaml'
    load_from_hash YAML::load(File.open(filename))
  end

end
require 'rubygems'
require 'bundler'

Bundler.require


class Mercury

  # Access the current Configuration (using an instance of Mercury::Configuration if one is not already defined)
  def self.configuration
    @@configuration ||= Mercury::Configuration.new
  end

  # Override the default Configuration object and replace it with one of your own
  def self.configuration= configuration_instance
    @@configuration = configuration_instance
  end
end

Dir['./lib/mercury/*.rb'].each do | file | 
  require file
end
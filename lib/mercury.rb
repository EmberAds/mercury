require 'rubygems'
require 'bundler'

Bundler.require

=begin rdoc
Mercury is an extremely simple publish-subscribe system that works over HTTP.  
It consists of three components - the broadcaster, the API and the worker.  

The API is a Sinatra app that listens for HTTP POSTs.  When one is received, it takes the message (and the POST parameters) and passes it to the core.  
The broadcaster takes the message and queues it for delivery.  
Finally the worker picks up the queued messages and then dispatches them as HTTP POSTs to the defined destinations.  
=end

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

require 'string_extensions'
require 'object_extensions'
require 'nil_class_extensions'

Dir['./lib/mercury/*.rb'].each do | file | 
  require file
end

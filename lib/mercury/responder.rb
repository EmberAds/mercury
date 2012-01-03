class Mercury::Responder
  attr_reader :message

  def dispatch parameters
    dispatchers.each { | d | d.dispatch! parameters }
  end

  def initialize message
    @message = message
  end

  def destination_urls
    urls = Mercury::Configuration.urls_for @message
    urls.nil? ? [] : urls
  end

  def dispatchers
    destination_urls.collect { | url | Mercury::Dispatcher.new url }
  end

  def self.respond_to message, parameters
    responder = self.new message
    responder.dispatch parameters
  end

  def self.delay
    Mercury::Responder
  end

end
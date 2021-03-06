class Mercury::Responder
  include Mercury::Delayed
  attr_reader :message

  def dispatch parameters
    dispatchers.each { | d | d.dispatch! parameters }
  end

  def initialize message
    @message = message
  end

  def destination_urls
    urls = Mercury.configuration.urls_for(@message) || []
    Mercury.logger.info "......#{urls.size} URLs found"
    return urls
  end

  def dispatchers
    destination_urls.collect { | url | Mercury::Dispatcher.new url }
  end

  def self.respond_to message, parameters
    responder = self.new message
    responder.dispatch parameters
  end

end
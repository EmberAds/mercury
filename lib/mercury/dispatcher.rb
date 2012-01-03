class Mercury::Dispatcher
  attr_accessor :url
  def initialize url
    @url = url
  end

  def dispatch! data
    Mercury.logger.info "......dispatching to #{@url}"
    EventMachine::HttpRequest.new(@url).post body: data
    # we don't actually care about the return value as long as we try to make the request
  end
end
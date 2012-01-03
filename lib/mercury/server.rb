class Mercury::Server < Sinatra::Base
  set :logging, true

  def logger
    Mercury.logger
  end

  post '/reload_configuration' do
    logger.info "...reloading configuration"
    Mercury.configuration.load_from './config/mercury.yml'
  end

  post '/:message' do
    message = params.delete "message"
    logger.info "...received #{message} with #{params.inspect}..."
    Mercury::Responder.delay.respond_to message, params
  end

end
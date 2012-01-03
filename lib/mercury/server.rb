class Mercury::Server < Sinatra::Base

  post '/reload_configuration' do
    Mercury.configuration.load_from './config/mercury.yml'
  end

  post '/:message' do
    message = params.delete :message
    Mercury::Responder.delay.respond_to message, params
  end

end
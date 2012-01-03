class Mercury::Server < Sinatra::Base

  post '/:message' do
    message = params.delete :message
    Mercury::Responder.delay.respond_to message, params
  end

end
class Mercury::Server < Sinatra::Base
  Mercury.configuration.load_from 'config/mercury.yml'

  post '/:queue' do | queue | 
    logger.info "Message received ... #{queue}: #{params.inspect}"
    Mercury.configuration.broadcaster.queue queue, params
    logger.info '... queued'
    status 201
  end
end
require 'sinatra/base'
require './lib/mercury'

Mercury.logger.info "Mercury server starting..."
Mercury.configuration.load_from './config/mercury.yml'
Mercury.logger.info "...configuration loaded"
run Mercury::Server
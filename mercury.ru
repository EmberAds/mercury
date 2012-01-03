require 'sinatra/base'
require './lib/mercury'

Mercury.configuration.load_from './config/mercury.yml'
run Mercury::Server
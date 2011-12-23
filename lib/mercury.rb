require 'rubygems'
require 'bundler'

Bundler.require

module Mercury
  Dir['./lib/mercury/*.rb'].each do | file | 
    require file
  end
end
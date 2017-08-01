# Gems
require 'rubygems'
require 'sneakers'
require 'sneakers/runner'
require 'yaml'
require 'pry'
require 'logger'
require 'mini_magick'
require 'restclient'
require 'base64'

# Source files
require_relative 'config'

module ImageProcessor
  CONFIG = Config.load
  Dir['./lib/*.rb'].each { |f| require f }
  Server.start
end

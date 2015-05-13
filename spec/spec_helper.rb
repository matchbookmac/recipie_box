ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
Bundler.require :default, :test
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file}
Capybara.app = Sinatra::Application
set :show_exceptions, false

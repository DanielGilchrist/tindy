require 'tindy/version'
require 'httparty'

Dir[File.dirname(__FILE__) + '/tindy/*.rb'].each { |file| require file }

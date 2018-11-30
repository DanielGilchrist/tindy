require 'tindy/version'
require 'httparty'
require 'retries'

Dir[File.dirname(__FILE__) + '/tindy/*.rb'].each { |file| require file }

module Tindy
  class Error < StandardError; end
end

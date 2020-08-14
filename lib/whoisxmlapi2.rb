require 'rexml/document'
require 'rexml/xpath'
require 'yaml'
require 'uri'
require 'open-uri'
require 'openssl'
require 'base64'
require 'json'

require "whoisxmlapi2/configuration"
require "whoisxmlapi2/request"
require "whoisxmlapi2/version"

module WhoisXMLAPI2
  class << self
    def configuration(params = {})
      @configuration ||= Configuration.new(params)
    end

    def config_instance
      @configuration
    end

    def configure(params = {})
      configuration(params) unless params.empty?
      raise InvalidArgument, 'Block is required' if params.empty? && !block_given?

      yield configuration if block_given?
    end
  end
end

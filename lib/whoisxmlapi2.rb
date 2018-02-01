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
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

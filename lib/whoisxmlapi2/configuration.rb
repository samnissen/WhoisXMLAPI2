module WhoisXMLAPI2
  class Configuration
    attr_accessor :username, :api_key, :secret, :url, :browser_key

    DEFAULT_SERVICE_ENDPOINT = "https://whoisxmlapi.com/whoisserver/WhoisService?".freeze

    def initialize
      @url        = DEFAULT_SERVICE_ENDPOINT
    end

    def self.set?
      WhoisXMLAPI2.configuration.url && \
      WhoisXMLAPI2.configuration.api_key
    end

    def self.set_v1?
      WhoisXMLAPI2.configuration.url && \
      WhoisXMLAPI2.configuration.username && \
      WhoisXMLAPI2.configuration.api_key && \
      WhoisXMLAPI2.configuration.secret
    end
  end
end

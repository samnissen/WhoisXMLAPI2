module WhoisXMLAPI2
  class Configuration
    attr_accessor :username, :api_key, :secret, :url, :browser_key,
                  :mock_out_for_testing

    DEFAULT_SERVICE_ENDPOINT = "https://whoisxmlapi.com/whoisserver/WhoisService?".freeze

    def initialize(params = {})
      apply_configuration(params)
    end

    class << self
      def set?
        WhoisXMLAPI2.configuration.url && \
        WhoisXMLAPI2.configuration.api_key || \
        WhoisXMLAPI2.configuration.mock_out_for_testing
      end

      def set_v1?
        WhoisXMLAPI2.configuration.url && \
        WhoisXMLAPI2.configuration.username && \
        WhoisXMLAPI2.configuration.api_key && \
        WhoisXMLAPI2.configuration.secret || \
        WhoisXMLAPI2.configuration.mock_out_for_testing
      end
    end

    def apply_configuration(params)
      params[:url] ||= DEFAULT_SERVICE_ENDPOINT

      @username = params[:username]
      @api_key = params[:api_key]
      @secret = params[:secret]
      @url = params[:url]
      @browser_key = params[:browser_key]
      @mock_out_for_testing = params[:mock_out_for_testing]
    end
  end
end

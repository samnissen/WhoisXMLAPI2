module WhoisXMLAPI2
  class Request
    class << self
      def go(domain)
        timestamp = (Time.now.to_f * 1000).to_i
        digest = generate_digest(timestamp)

        JSON.parse(open(config.url + params(digest, domain, timestamp)).read)
      end

      private
        def generate_digest(timestamp)
          digest = config.username + timestamp.to_s + config.api_key

          URI.escape(OpenSSL::HMAC.hexdigest(OpenSSL::Digest::MD5.new, config.secret, digest))
        end

        def params(digest, domain, timestamp)
          "requestObject=#{prepare_data(timestamp)}&digest=#{digest}&domainName=#{domain}&outputFormat=json"
        end

        def prepare_data(timestamp)
          Base64.encode64( { u: config.username, t: timestamp }.to_json )
        end

        def config
          raise 'Missing configuration' unless WhoisXMLAPI2::Configuration.set?

          WhoisXMLAPI2.configuration
        end
    end
  end
end

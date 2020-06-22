module WhoisXMLAPI2
  class Request
    class << self
      def go(domain)
        return fixture_value if config.mock_out_for_testing

        JSON.parse(open(config.url + params(domain)).read)
      end

      private
        def params(domain)
          "apiKey=#{config.api_key}&domainName=#{domain}&outputFormat=json"
        end

        def config
          raise 'Missing configuration' unless WhoisXMLAPI2::Configuration.set?

          WhoisXMLAPI2.configuration
        end

        def fixture_value
          directory = File.dirname(File.expand_path(__FILE__))
          dir_pattern = File.join(directory, "assets/api-response-*")
          file_path = Dir[dir_pattern].sample

          JSON.parse(File.read(file_path))
        end
    end

    class V1
      class << self
        def go(domain)
          return WhoisXMLAPI2::Request.send(:fixture_value) if config.mock_out_for_testing

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
            raise 'Missing configuration' unless WhoisXMLAPI2::Configuration.set_v1?

            WhoisXMLAPI2.configuration
          end
      end
    end
  end
end

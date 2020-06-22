RSpec.describe WhoisXMLAPI2 do
  let(:username) { "ausername" }
  let(:api_key) { "anapikey-1234-5678-9012-345678901234" }
  let(:secret) {
    "a6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385/s="
  }

  it "has a version number" do
    expect(WhoisXMLAPI2::VERSION).not_to be nil
  end

  describe "Configuration" do
    let(:config) { WhoisXMLAPI2.configuration }

    before(:each) {
      WhoisXMLAPI2.configure do |c|
        c.username = username
        c.api_key  = api_key
        c.secret   = secret
        config.mock_out_for_testing = false
      end
    }

    it "configures the relevant access variables" do
      expect(config.username).to eq(username)
      expect(config.api_key).to eq(api_key)
      expect(config.secret).to eq(secret)
      expect(config.url).to eq("https://whoisxmlapi.com/whoisserver/WhoisService?")
      expect(config.mock_out_for_testing).to be_falsey
    end

    it "validates its V1 configuration variables are set" do
      expect(WhoisXMLAPI2::Configuration.set_v1?).to be_truthy
    end

    it "validates its V1 configuration variables are *not* set" do
      WhoisXMLAPI2.configure do |c|
        c.username = nil
        c.api_key  = nil
        c.secret   = nil
        config.mock_out_for_testing = false
      end

      expect(WhoisXMLAPI2::Configuration.set_v1?).to be_falsey
    end

    it "validates its V2 configuration variables are set" do
      expect(WhoisXMLAPI2::Configuration.set_v1?).to be_truthy
    end

    it "validates its V2 configuration variables are *not* set" do
      WhoisXMLAPI2.configure do |c|
        c.api_key  = nil
      end

      expect(WhoisXMLAPI2::Configuration.set?).to be_falsey
    end
  end

  describe "Request::V1" do
    before(:each) do
      WhoisXMLAPI2.configure do |config|
        config.username = username
        config.api_key  = api_key
        config.secret   = secret
        config.mock_out_for_testing = false
      end
    end

    it "fetches JSON data about the domain" do
      path = "spec/fixtures/api-response-cnncom"
      obj = OpenStruct.new(read: File.read(path))
      allow(WhoisXMLAPI2::Request::V1).to receive(:open).and_return(obj)

      result = WhoisXMLAPI2::Request::V1.go("cnn.com")
      expect(result["WhoisRecord"]).not_to be_nil
    end

    context "mock value is set to true" do
      before(:each) do
        WhoisXMLAPI2.configure do |config|
          config.mock_out_for_testing = true
        end
      end

      it "returns a fixture" do
        expect(WhoisXMLAPI2.configuration.mock_out_for_testing).to be_truthy
        result = WhoisXMLAPI2::Request::V1.go("any-url.not-real/will-not:::parse")
        fixtures = []

        Dir["lib/whoisxmlapi2/assets/api-response-*"].each do |path|
          fixtures << JSON.parse(File.read(path))
        end

        expect(fixtures).to include(result)
      end

      it "does not send a request" do
        expect(WhoisXMLAPI2.configuration.mock_out_for_testing).to be_truthy
        expect(WhoisXMLAPI2::Request::V1).not_to receive(:open)
        expect(Kernel).not_to receive(:open)
        expect(OpenURI).not_to receive(:open)
        expect(self).not_to receive(:open)

        WhoisXMLAPI2::Request.go("some.fake:url.here/http://{}.shh")
      end
    end
  end

  describe "Request (version 2)" do
    before(:each) do
      WhoisXMLAPI2.configure do |config|
        config.api_key = api_key
        config.mock_out_for_testing = false
      end
    end

    it "fetches JSON data about the domain" do
      expect(WhoisXMLAPI2.configuration.mock_out_for_testing).to be_falsey
      path = "spec/fixtures/api-response-cnncom"
      obj = OpenStruct.new(read: File.read(path))
      allow(WhoisXMLAPI2::Request).to receive(:open).with(anything).and_return(obj)

      result = WhoisXMLAPI2::Request.go("fake-cnn.com.farse")
      expect(result["WhoisRecord"]).not_to be_nil
    end

    context "mock value is set to true" do
      before(:each) do
        WhoisXMLAPI2.configure do |config|
          config.mock_out_for_testing = true
        end
      end

      it "returns a fixture" do
        expect(WhoisXMLAPI2.configuration.mock_out_for_testing).to be_truthy
        result = WhoisXMLAPI2::Request.go("any-url.notrealtldhere")
        fixtures = []

        Dir["lib/whoisxmlapi2/assets/api-response-*"].each do |path|
          fixtures << JSON.parse(File.read(path))
        end

        expect(fixtures).to include(result)
      end

      it "does not send a request" do
        expect(WhoisXMLAPI2.configuration.mock_out_for_testing).to be_truthy
        expect(WhoisXMLAPI2::Request).not_to receive(:open)
        expect(Kernel).not_to receive(:open)
        expect(OpenURI).not_to receive(:open)
        expect(self).not_to receive(:open)

        WhoisXMLAPI2::Request.go("cnn.nope.false.fail.domainname:here")
      end
    end
  end

end

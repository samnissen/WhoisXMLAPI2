RSpec.describe WhoisXMLAPI2 do

  before(:all) do
    @username = "ausername"
    @api_key  = "anapikey-1234-5678-9012-345678901234"
    @secret   = "a6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385085a33fdf206ad7aa915aa6c35fea3fd34a43e76ec16c385/s="
  end

  it "has a version number" do
    expect(WhoisXMLAPI2::VERSION).not_to be nil
  end

  describe "Configuration" do
    let(:config) { WhoisXMLAPI2.configuration }

    before(:each) {
      WhoisXMLAPI2.configure do |c|
        c.username = @username
        c.api_key  = @api_key
        c.secret   = @secret
      end
    }

    it "configures the relevant access variables" do
      expect(config.username).to eq(@username)
      expect(config.api_key).to eq(@api_key)
      expect(config.secret).to eq(@secret)
      expect(config.url).to eq("https://whoisxmlapi.com/whoisserver/WhoisService?")
    end

    it "validates its V1 configuration variables are set" do
      expect(WhoisXMLAPI2::Configuration.set_v1?).to be_truthy
    end

    it "validates its V1 configuration variables are *not* set" do
      WhoisXMLAPI2.configure do |c|
        c.username = nil
        c.api_key  = nil
        c.secret   = nil
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
        config.username = @username
        config.api_key  = @api_key
        config.secret   = @secret
      end
    end

    it "fetches JSON data about the domain" do
      path = "spec/fixtures/api-response-cnncom"
      obj = OpenStruct.new(read: File.read(path))
      allow(WhoisXMLAPI2::Request::V1).to receive(:open).and_return(obj)

      result = WhoisXMLAPI2::Request::V1.go("cnn.com")
      expect(result["WhoisRecord"]).not_to be_nil
    end
  end

  describe "Request (version 2)" do
    before(:each) do
      WhoisXMLAPI2.configure do |config|
        config.api_key  = @api_key
      end
    end

    it "fetches JSON data about the domain" do
      path = "spec/fixtures/api-response-cnncom"
      obj = OpenStruct.new(read: File.read(path))
      allow(WhoisXMLAPI2::Request).to receive(:open).and_return(obj)

      result = WhoisXMLAPI2::Request.go("cnn.com")
      expect(result["WhoisRecord"]).not_to be_nil
    end
  end

end

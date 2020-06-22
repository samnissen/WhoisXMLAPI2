# WhoisXMLAPI2

WhoisXMLAPI2 is a simple Ruby interface for making requests of the WhoisXMLAPI.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'whoisxmlapi2'
```

Or install it yourself as:

    $ gem install whoisxmlapi2

## Usage

### API version 2.0

Provide your credentials

```ruby
WhoisXMLAPI2.configure do |config|
  config.api_key = "your-api-key"
end
```

Make a request

```ruby
WhoisXMLAPI2::Request.go("cnn.com")
# => {"WhoisRecord"=>{"createdDate"=>"1993-09-22T04:00:00Z", ...
```

The output is the parsed object from the the API's JSON response.

### API Version 1.0

Provide your credentials

```ruby
WhoisXMLAPI2.configure do |config|
  config.username = "your-username"
  config.api_key  = "your-api-key"
  config.secret   = "your-api-key-secret"
end
```

Make a request

```ruby
WhoisXMLAPI2::Request::V1.go("cnn.com")
# => {"WhoisRecord"=>{"createdDate"=>"1993-09-22T04:00:00Z", ...
```

The output is the parsed object from the the API's JSON response.

### Testing your application
The gem has an additional feature:
mocking responses for testing using this gem.

```ruby
WhoisXMLAPI2.configure do |config|
  config.mock_out_for_testing = true
end
```

If `mock_out_for_testing` is set to evaluate as truthy, the app will
return one of the values in the `spec/fixtures/` directory, chosen
at random, instead of making a request to the API.

#### WARNING

This value will persist in your process!
Re-set the value to false if you intend to
address the API within the same context
as you are testing it.

## Development

File bugs against the GitHub issue tracker and pull requests to match, where possible.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/samnissen/WhoisXMLAPI2. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WhoisXMLAPI2 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/whoisxmlapi2/blob/master/CODE_OF_CONDUCT.md).

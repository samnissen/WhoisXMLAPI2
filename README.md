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
WhoisXMLAPI2::Request.go("cnn.com")
# => {"WhoisRecord"=>{"createdDate"=>"1993-09-22T04:00:00Z", ...
```

The output is the API response.

## Development

TODO: This

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/samnissen/WhoisXMLAPI2. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WhoisXMLAPI2 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/whoisxmlapi2/blob/master/CODE_OF_CONDUCT.md).

# Mention::Api

A nice ruby interface to wrap the [Mention.net](mention.net) API.

## Installation

Add this line to your application's Gemfile:

    gem 'mention-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mention-api

## Developing

There are a list of acceptance specs that run against the live mention service. In order to run these specs you will need to create a file at spec/fixtures/credentials.yml. The contents should look like this:

```yaml
---
:account_id: your-account-id-here
:access_token: your-access-token-here
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

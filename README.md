# Klarna Ruby Client

An XMLRPC client for Klarna's API.

## Installation

Add this line to your application's Gemfile:

    gem 'klarna-client-ruby', github: 'klarna/klarna-client-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install klarna-client-ruby

## Supported methods

  * [get_addresses](https://integration.klarna.com/en/api/advanced-integration/functions/getaddresses)
  * [reserve_amount](https://integration.klarna.com/en/api/advanced-integration/functions/reserveamount/)
  * add_invoice
  * [activate](https://integration.klarna.com/en/api/advanced-integration/functions/activate)

## Usage

### Single store configuration

First, set up the connection settings to Klarna's API server.

    Klarna.configure do |config|
      config.hostname     = 'payment.testdrive.klarna.com'
      config.port         = 443
      config.store_id     = 7
      config.store_secret = 'supersecret'
    end

You can then execute any API request without suplying credentials:

    Klarna::Client.get_addresses(:pno => '410321-9202', :pno_encoding => 2, :type => 5)


### Multiple stores configuration

Create a client on every single request you want to make:

    client = Klarna::Client.new({
      :hostname     => 'payment.testdrive.klarna.com',
      :port         => 443,
      :store_id     => 7,
      :store_secret => 'dr.alban'
    })

You can execute any API request by using the client connection set up above:

    client.get_addresses(:pno => '410321-9202', :pno_encoding => 2, :type => 5)

## Development and Testing

In order to run this gem's tests you need to create a '.env' file in the application root path with your env variables configuration:

    cp .env.sample .env

Modify the file to define the credentials of your Klarna's test API server:

    KLARNA_URL: <hostname>
    KLARNA_PORT: <port>
    KLARNA_STORE_ID: <store_id>
    KLARNA_STORE_SECRET: <store_secret>

**Note**: When running the tests for the first time on your machine, all HTTP calls will be ran against your environment variables. The response will be recorded and stored in a fixture file at `spec/fixtures/vcr_cassettes` using the `vcr` gem. The next time you'll run the tests these recordings will be used instead of triggering an actual HTTP call.

## Contributing

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request

## License

[Apache 2.0](LICENSE)

require 'klarna/methods/get_addresses'
require 'klarna/methods/reserve_amount'
require 'klarna/methods/add_invoice'
require 'klarna/methods/activate'
require 'klarna/methods/activate_invoice'

module Klarna
  class Client
    KLARNA_API_VERSION = '4.1'
    CLIENT_NAME        = 'ruby_client'

    def initialize(options = {})
      @hostname     = options[:hostname]     || Klarna.configuration.hostname
      @port         = options[:port]         || Klarna.configuration.port
      @store_id     = options[:store_id]     || Klarna.configuration.store_id
      @store_secret = options[:store_secret] || Klarna.configuration.store_secret
    end

    def get_addresses(params)
      call_method(Klarna::Methods::GetAddresses, params)
    end

    def self.get_addresses(params)
      new.get_addresses(params)
    end

    def reserve_amount(params)
      call_method(Klarna::Methods::ReserveAmount, params)
    end

    def self.reserve_amount(params)
      new.reserve_amount(params)
    end

    def add_invoice(params)
      call_method(Klarna::Methods::AddInvoice, params)
    end

    def self.add_invoice(params)
      new.add_invoice(params)
    end

    def activate(params)
      call_method(Klarna::Methods::Activate, params)
    end

    def self.activate(params)
      new.activate(params)
    end

    def activate_invoice(params)
      call_method(Klarna::Methods::ActivateInvoice, params)
    end

    def self.activate_invoice(params)
      new.activate_invoice(params)
    end

    private

    def call_method(method, params)
      xmlrpc_params = method.xmlrpc_params(@store_id, @store_secret, KLARNA_API_VERSION, CLIENT_NAME, params)

      connection.call(method.xmlrpc_name, KLARNA_API_VERSION, CLIENT_NAME, *xmlrpc_params)
    end

    def connection
      @connection ||= Klarna::Connection.new(@hostname, @port)
    end

  end
end

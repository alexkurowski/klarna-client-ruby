require 'klarna/digest'

module Klarna
  module Methods
    module ActivateInvoice
      def self.xmlrpc_name
        'activate_invoice'
      end

      def self.xmlrpc_params(store_id, store_secret, api_version, client_name, params)
        [
          store_id,
          params[:rno],
          digest(store_id, params[:rno], store_secret),
          params.fetch(:pclass, -1),
          params.fetch(:shipment_info, {})
        ]
      end

      private

      def self.digest(store_id, rno, store_secret)
        array = [store_id, rno, store_secret]

        Klarna::Digest.for(array)
      end

    end
  end
end

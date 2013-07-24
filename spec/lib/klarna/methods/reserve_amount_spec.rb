# encoding: UTF-8

require 'spec_helper'

describe Klarna::Methods::ReserveAmount do
  describe '.xmlrpc_name' do
    it 'is reserve_amount' do
      expect(subject.xmlrpc_name).to eq('reserve_amount')
    end
  end

  describe '.xmlrpc_params' do
    context 'given the following input parameters' do
      let(:params) do
        {
          :amount           => 199,
          :billing_address  => person_address,
          :country          => 209,
          :currency         => 0,
          :delivery_address => person_address,
          :flags            => 0,
          :goods_list       => goods_list,
          :language         => 138,
          :pclass           => -1,
          :pno              => '410321-9202',
          :pno_encoding     => 2,
          :shipment_info    => {:delay_adjust => 1},
        }
      end

      let(:goods_list) do
        [
          {
            :goods => {
              :artno    => 'article#',
              :title    => 'Article Foo',
              :price    => 199,
              :vat      => 25,
              :discount => 0,
              :flags    => 32
            },
            :qty => 1
          }
        ]
      end

      let(:person_address) do
        {
          :email           => 'always_approved@klarna.com',
          :telno           => '',
          :cellno          => '0762560000',
          :fname           => 'Testperson-se',
          :lname           => 'Approved',
          :company         => '',
          :careof          => '',
          :street          => 'Stårgatan 1',
          :house_number    => '',
          :house_extension => '',
          :zip             => '12345',
          :city            => 'Ankeborg',
          :country         => 209
        }
      end

      let(:store_id)     { ENV['KLARNA_STORE_ID'] }
      let(:store_secret) { ENV['KLARNA_STORE_SECRET'] }
      let(:api_version)  { Klarna::Client::KLARNA_API_VERSION }
      let(:client_name)  { Klarna::Client::CLIENT_NAME }

      let(:method_params) do
        subject.xmlrpc_params(store_id, store_secret, api_version, client_name, params)
      end

      it 'returns an array of 26 elements' do
        expect(method_params.size).to eq(26)
      end

      it 'returns the PNO in position 0' do
        expect(method_params[0]).to eq('410321-9202')
      end

      it 'returns the gender in position 1' do
        expect(method_params[1]).to eq('')
      end

      it 'returns the amount in position 2' do
        expect(method_params[2]).to eq(199)
      end

      it 'returns the reference in position 3' do
        expect(method_params[3]).to eq('')
      end

      it 'returns the reference_code in position 4' do
        expect(method_params[4]).to eq('')
      end

      it 'returns the order id 1 in position 5' do
        expect(method_params[5]).to eq('')
      end

      it 'returns the order id 2 in position 6' do
        expect(method_params[6]).to eq('')
      end

      it 'returns the delivery address in position 7' do
        expect(method_params[7]).to eq(person_address)
      end

      it 'returns the billing address in position 8' do
        expect(method_params[8]).to eq(person_address)
      end

      it 'returns the client ip in position 9' do
        expect(method_params[9]).to eq('')
      end

      it 'returns the flags in position 10' do
        expect(method_params[10]).to eq(0)
      end

      it 'returns the currency in position 11' do
        expect(method_params[11]).to eq(0)
      end

      it 'returns the country in position 12' do
        expect(method_params[12]).to eq(209)
      end

      it 'returns the language in position 13' do
        expect(method_params[13]).to eq(138)
      end

      it 'returns the store id in position 14' do
        expect(method_params[14]).to eq(store_id)
      end

      it 'returns the digest in position 15' do
        expect(method_params[15]).to be_a(String)
      end

      it 'returns the pno encoding in position 16' do
        expect(method_params[16]).to eq(2)
      end

      it 'returns the pclass in position 17' do
        expect(method_params[17]).to eq(-1)
      end

      it 'returns the goods list in position 18' do
        expect(method_params[18]).to eq(goods_list)
      end

      it 'returns the comment in position 19' do
        expect(method_params[19]).to eq('')
      end

      it 'returns the shipment info in position 20' do
        expect(method_params[20]).to eq({:delay_adjust => 1})
      end

      it 'returns the travel info in position 21' do
        expect(method_params[21]).to eq([])
      end

      it 'returns the income expense in position 22' do
        expect(method_params[22]).to eq([])
      end

      it 'returns the bank info in position 23' do
        expect(method_params[23]).to eq([])
      end

      it 'returns the session id in position 24' do
        expect(method_params[24]).to eq({})
      end

      it 'returns the extra info in position 25' do
        expect(method_params[25]).to eq([])
      end
    end
  end
end

require "wcpay/version"
require 'wcpay/utils'
require 'wcpay/sign'
require 'wcpay/service'
require 'openssl'

module WCPay
  class << self
    attr_accessor :app_id
    attr_accessor :mch_id
    attr_accessor :app_secret
    attr_accessor :key
    
    attr_reader :apiclient_cert, :apiclient_key
    
    def set_apiclient_by_pkcs12(str, pass)
      pkcs12 = OpenSSL::PKCS12.new(str, pass)
      @apiclient_cert = pkcs12.certificate
      @apiclient_key = pkcs12.key

      pkcs12
    end
  end
end

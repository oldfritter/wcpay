require "wcpay/version"
require 'wcpay/utils'
require 'wcpay/sign'
require 'wcpay/service'

module WCPay
  class << self
    attr_accessor :app_id
    attr_accessor :mch_id
    attr_accessor :key
    attr_accessor :secret
  end
end

require "wcpay/version"
require 'wcpay/utils'
require 'wcpay/sign'
require 'wcpay/service'
require 'wcpay/notify'

module WCPay
  class << self
    attr_accessor :appId
    attr_accessor :appKey
    attr_accessor :appSecret
    attr_accessor :partnerId
    attr_accessor :partnerKey
  end
end

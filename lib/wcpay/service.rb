# require 'cgi'
# require 'open-uri'

module WCPay
  module Service
    
    
    GetBrandWCPayRequest = %w( appId timeStamp nonceStr package signType paySign )
    def self.get_brand_wcpay options={}
      options = {
        appId: WCPay.appId,
        signType: 'SHA1'        
      }.merge(Utils.stringify_keys(options))
      options[:package] = WCPay::Sign.package_sign_string(option[:package].merge({sign: WCPay::Sign.package_sign(options[:package])}))
      options[:paySign] = WCPay::Sign.generate options
      check_required_options(options, GetBrandWCPayRequest)
      options
    end
    
    # def self.query_string(options)
    #   query = options.sort.concat([['sign', WCPay::Sign.generate(options)]]).map do |key, value|
    #     "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
    #   end.join('&')
    # end

    def self.check_required_options(options, names)
      names.each do |name|
        warn("WCPay Warn: missing required option: #{name}") unless options.has_key?(name)
      end
    end
    
  end
  
end
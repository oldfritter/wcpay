module WCPay
  module Service

    UnifiedOrerWCPayRequest = %w( appid mch_id nonce_str sign body out_trade_no total_fee spbill_create_ip notify_url trade_type )
    def self.unified_order options = {}
      options = {
        appid: WCPay.app_id,
        mch_id: WCPay.mch_id,
        nonce_str: Utils.nonce_str,
        trade_type: 'NATIVE',
        sign_type: 'MD5'
      }.merge(Utils.stringify_keys(options))
      options[:sign] = WCPay::Sign.generate options
      check_required_options(options, UnifiedOrerWCPayRequest)
      
      uri = URI.parse 'https://api.mch.weixin.qq.com/pay/unifiedorder'
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true if uri.scheme == 'https'
      request = Net::HTTP::Post.new uri.request_uri
      request.body = Utils.xml_body options
      response = http.request request
      response_options = Utils.xml_parse response.body
      response_options['code_url'].gsub(/URl[：:]+/, '') # 以接口返回为准，URl或为URI
    end

    def self.close_order
      
    end
    
    def self.order_query
      
    end

    def self.check_required_options(options, names)
      names.each do |name|
        warn("WCPay Warn: missing required option: #{name}") unless options.has_key?(name)
      end
    end
    
  end
  
end
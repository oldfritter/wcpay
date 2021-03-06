module WCPay
  module Service

    UnifiedOrerWCPayRequest = %w( appid mch_id nonce_str sign body out_trade_no total_fee spbill_create_ip notify_url trade_type )
    def self.unified_order options = {}
      options = {
        appid: WCPay.app_id,
        mch_id: WCPay.mch_id,
        nonce_str: Utils.nonce_str,
        trade_type: 'NATIVE',
        fee_type: 'CNY',
        sign_type: 'MD5'
      }.merge(Utils.stringify_keys(options))
      options[:sign] = WCPay::Sign.generate options
      check_required_options(options, UnifiedOrerWCPayRequest)
      
      uri = URI.parse 'https://api.mch.weixin.qq.com/pay/unifiedorder'
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      request = Net::HTTP::Post.new uri.request_uri
      request.body = Utils.xml_body options
      response = http.request request
      response_options = Utils.xml_parse response.body
      return '' if response_options['code_url'].blank?
      response_options['code_url'].gsub(/URl[：:]+/, '') # 以接口返回为准，URl或为URI
    end

    def self.close_order
      
    end
    
    def self.order_query
      
    end
    
    RefundWCPayRequest = %w( appid mch_id nonce_str sign transaction_id out_refund_no total_fee refund_fee )
    def self.refund options = {}
      options = {
        appid: WCPay.app_id,
        mch_id: WCPay.mch_id,
        nonce_str: Utils.nonce_str,
        refund_fee_type: 'CNY',
        sign_type: 'MD5'
      }.merge(Utils.stringify_keys(options))
      options[:sign] = WCPay::Sign.generate options
      check_required_options(options, RefundWCPayRequest)
      
      uri = URI.parse 'https://api.mch.weixin.qq.com/secapi/pay/refund'
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      http.cert = WCPay.apiclient_cert
      http.key = WCPay.apiclient_key
      request = Net::HTTP::Post.new uri.request_uri
      request.body = Utils.xml_body options
      response = http.request request
      Utils.xml_parse response.body
    end

    def self.check_required_options(options, names)
      names.each do |name|
        warn("WCPay Warn: missing required option: #{name}") unless options.has_key?(name) || options.has_key?(name.to_sym)
      end
    end
    
  end
  
end
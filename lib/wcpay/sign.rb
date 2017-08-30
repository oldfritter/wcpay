require 'digest/md5'

module WCPay
  module Sign
    
    class << self
      def generate(params)
        query = params.as_json.sort.map do |key, value|
          "#{key}=#{value}"
        end.join('&') + "&key=#{WCPay.key}"
        Digest::MD5.hexdigest(query).upcase
      end

      def verify?(params)
        params = Utils.stringify_keys(params)
        sign = params.delete('sign')
        generate(params) == sign.upcase
      end
    end
    
  end
end

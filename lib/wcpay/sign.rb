require 'digest/md5'
require 'digest/sha1'

module WCPay
  module Sign
    
    class << self
      def generate(params)
        query = params.sort.map do |key, value|
          "#{key}=#{value}"
        end.join('&')
        Digest::SHA1.hexdigest query
      end
    
      def package_sign params
        query = package_sign_string params
        Digest::MD5.hexdigest("#{query}&key=#{WCPay.partnerKey}").upcase
      end
    
      def package_sign_string params
        query = params.sort.map do |key, value|
          "#{key}=#{value}"
        end.join('&')
        query
      end
    
      def verify?(params)
        params = Utils.stringify_keys(params)
        sign = params.delete('sign')
        package_sign(params) == sign.upcase
      end
    end
    
  end
end

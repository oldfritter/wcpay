require 'nokogiri'
require 'uuid'

module WCPay
  module Utils
    def self.stringify_keys(hash)
      new_hash = {}
      hash.each do |key, value|
        new_hash[(key.to_s rescue key) || key] = value
      end
      new_hash
    end
    
    def self.nonce_str
      # 随机字符串，长度要求在32位以内
      UUID.generate.gsub('-', '')
    end
    
    def self.xml_body options = {}
      xml = '<xml>'
      options.each { |key, value| xml += "<#{key}>#{value}</#{key}>" }
      xml += '</xml>'
      xml
    end
    
    def self.xml_parse xml
      options = {}
      Nokogiri::XML(xml).children[0].children.each { |node| options[node.name] = node.text }
      options
    end
    
  end
end

require_relative 'ruby_original_aes.rb'
require 'pry'

key = '0cbd426126d7c7ca577016f10ccb0c16'
text = '1c2c3c4c5c6c7c8c9c10c11c12c13c14'
data = RubyOriginalAes::encrypt(key, text)
cipher = data.unpack('H*')[0]
p data
p plain_text = RubyOriginalAes::decrypt(key, data)

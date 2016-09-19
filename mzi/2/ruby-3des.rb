require_relative 'ruby-des.rb'
require 'pry'
class Three_des
  @key1 = 'hushhush'
  @key2 = 'lalsldkk'
  @key3 = 'opndlksi'

  def self.encrypt(text)
    data = RubyDES::Block.new(text)
    key1 = RubyDES::Block.new(@key1)
    key2 = RubyDES::Block.new(@key2)
    key3 = RubyDES::Block.new(@key3)

    des1 = RubyDES::Ctx.new(data, key1)
    encrypt1 = des1.encrypt

    des2 = RubyDES::Ctx.new(encrypt1, key2)
    decrypt2 = des2.decrypt
   
    des3 = RubyDES::Ctx.new(decrypt2, key3)
    encrypt3 = des3.encrypt
  end

  def self.decrypt(text)
    data = RubyDES::Block.new(text)
    key1 = RubyDES::Block.new(@key1)
    key2 = RubyDES::Block.new(@key2)
    key3 = RubyDES::Block.new(@key3)
    
    en_des1 = RubyDES::Ctx.new(data, key3)
    decrypt1 = en_des1.decrypt

    en_des2 = RubyDES::Ctx.new(decrypt1, key2)
    encrypt2 = en_des2.encrypt

    en_des3 = RubyDES::Ctx.new(encrypt2, key1)
    decrypt3 = en_des3.decrypt
  end
end
p Three_des.decrypt(Three_des.encrypt('mysecret').string).string
p Three_des.encrypt('mysecret').string

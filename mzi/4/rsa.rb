require 'prime'
require 'pry'
require 'openssl'

module RSA
  BITS_SIZE = 24 
  BITS_SIZE_FOR_EXP = 12

  def self.quick_pow(a, p, m)
    b = 1
    while p > 0 do
      if p % 2 == 0
        p /= 2
        a = (a * a) % m
      else
        p -= 1
        b = (b * a) % m
      end
    end
    b
  end

  def self.find_inverse(a, b)
    if (b == 0)
      return [a, 1, 0]
    else
      d, x, y = self.find_inverse(b, a % b)
      return [d, y, (x - y * (a / b))]
    end
  end

  def self.text_to_blocks(text, blocksize = 64)                              # 1 hex = 4 bit => default is 256bit
    text.each_byte.reduce(""){|acc,b| acc << b.to_s(16).rjust(2, "0")} # convert text to hex (preserving leading 0 chars)
      .each_char.each_slice(blocksize).to_a                            # slice hexnumbers in pieces of blocksize
      .map{|a| a.join("").to_i(16)}                                    # convert each slice into internal number
  end

  def self.blocks_to_text(blocks)
    blocks.map{|d| d.to_s(16)}.join                                # join all blocks into one hex-string
      .each_char.each_slice(2).to_a                                # group into pairs
      .map{|s| s.join("").to_i(16)}                                # number from 2 hexdigits is byte
      .flatten.pack("C*")                                          # pack bytes into ruby-string
      .force_encoding(Encoding::default_external)                  # reset encoding
  end

  class RSA
    attr_accessor :n, :e
    def initialize
      # [p, q] pair
      @p = OpenSSL::BN::rand(BITS_SIZE).to_i
      @q = OpenSSL::BN::rand(BITS_SIZE).to_i
      # n
      @n = @p * @q
      # Euler function
      @fi = (@p - 1) * (@q - 1)
      @e = 2 ** BITS_SIZE_FOR_EXP + 1
      # find inverse for exp
      _, @d, _ = ::RSA::find_inverse(@e, @fi)
      @d += @fi if @d < 0
      binding.pry
    end

    def encrypt(blocks)
      blocks.map {|b| ::RSA::quick_pow(b, @e, @n)}
    end

    def decrypt(blocks)
      blocks.map{|b| ::RSA::quick_pow(b, @d, @n)}
    end
  end
end

rsa = RSA::RSA.new
print "Message: "
message = gets 
blocks = RSA::text_to_blocks message, 8 
print "Numbers: "; p blocks
encoded = rsa.encrypt(blocks)
print "Encrypted as: "; p encoded
decoded = rsa.decrypt(encoded)
print "Decrypted to: "; p decoded
final = RSA::blocks_to_text(decoded)
print "Decrypted Message: "; puts final

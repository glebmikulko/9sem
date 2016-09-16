require 'pry'

class Scrambler
  @alphabet_length = 26
  @a_code = 65
  def self.scramble(text)
    gamma = generate_random_string(text.length)
    gamma_text = gamma.bytes.zip(text.bytes)
    gamma_text.map {|pair| algorithm(pair.first, pair.last)}.pack('c*')
    binding.pry
  end

  def self.generate_random_string(length)
    (0...length).map { (@a_code + rand(@alphabet_length)).chr }.join
  end

  def self.algorithm(a, b)
    (a ^ b) % @alphabet_length + @a_code
  end
end

p Scrambler.scramble("HAPPYDAY")

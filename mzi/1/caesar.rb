require 'pry'
require_relative 'frequency.rb'

class Caesar
  extend Frequency
  def self.encrypt(text, offset)
    alphabet = Array('a'..'z') 
    encrypt_table = Hash[alphabet.zip(alphabet.rotate(offset))]
    text.chars.map {|c| encrypt_table.fetch(c, c)}.join('')
  end

  def self.decrypt(text)
    table = get_table.sort_by {|k, v| v}.reverse.to_h
    text_hash = Hash.new(0)
    text.chars.map {|c| text_hash[c] += 1}
    frequency_hash = text_hash.sort_by {|k, v| v}.reverse.to_h
    alphabet_hash = frequency_hash.keep_if {|k, v| ('a'..'z').include? k}
    decrypt_table = alphabet_hash.keys.zip(table.keys).to_h
    text.chars.map {|c| decrypt_table.fetch(c, c)}.join('')
  end
end

text = "Four loko ennui 3 wolf moon kale chips tattooed. Occupy actually selvage, hell of migas swag edison bulb salvia. Shoreditch quinoa kitsch organic normcore. 8-bit tattooed poke, tote bag salvia taxidermy helvetica mlkshk marfa cred vegan godard. Post-ironic gochujang wayfarers flexitarian. Gluten-free pour-over beard ennui, cray stumptown roof party. Blue bottle squid pug put a bird on it pop-up."
p Caesar.encrypt(text.downcase, 1)

text_decrypt = "gpvs mplp foovj 3 xpmg nppo lbmf dijqt ubuuppfe. pddvqz bduvbmmz tfmwbhf, ifmm pg njhbt txbh fejtpo cvmc tbmwjb. tipsfejudi rvjopb ljutdi pshbojd opsndpsf. 8-cju ubuuppfe qplf, upuf cbh tbmwjb ubyjefsnz ifmwfujdb nmltil nbsgb dsfe wfhbo hpebse. qptu-jspojd hpdivkboh xbzgbsfst gmfyjubsjbo. hmvufo-gsff qpvs-pwfs cfbse foovj, dsbz tuvnqupxo sppg qbsuz. cmvf cpuumf trvje qvh qvu b cjse po ju qpq-vq."
p Caesar.decrypt(text_decrypt)

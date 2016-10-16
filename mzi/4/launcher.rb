require_relative 'rsa'

rsa = RSA::RSA.new
print "Message: "
message = gets 
blocks = RSA::text_to_blocks message, 64 
print "Numbers: "; p blocks
encoded = rsa.encrypt(blocks)
print "Encrypted as: "; p encoded
decoded = rsa.decrypt(encoded)
print "Decrypted to: "; p decoded
final = RSA::blocks_to_text(decoded)
print "Decrypted Message: "; puts final

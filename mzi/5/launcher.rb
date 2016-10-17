require_relative 'sha1'

print "Message: "
message = gets
p Sha1::sha1(message)

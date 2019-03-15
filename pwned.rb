require 'digest'
require 'net/http'

password = ARGV[0]

# Get the hash for our password
hash = Digest::SHA1.hexdigest(password)

# Get the hashed passwords list from the pwned api
uri = URI('https://api.pwnedpasswords.com/range/' + hash[0, 5])
result_table = Net::HTTP.get(uri)

# Extract the hash of our password from the result, if its there
match = result_table.match(/#{hash[5..hash.length].swapcase}:\d+/)
if (match != nil)
  match = match.to_s
  time = match[36..match.length]
  puts('###########################  WARNING ################################')
  puts('Your password was found ' + time + ' times. Change your password now.')
else
  puts('Your password wasn\'t found. It\'s still safe... Probably.')
end

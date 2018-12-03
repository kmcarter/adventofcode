require 'digest'

salt = 'yzbqklnj'
count = 0
hash = ''
until hash.start_with? '000000'
  md5 = Digest::MD5.new
  count += 1
  md5.update (salt + count.to_s)
  hash = md5.hexdigest
end
p count
p hash
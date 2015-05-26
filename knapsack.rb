=begin
Modify the KnapsackCipher class to implement the two public functions to encrypt and decrypt:

    encrypt(plaintext, superknap, m, n)
    decrypt(ciphertext, generalknap)

The encrypt function should take a SuperKnapsack object and two prime numbers as the private key, and
the decrypt function should take an array (general knapsack) as the public key. You may take advantage
of the ModularArithmetic.invert method to find a modular inverse (e.g., ModularArithmetic.invert(41, 491) is 12)

Test your code using ruby spec/knapsack_spec.rb
=end
def encrypt(plaintext)
#default
  generalknap = [82,123,287,83,248,373,10,471]
  m=41
  n=491
  plaintext="cesar"
  #default

  binary_msg = (plaintext.unpack("B*"))[0].chars.map {|c|c.to_i}

  cipherarray=[]

  (binary_msg.each_slice(8).to_a).each do |b|
    calc_num = (b.zip(generalknap.cycle)).map { |c,d| c*d}
    cipherarray << calc_num.inject{|sum,x| sum + x }
  end

end

#plaintext = "never gonna give you up, never gonna let you down, never gonna go around and desert you, never gonna make you cry, never gonna say goodbye, never gonna tell a lie and hurt you"
puts encrypt("cesar")

=begin
#pre_encrypt = binary_msg.zip(generalknap.cycle)

#(binary_msg.each_slice(8).to_a).each {|b| (b.zip(generalknap.cycle)).map {|c,d| num << c*d}}
#num.each_slice(8) {|s|s.inject{|sum,x| num2 << sum + x }}

  #cal_num = binary_msg[i..i+7].zip(generalknap.cycle)


#encrypted = pre_encrypt.map { |c,d| c*d}
calc_num = []
calc_num2 = []
num_arr = []



calc_num = (binary_msg[0..7].zip(generalknap.cycle)).map { |c,d| c*d}
calc_num2 << calc_num.inject{|sum,x| sum + x }
binary_msg.drop(8)
calc_num=[]
=end

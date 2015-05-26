require 'prime'
require './modular_arithmetic.rb'

class SuperKnapsack
  attr_accessor :knapsack

  def self.array_sum(arr)
    arr.reduce (:+)
  end

  def initialize(arr)
    arr.each.with_index do |a, i|
      unless i==0
        if (a <= self.class.array_sum(arr[0..i-1])) then
          raise(ArgumentError, "not superincreasing at index #{i}")
        end
      end
      @knapsack = arr
    end
  end

  def primes?(m,n)
    return Prime.prime?(m) && Prime.prime?(n)
  end

  def to_general(m, n)
    argError = "arguments must both be prime" if (!primes?(m,n))
    argError = "#{n} is smaller than superincreasing knapsack" if n <= @knapsack.last
    raise(ArgumentError, argError) unless argError.nil?
    @knapsack.map {|a| (a*m)%n }
  end
end

class KnapsackCipher
  # Default values of knapsacks, primes
  M = 41
  N = 491
  DEF_SUPER = SuperKnapsack.new([2, 3, 7, 14, 30, 57, 120, 251])
  DEF_GENERAL = DEF_SUPER.to_general(M, N)

  # Encrypts plaintext
  # Params:
  # - plaintext: String object to be encrypted
  # - generalknap: Array object containing general knapsack numbers
  # Returns:
  # - Array of encrypted numbers
  def self.encrypt(plaintext, generalknap=DEF_GENERAL)
    # TODO: implement this method
    binary_msg = (plaintext.unpack("B*"))[0].chars.map {|c|c.to_i}

    cipherarray=[]

    (binary_msg.each_slice(8).to_a).each do |b|
      calc_num = (b.zip(generalknap.cycle)).map { |c,d| c*d}
      cipherarray << calc_num.inject{|sum,x| sum + x }
    end

    return cipherarray
  end

  # Decrypts encrypted Array
  # Params:
  # - cipherarray: Array of encrypted numbers
  # - superknap: SuperKnapsack object
  # - m: prime number
  # - n: prime number
  # Returns:
  # - String of plain text
  def self.decrypt(cipherarray, superknap=DEF_SUPER, m=M, n=N)
    raise(ArgumentError, "Argument should be a SuperKnapsack object"
      ) unless superknap.is_a? SuperKnapsack
    inverse_mod = ModularArithmetic.invert(m, n)
    decrypted_binary = ""
    cipherarray.each do |x|
      secret_number = (x*inverse_mod) % n
      binary =""
      superknap.reverse.each do |c|
         if c <= secret_number
           binary << '1'
           secret_number -= c
         else
           binary << '0'
         end
      end
      decrypted_binary << binary.reverse
    end
    [decrypted_binary].pack("B*")
    # TODO: implement this method
  end
end

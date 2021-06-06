require 'digest'

module Bitcoin
  module Helper
    def self.hash256(str)
      Digest::SHA256.hexdigest(Digest::SHA256.digest(str)).hex
    end

    def self.int_to_bytes(base_num, size, order)
      unless %i(big little).include?(order)
        raise ArgumentError, 'order must be either :little or :big'
      end

      byte_array = (0...size).map { |i| ((base_num >> i*8) & 0xFF).chr }
      byte_array.reverse! if order == :big
      byte_array.join
    end

    def self.bytes_to_int(bytes, order)
      unless %i(big little).include?(order)
        raise ArgumentError, 'order must be either :little or :big'
      end

      bytes.reverse! if order == :big
      (0...bytes.size).map { |i| bytes[i].ord << i*8 }.sum
    end
  end
end

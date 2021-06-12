require 'digest'

module Bitcoin
  module Helper
    def self.int_to_bytes(base_num, size, order)
      unless %i(big little).include?(order)
        raise ArgumentError, 'order must be either :little or :big'
      end

      byte_array = (0...size).map { |i| ((base_num >> i * 8) & 0xFF).chr }
      byte_array.reverse! if order == :big
      byte_array.join
    end

    def self.bytes_to_int(bytes, order)
      unless %i(big little).include?(order)
        raise ArgumentError, 'order must be either :little or :big'
      end

      bytes.reverse! if order == :big
      (0...bytes.size).map { |i| bytes[i].ord << i * 8 }.sum
    end

    def self.hash256(str)
      Digest::SHA256.digest(Digest::SHA256.digest(str))
    end

    def self.hash160(str)
      Digest::RMD160.digest(Digest::SHA256.digest(str))
    end

    BASE58_ALPHABET = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
    def self.encode_base58(bin)
      count = 0
      bin.each_byte do |byte|
        break if byte.ord != 0

        count += 1
      end

      num = Helper.bytes_to_int(bin, :big)
      prefix = '1' * count
      result = ''
      while num > 0
        num, mod = num.divmod(58)
        result = BASE58_ALPHABET[mod] + result
      end

      prefix + result
    end

    def self.encode_base58_checksum(bin)
      encode_base58(bin + hash256(bin)[0...4])
    end

    def self.read_varint(s)
      i = s.read(1).unpack('C')[0]
      case i
      when 0xfd
        Helper.bytes_to_int(s.read(2), :little)
      when 0xfe
        Helper.bytes_to_int(s.read(4), :little)
      when 0xff
        Helper.bytes_to_int(s.read(8), :little)
      else
        i
      end
    end
  end
end

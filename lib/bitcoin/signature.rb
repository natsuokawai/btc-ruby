module Bitcoin
  class Signature
    def initialize(r:, s:)
      @r = r
      @s = s
    end
    attr_reader :r, :s

    def ==(other)
      s == other.s && r == other.r
    end

    def der
      rbin = Helper.int_to_bytes(r, 32, :big)
      rbin = rbin.gsub(/^\x00*/, '')
      rbin = "\x00".b + rbin if rbin[0].ord & 0x80 != 0
      result = "\x02".b + [rbin.size].pack('C') + rbin

      sbin = Helper.int_to_bytes(s, 32, :big)
      sbin = sbin.gsub(/^\x00*/, '')
      sbin = "\x00".b + sbin if sbin[0].ord & 0x80 != 0
      result += "\x02".b + [sbin.size].pack('C') + sbin

      "\x30".b + [result.size].pack('C') + result
    end
  end
end

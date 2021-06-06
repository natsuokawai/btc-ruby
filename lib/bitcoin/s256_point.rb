module Bitcoin
  class S256Point < Point
    A = 0
    B = 7
    N = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141
    def self.generator_point
      if @g.nil?
        gx = 0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798
        gy = 0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8
        @g = S256Point.new(x: gx, y: gy)
      else
        @g
      end
    end

    def self.parse_sec(bin)
      prefix = bin[0].ord
      if prefix == 4
        x = Helper.bytes_to_int(bin[1..32], :big)
        y = Helper.bytes_to_int(bin[33..64], :big)
        return S256Point.new(x: x, y: y)
      end

      x = S256Field.new(num: Helper.bytes_to_int(bin[1..32], :big))
      y1 = (x**3 + S256Field.new(num: B)).sqrt
      y2 = S256Field.new(num: S256Field::P - y1.num)
      y = prefix.even? ? [y1, y2].find { _1.num.even? } : [y1, y2].find { _1.num.odd? }

      S256Point.new(x: x, y: y)
    end

    def initialize(x:, y:, a: S256Field.new(num: A), b: S256Field.new(num: B))
      if x.is_a? Integer
        x = S256Field.new(num: x)
        y = S256Field.new(num: y)
      end
      super(x: x, y: y, a: a, b: b)
    end

    def *(other)
      coef = other % N
      super(coef)
    end

    def verify(z:, sig:)
      s_inv = sig.s.pow(N - 2, N)
      u = z * s_inv % N
      v = sig.r * s_inv % N
      total = u * S256Point.generator_point + v * self

      total.x.num == sig.r
    end

    # Standards for Efficient Cryptography
    def sec(compressed: false)
      if compressed
        prefix = y.num.even? ? "\x02" : "\x03"
        prefix.b + Helper.int_to_bytes(x.num, 32, :big)
      else
        "\x04".b + Helper.int_to_bytes(x.num, 32, :big) + Helper.int_to_bytes(y.num, 32, :big)
      end
    end
  end
end

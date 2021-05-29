module Bitcoin
  class S256Point < Point
    A = 0
    B = 7
    N = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141
    def self.generator_point
      gx = 0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798
      gy = 0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8
      S256Point.new(x: gx, y: gy)
    end

    def initialize(x:, y:)
      if x.is_a? Integer
        x = S256Field.new(num: x)
        y = S256Field.new(num: y)
      end
      a = S256Field.new(num: A)
      b = S256Field.new(num: B)
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
  end
end

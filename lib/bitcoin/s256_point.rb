module Bitcoin
  class S256Point < Point
    A = 0
    B = 7
    N = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141
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
  end
end

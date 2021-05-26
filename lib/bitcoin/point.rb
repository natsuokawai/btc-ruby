module Bitcoin
  class Point
    attr_reader :x, :y, :a, :b

    def initialize(x:, y:, a:, b:)
      @x = x
      @y = y
      @a = a
      @b = b
      return if x.nil? && y.nil?

      if y**2 != x**3 + a * x + b
        raise ArgumentError, "(#{x}, #{y}) is not on the curve"
      end
    end

    def to_s
      x.nil? ? 'Point(Infinity)' : "Point(#{x}, #{y})_#{a}_#{b}"
    end

    def ==(other)
      x == other.x && y == other.y && a == other.a && b == other.b
    end

    def +(other)
      if a != other.a || b != other.b
        raise ArgumentError, "Points #{self}, #{other} are not on the same curve"
      end

      x1 = self.x
      y1 = self.y
      x2 = other.x
      y2 = other.y

      return other if x1.nil?
      return self if x2.nil?

      if x1 != x2
        s = (y2 - y1) / (x2 - x1)
        x3 = s**2 - x1 - x2
        y3 = s * (x1 - x3) - y1
        return Point.new(x: x3, y: y3, a: a, b: b)
      end

      return Point.new(x: nil, y: nil, a: a, b: b) if y1 != y2 || (y1 == y2 && y1.zero?)

      s = (3 * x1**2 + a) / (2 * y1)
      x3 = s**2 - 2 * x1
      y3 = s * (x1 - x3) - y1
      Point.new(x: x3, y: y3, a: a, b: b)
    end

    def *(other)
      prod = Point.new(x: nil, y: nil, a: a, b: b)
      other.times { prod += self }
      prod
    end

    # convert scalar * point to point * scalar
    def coerce(other)
      [self, other]
    end
  end
end

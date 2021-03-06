module Bitcoin
  class FieldElement
    def initialize(num:, prime:)
      raise ArgumentError, "Num #{num} not in field range 0 to #{prime}" if num >= prime || num < 0

      @num = num
      @prime = prime
    end
    attr_reader :num, :prime

    def to_s
      "FieldElement_#{num}(#{prime})"
    end

    def zero?
      num.zero?
    end

    def ==(other)
      num == other.num && prime == other.prime
    end

    def +(other)
      raise ArgumentError, 'Cannot add two numbers in different Fields' if prime != other.prime

      new_num = (num + other.num) % prime
      self.class.new(num: new_num, prime: prime)
    end

    def -(other)
      raise ArgumentError, 'Cannot add two numbers in different Fields' if prime != other.prime

      new_num = (num - other.num) % prime
      self.class.new(num: new_num, prime: prime)
    end

    def *(other)
      if other.is_a? Integer
        other = self.class.new(num: other, prime: prime)
      end
      raise ArgumentError, 'Cannot add two numbers in different Fields' if prime != other.prime

      new_num = (num * other.num) % prime
      self.class.new(num: new_num, prime: prime)
    end

    def **(other)
      self.class.new(num: num.pow(other % prime, prime), prime: prime)
    end

    def /(other)
      raise ArgumentError, 'Cannot add two numbers in different Fields' if prime != other.prime

      new_num = (num * other**(prime - 2)).num % prime
      self.class.new(num: new_num, prime: prime)
    end

    def coerce(other)
      [self, other]
    end
  end
end

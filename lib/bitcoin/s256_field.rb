module Bitcoin
  class S256Field < FieldElement
    P = 2**256 - 2**32 - 977
    def initialize(num:, prime: P)
      raise ArgumentError, "#{num} is not Integer" unless num.is_a? Integer

      super(num: num, prime: prime)
    end

    def to_s
      format("S256Field_%064<number>d", number: num)
    end
  end
end

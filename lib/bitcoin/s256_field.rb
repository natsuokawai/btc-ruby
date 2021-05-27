module Bitcoin
  class S256Field < FieldElement
    P = 2**256 - 2**32 - 977
    def initialize(num:)
      super(num: num, prime: P)
    end

    def to_s
      format("number: %064<number>d", number: num)
    end
  end
end

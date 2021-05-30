require 'securerandom'

module Bitcoin
  class PrivateKey
    def initialize(secret:)
      @secret = secret
      @point  = secret * S256Point.generator_point
    end
    attr_reader :secret, :point

    def sign(z:)
      k = SecureRandom.random_number(S256Point::N)
      r = (k * S256Point.generator_point).x.num
      k_inv = k.pow(S256Point::N - 2, S256Point::N)
      s = (z + r * secret) * k_inv % S256Point::N

      s = S256Point::N - s if s > S256Point::N / 2
      Signature.new(r: r, s: s)
    end
  end
end

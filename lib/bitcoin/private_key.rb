require 'openssl'

module Bitcoin
  class PrivateKey
    def initialize(secret:)
      @secret = secret
      @point  = secret * S256Point.generator_point
    end
    attr_reader :secret, :point

    def sign(z:)
      k = deterministic_k(z: z)
      r = (k * S256Point.generator_point).x.num
      k_inv = k.pow(S256Point::N - 2, S256Point::N)
      s = (z + r * secret) * k_inv % S256Point::N

      s = S256Point::N - s if s > S256Point::N / 2
      Signature.new(r: r, s: s)
    end

    private
      def deterministic_k(z:)
        k = "\x00".b * 32
        v = "\x01".b * 32
        z -= S256Point::N if z > S256Point::N
        z_bytes = Helper.int_to_bytes(z, 32, :big)
        secret_bytes = Helper.int_to_bytes(secret, 32, :big)
        k = OpenSSL::HMAC.digest('sha256', k, v + "\x00".b + secret_bytes + z_bytes)
        v = OpenSSL::HMAC.digest('sha256', k, v)
        k = OpenSSL::HMAC.digest('sha256', k, v + "\x01".b + secret_bytes + z_bytes)
        v = OpenSSL::HMAC.digest('sha256', k, v)
        loop do
          v = OpenSSL::HMAC.digest('sha256', k, v)
          candidate = Helper.bytes_to_int(v, :big)
          return candidate if candidate > 1 && candidate < S256Point::N

          k = OpenSSL::HMAC.digest('sha256', k, v + "\x00")
          v = OpenSSL::HMAC.digest('sha256', k, v)
        end
      end
  end
end

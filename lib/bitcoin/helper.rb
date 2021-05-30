require 'digest'

module Bitcoin
  module Helper
    def self.hash256(str)
      Digest::SHA256.hexdigest(Digest::SHA256.hexdigest(str))
    end
  end
end

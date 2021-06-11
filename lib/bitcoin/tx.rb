module Bitcoin
  class Tx
    def initialize(version:, tx_ins:, tx_outs:, locktime:, testnet: false)
      @version = version
      @tx_ins = tx_ins
      @tx_outs = tx_outs
      @locktime = locktime
      @testnet = testnet
    end
    attr_reader :version, :tx_ins, :tx_outs, :locktime, :testnet

    def id
      hash.hex
    end

    def hash
      Helper.hash256(serialize).reverse
    end

    def serialize
      "".b
    end
  end
end

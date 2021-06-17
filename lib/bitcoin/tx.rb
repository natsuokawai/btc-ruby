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
      result = Helper.int_to_bytes(version, 4, :little)
      result += Helper.encode_varint(tx_ins.size)
      result += tx_ins.map(&:serialize).join
      result += Helper.encode_varint(tx_outs.size)
      result += tx_outs.map(&:serialize).join
      result + Helper.int_to_bytes(locktime, 4, :little)
    end

    def self.parse(stream)
      serialized_version = stream.read(4)
      version = serialized_version.unpack('V*')[0]

      tx_in_size = Helper.read_varint(stream)
      tx_ins = (0..tx_in_size).map { TxIn.parse(stream) }

      tx_out_size = Helper.read_varint(stream)
      tx_outs = (0..tx_out_size).map { TxOut.parse(stream) }

      locktime = Helper.bytes_to_int(stream.read(4), :little)

      Tx.new(version: version, tx_ins: tx_ins, tx_outs: tx_outs, locktime: locktime)
    end
  end
end

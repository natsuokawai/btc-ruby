module Bitcoin
  class TxOut
    def initialize(amount:, script_pubkey:)
      @amount = amount
      @script_pubkey = script_pubkey
    end
    attr_reader :amount, :script_pubkey

    def serialize
      result = Helper.int_to_bytes(amount, 8, :little)
      result += script_pubkey.serialize
    end

    def self.parse(stream)
      amount = Helper.bytes_to_int(stream.read(8), :little)
      script_pubkey = Helper.bytes_to_int(stream.read(8), :little)

      TxOut.new(amount: amount, script_pubkey: script_pubkey)
    end
  end
end

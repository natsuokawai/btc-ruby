module Bitcoin
  class TxOut
    def initialize(amount:, script_pubkey:)
      @amount = amount
      @script_pubkey = script_pubkey
    end
    attr_reader :amount, :script_pubkey

    def to_s
      "#{amount}:#{script_pubkey}"
    end

    def serialize
      Helper.int_to_bytes(amount, 8, :little) + script_pubkey.serialize
    end

    def self.parse(stream)
      amount = Helper.bytes_to_int(stream.read(8), :little)
      script_pubkey = Script.parse(stream)

      TxOut.new(amount: amount, script_pubkey: script_pubkey)
    end
  end
end

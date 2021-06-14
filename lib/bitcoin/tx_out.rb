module Bitcoin
  class TxOut
    def initialize(amount:, script_pubkey:)
      @amount = amount
      @script_pubkey = script_pubkey
    end
    attr_reader :amount, :script_pubkey
  end
end

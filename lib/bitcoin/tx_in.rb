module Bitcoin
  class TxIn
    def initialize(prev_tx:, prev_index:, script_sig: nil, sequence: 0xffffffff)
      @prev_tx = prev_tx
      @prev_idex = prev_index
      @script_sig = script_sig.nil? ? Script.new : script_sig
      @sequence = sequence
    end
    attr_reader :prev_tx, :prev_index, :script_sig, :sequence
  end
end

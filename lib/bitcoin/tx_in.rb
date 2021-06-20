module Bitcoin
  class TxIn
    def initialize(prev_tx:, prev_index:, script_sig: nil, sequence: 0xffffffff)
      @prev_tx = prev_tx
      @prev_index = prev_index
      @script_sig = script_sig.nil? ? Script.new : script_sig
      @sequence = sequence
    end
    attr_reader :prev_tx, :prev_index, :script_sig, :sequence

    def to_s
      "#{prev_tx.hex}:#{prev_index}"
    end

    def serialize
      result = Helper.int_to_bytes(prev_tx, 32, :little)
      result += Helper.int_to_bytes(prev_index, 4, :little)
      result += script_sig.serialize
      result + Helper.int_to_bytes(sequence, 4, :little)
    end

    def self.parse(stream)
      prev_tx = Helper.bytes_to_int(stream.read(32), :little)
      prev_index = Helper.bytes_to_int(stream.read(4), :little)
      script_sig = Script.parse(stream)
      sequence = Helper.bytes_to_int(stream.read(4), :little)

      TxIn.new(prev_tx: prev_tx, prev_index: prev_index, script_sig: script_sig, sequence: sequence)
    end
  end
end

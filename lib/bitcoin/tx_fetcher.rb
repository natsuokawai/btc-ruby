require 'net/http'
require 'stringio'

module Bitcoin
  class TxFetcher
    def self.base_url(testnet: false)
      testnet ? 'https://blockstream.info/testnet/api' : 'https://blockstream.info/api'
    end

    def self.fetch(tx_id, testnet: false)
      url = "#{base_url(testnet: testnet)}/tx/#{tx_id}"
      res = Net::HTTP.get(url)
      raw = res.text.strip

      if raw[4] == 0
        raw = raw[...4] + raw[6...]
        tx = Tx.parse(StrinIO(raw), testnet: testnet)
        tx.locktime = Helper.bytes_to_int(raw[-4...], :little)
      else
        tx = Tx.parse(StringIO(raw), testnet: testnet)
      end

      raise "not the same id: #{tx.id} vs #{tx_id}" if tx.id != tx_id

      tx
    end
  end
end

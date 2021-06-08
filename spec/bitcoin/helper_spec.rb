require 'spec_helper'

module Bitcoin
  describe Helper do
    describe 'self.hash256' do
      let(:str) { 'Programming Bitcoin!' }
      let(:expected) { Helper.int_to_bytes(0x969f6056aa26f7d2795fd013fe88868d09c9f6aed96965016e1936ae47060d48, 32, :big) }
      it { expect(Helper.hash256(str)).to eq expected }
    end

    describe 'self.int_to_bytes, self.bytes_to_int' do
      let(:num) { 100 }
      let(:bytes) { Helper.int_to_bytes(num, 32, :big) }

      it { expect(Helper.bytes_to_int(bytes, :big)).to eq num }
      it { expect(Helper.bytes_to_int(bytes, :little)).not_to eq num }
    end

    describe 'self.encode_base58' do
      let(:bin) { Helper.int_to_bytes(0x7c076ff316692a3d7eb3c3bb0f8b1488cf72e1afcd929e29307032997a838a3d, 32, :big) }
      let(:expected) { '9MA8fRQrT4u8Zj8ZRd6MAiiyaxb2Y1CMpvVkHQu5hVM6' }

      it { expect(Helper.encode_base58(bin)).to eq expected }
    end
  end
end

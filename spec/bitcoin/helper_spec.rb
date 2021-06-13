require 'spec_helper'

module Bitcoin
  describe Helper do
    describe 'self.int_to_bytes, self.bytes_to_int' do
      let(:num) { 100 }
      let(:bytes) { Helper.int_to_bytes(num, 32, :big) }

      it { expect(Helper.bytes_to_int(bytes, :big)).to eq num }
      it { expect(Helper.bytes_to_int(bytes, :little)).not_to eq num }
    end

    describe 'self.hash256' do
      let(:str) { 'Programming Bitcoin!' }
      let(:expected) { Helper.int_to_bytes(0x969f6056aa26f7d2795fd013fe88868d09c9f6aed96965016e1936ae47060d48, 32, :big) }
      it { expect(Helper.hash256(str)).to eq expected }
    end

    describe 'self.encode_base58' do
      let(:bin) { Helper.int_to_bytes(0x7c076ff316692a3d7eb3c3bb0f8b1488cf72e1afcd929e29307032997a838a3d, 32, :big) }
      let(:expected) { '9MA8fRQrT4u8Zj8ZRd6MAiiyaxb2Y1CMpvVkHQu5hVM6' }

      it { expect(Helper.encode_base58(bin)).to eq expected }
    end

    describe 'self.encode_varint' do
      it { expect(Helper.encode_varint(100)).to eq  "\x64".b }
      it { expect(Helper.encode_varint(555)).to eq  "\xfd\x2b\x02".b }
      it { expect(Helper.encode_varint(70015)).to eq "\xfe\x7f\x11\x01\x00".b }
      it { expect(Helper.encode_varint(18005558675309)).to eq "\xff\x6d\xc7\xed\x3e\x60\x10\x00\x00".b }
    end

    describe 'self.read_varint' do
      it { expect(Helper.read_varint(StringIO.new("\x64".b))).to eq 100 }
      it { expect(Helper.read_varint(StringIO.new("\xfd\x2b\x02".b))).to eq 555  }
      it { expect(Helper.read_varint(StringIO.new("\xfe\x7f\x11\x01\x00".b))).to eq 70015 }
      it { expect(Helper.read_varint(StringIO.new("\xff\x6d\xc7\xed\x3e\x60\x10\x00\x00".b))).to eq 18005558675309 }
    end
  end
end

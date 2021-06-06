require 'spec_helper'

module Bitcoin
  describe Helper do
    describe 'self.hash256' do
      let(:str) { 'Programming Bitcoin!' }
      let(:expected) { '969f6056aa26f7d2795fd013fe88868d09c9f6aed96965016e1936ae47060d48'.hex }
      it { expect(Helper.hash256(str)).to eq expected } 
    end

    describe 'self.int_to_bytes, self.bytes_to_int' do
      let(:num) { 100 }
      let(:bytes) { Helper.int_to_bytes(num, 32, :big) }

      it { expect(Helper.bytes_to_int(bytes, :big)).to eq num }
      it { expect(Helper.bytes_to_int(bytes, :little)).not_to eq num }
    end
  end
end

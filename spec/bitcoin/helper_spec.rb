require 'spec_helper'

module Bitcoin
  describe Helper do
    describe 'self.hash256' do
      let(:str) { 'Programming Bitcoin!' }
      let(:expected) { '969f6056aa26f7d2795fd013fe88868d09c9f6aed96965016e1936ae47060d48'.hex }
      it { expect(Helper.hash256(str)).to eq expected } 
    end
  end
end

require 'spec_helper'

module Bitcoin
  describe Signature do
    describe '#der' do
      let(:r) { 0x37206a0610995c58074999cb9767b87af4c4978db68c06e8e6e81d282047a7c6 }
      let(:s) { 0x8ca63759c1157ebeaec0d03cecca119fc9a75bf8e6d0fa65c841c8e2738cdaec }
      let(:sig) { Signature.new(r: r, s: s) }
      let(:expected) { "0E\x02 7 j\x06\x10\x99\\X\aI\x99\xCB\x97g\xB8z\xF4\xC4\x97\x8D\xB6\x8C\x06\xE8\xE6\xE8\x1D( G\xA7\xC6\x02!\x00\x8C\xA67Y\xC1\x15~\xBE\xAE\xC0\xD0<\xEC\xCA\x11\x9F\xC9\xA7[\xF8\xE6\xD0\xFAe\xC8A\xC8\xE2s\x8C\xDA\xEC".b }

      it { expect(sig.der).to eq expected  }
    end
  end
end

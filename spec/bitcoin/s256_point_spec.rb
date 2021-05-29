require 'spec_helper'

module Bitcoin
  describe S256Point do
    describe 'self.geenrator_point' do
      it 'N * G == Inifinity' do
        expect(S256Point::N * S256Point.generator_point).to eq(S256Point.new(x: nil, y: nil))
      end
    end

    describe '#verify' do
      let(:z) { 0xbc62d4b80d9e36da29c16c5d4d9f11731f36052c72401a76c23c0fb5a9b74423 }
      let(:r) { 0x37206a0610995c58074999cb9767b87af4c4978db68c06e8e6e81d282047a7c6 }
      let(:s) { 0x8ca63759c1157ebeaec0d03cecca119fc9a75bf8e6d0fa65c841c8e2738cdaec }
      let(:px) { 0x04519fac3d910ca7e7138f7013706f619fa8f033e6ec6e09370ea38cee6a7574 }
      let(:py) { 0x82b51eab8c27c66e26c858a079bcdf4f1ada34cec420cafc7eac1a42216fb6c4 }
      let(:point) { S256Point.new(x: px, y: py) }
      let(:sig) { Signature.new(r: r, s: s) }

      it { expect(point.verify(z: z, sig: sig)).to be_truthy }
    end
  end
end

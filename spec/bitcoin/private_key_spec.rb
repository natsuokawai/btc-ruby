require 'spec_helper'

module Bitcoin
  describe PrivateKey do
    describe '#sign' do
      let(:secret) { 5000 }
      let(:z) { 1000 }

      it 'deterministic' do
        expect(PrivateKey.new(secret: secret).sign(z: z)).to eq PrivateKey.new(secret: secret).sign(z: z)
      end
    end
  end
end

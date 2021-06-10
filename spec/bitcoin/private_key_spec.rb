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

    describe '#wif' do
      it { expect(PrivateKey.new(secret: 5003).wif(compressed: true, testnet: true)).to eq 'cMahea7zqjxrtgAbB7LSGbcQUr1uX1ojuat9jZodMN8rFTv2sfUK' }
      it { expect(PrivateKey.new(secret: 2021**5).wif(compressed: false, testnet: true)).to eq '91avARGdfge8E4tZfYLoxeJ5sGBdNJQH4kvjpWAxgzczjbCwxic' }
      it { expect(PrivateKey.new(secret: 0x54321deadbeef).wif(compressed: true, testnet: false)).to eq 'KwDiBf89QgGbjEhKnhXJuH7LrciVrZi3qYjgiuQJv1h8Ytr2S53a' }
    end
  end
end

require 'spec_helper'

module Bitcoin
  describe S256Point do
    describe 'self.geenrator_point' do
      it 'N * G == Inifinity' do
        expect(S256Point::N * S256Point.generator_point).to eq(S256Point.new(x: nil, y: nil))
      end
    end
  end
end

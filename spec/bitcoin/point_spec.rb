require 'spec_helper'

module Bitcoin
  describe Point do
    describe 'add (+)' do
      it 'when either x is Inf, returns the other' do
        expect(Point.new(x: nil, y: nil, a: 5, b: 7) + Point.new(x: -1, y: 1, a: 5, b: 7)).to eq(Point.new(x: -1, y: 1, a: 5, b: 7))
        expect(Point.new(x: -1, y: 1, a: 5, b: 7) + Point.new(x: nil, y: nil, a: 5, b: 7)).to eq(Point.new(x: -1, y: 1, a: 5, b: 7))
      end

      it 'when both x are different' do
        expect(Point.new(x: 2, y: 5, a: 5, b: 7) + Point.new(x: -1, y: -1, a: 5, b: 7)).to eq(Point.new(x: 3, y: -7, a: 5, b: 7))
      end

      it 'when both x are equal and y are different' do
        expect(Point.new(x: 2, y: 5, a: 5, b: 7) + Point.new(x: 2, y: -5, a: 5, b: 7)).to eq(Point.new(x: nil, y: nil, a: 5, b: 7))
      end

      it 'when both point are euqal' do
        expect(Point.new(x: -1, y: -1, a: 5, b: 7) + Point.new(x: -1, y: -1, a: 5, b: 7)).to eq(Point.new(x: 18, y: 77, a: 5, b: 7))
      end
    end
  end
end

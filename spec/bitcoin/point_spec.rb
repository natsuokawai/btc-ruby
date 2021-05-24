require 'spec_helper'

module Bitcoin
  describe Point do
    describe 'add (+)' do
      context 'Integer' do
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

      context 'FieldElement' do
        let(:prime) { 223 }
        let(:a) { FieldElement.new(num: 0, prime: prime) }
        let(:b) { FieldElement.new(num: 7, prime: prime) }
        let(:x1) { FieldElement.new(num: 192, prime: prime) }
        let(:y1) { FieldElement.new(num: 105, prime: prime) }
        let(:x2) { FieldElement.new(num: 17, prime: prime) }
        let(:y2) { FieldElement.new(num: 56, prime: prime) }
        let(:x3) { FieldElement.new(num: 170, prime: prime) }
        let(:y3) { FieldElement.new(num: 142, prime: prime) }

        it do
          expect(Point.new(x: x1, y: y1, a: a, b: b) + Point.new(x: x2, y: y2, a: a, b: b)).to eq(Point.new(x: x3, y: y3, a: a, b: b))
        end
      end
    end
  end
end

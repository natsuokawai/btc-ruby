require 'spec_helper'

module Bitcoin
  describe FieldElement do
    let(:prime) { 19 } # F19

    describe 'add (+)' do
      it '18 + 7 == 6' do
        expect(FieldElement.new(num: 18, prime: prime) + FieldElement.new(num: 7, prime: prime)).to eq(FieldElement.new(num: 6, prime: prime))
      end
    end

    describe 'subtract (-)' do
      it '6 - 12 == 13' do
        expect(FieldElement.new(num: 6, prime: 19) - FieldElement.new(num: 12, prime: 19)).to eq(FieldElement.new(num: 13, prime: prime))
      end
    end

    describe 'multilpy (*)' do
      it '8 * 17 == 3' do
        expect(FieldElement.new(num: 8, prime: 19) * FieldElement.new(num: 17, prime: 19)).to eq(FieldElement.new(num: 3, prime: prime))
      end
    end

    describe 'power (**)' do
      it '9 ** 12 == 7' do
        expect(FieldElement.new(num: 9, prime: 19)**12).to eq(FieldElement.new(num: 7, prime: prime))
      end
    end
  end
end

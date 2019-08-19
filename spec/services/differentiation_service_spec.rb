require 'rails_helper'

RSpec.describe DifferentiationService do

  let(:service) { DifferentiationService }

  describe "#initialize" do
    it "raises error if no coefficients are supplied" do
      expect { service.new }.to raise_error
    end
  end

  describe "#call control flow" do
    let(:coefficients) { [3,2,1] }

    it "passes coefficients to #differentiate" do
      obj = service.new(coefficients)
      expect(obj).to receive(:differentiate_to_expression).with(coefficients)
      obj.call
    end

    it "returns a ServiceResult object" do
      result = service.new(coefficients).call
      expect(result).to be_a(ServiceResult)
    end

    it "returns a ServiceResult object with data" do
      result = service.new(coefficients).call
      expect(result.data).not_to be_empty
    end
  end

  describe "#call data examples" do

    context "successes" do
      it "[3,2,1] gives 6x+2" do
        coefficients = [3,2,1]
        result = service.new(coefficients).call
        expect(result.data[:expression]).to eql('6x+2')
      end

      it "[4,3,2,1] gives 12x^2+6x+2" do
        coefficients = [4,3,2,1]
        result = service.new(coefficients).call
        expect(result.data[:expression]).to eql('12x^2+6x+2')
      end

      it "[4,3,0,1] gives 12x^2+6x+2" do
        coefficients = [4,3,0,1]
        result = service.new(coefficients).call
        expect(result.data[:expression]).to eql('12x^2+6x')
      end

      it "[4,-5,0,1] gives 12x^2+6x+2" do
        coefficients = [4,-5,0,1]
        result = service.new(coefficients).call
        expect(result.data[:expression]).to eql('12x^2-10x')
      end
    end

    context "failures" do
      it "['a','b','c'] gives error" do
        coefficients = ['a','b','c']
        result = service.new(coefficients).call
        expect(result.errors).not_to be_empty
      end
    end
  end
end

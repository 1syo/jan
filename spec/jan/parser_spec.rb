require "spec_helper"

describe Jan::Parser do
  let(:code){ "1234567890123" }

  describe ".check_digit" do
    it "should return last digit" do
      actual = Jan::Parser.check_digit(code)
      expect(actual).to eq(3)
    end
  end

  describe ".body" do
    it "should return string except last digit" do
      actual = Jan::Parser.body(code)
      expect(actual).to eq("123456789012")
    end
  end

  describe ".even_digits" do
    it "should return digits in even number-th position" do
      actual = Jan::Parser.even_digits(code)
      expect(actual).to eq([2,4,6,8,0,2])
    end
  end

  describe ".odd_digits" do
    it "should return digits in odd number-th position except check_digit" do
      actual = Jan::Parser.odd_digits(code)
      expect(actual).to eq([1,3,5,7,9,1])
    end
  end
end
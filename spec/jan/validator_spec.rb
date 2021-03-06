require "spec_helper"

describe Jan::Validator do
  describe ".validate" do
    context "valid codes" do
      valid_codes.each do |code|
        it "#{code} should be valid" do
          actual = Jan::Validator.validate(code)
          expect(actual).to be true
        end
      end
    end

    context "invalid codes" do
      invalid_codes.each do |code|
        it "#{code} should be invalid" do
          actual = Jan::Validator.validate(code)
          expect(actual).to be false
        end
      end
    end
  end

  describe ".validate_size" do
    context "valid codes" do
      valid_size_codes = [8, 13].map{|n| "x" * n }

      valid_size_codes.each do |code|
        it "#{code} should be valid" do
          actual = Jan::Validator.validate_size(code)
          expect(actual).to be true
        end
      end
    end

    context "invalid codes" do
      invalid_size_codes = [1,2,3,4,5,6,7,9,10,11,12,14,15].map{|n| "x" * n }

      invalid_size_codes.each do |code|
        it "#{code} should be invalid" do
          actual = Jan::Validator.validate_size(code)
          expect(actual).to be false
        end
      end
    end
  end

  describe ".validate_check_digit" do
    context "valid codes" do
      valid_check_digit_codes = (3..15).to_a.map{|n| Jan::Random.code(n) }

      valid_check_digit_codes.each do |code|
        it "#{code} should be valid" do
          actual = Jan::Validator.validate_check_digit(code)
          expect(actual).to be true
        end
      end
    end

    context "invalid codes" do
      invalid_check_digit_codes = []
      (3..15).each do |n|
        code = Jan::Random.code(n)
        code[-1] = ((Jan::Parser.check_digit(code) + 1 ) % 10).to_s
        invalid_check_digit_codes << code
      end

      invalid_check_digit_codes.each do |code|
        it "#{code} should be invalid" do
          actual = Jan::Validator.validate_check_digit(code)
          expect(actual).to be false
        end
      end
    end
  end
end

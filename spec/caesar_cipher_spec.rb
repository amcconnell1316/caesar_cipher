require './caesar_cipher'

describe CaesarCipher do
  describe "#encode" do
    it "Shifts a few letters" do
      cipher = CaesarCipher.new
      expect(cipher.encode('abc', 2)).to eql('cde')
    end

    it "Ignores non letters" do
      cipher = CaesarCipher.new
      expect(cipher.encode('a1b2c3!! *&', 2)).to eql('c1d2e3!! *&')
    end

    it "Handles capital letters" do
      cipher = CaesarCipher.new
      expect(cipher.encode('ABC', 2)).to eql('CDE')
    end

    it "Cycles the alphabet" do
      cipher = CaesarCipher.new
      expect(cipher.encode('xyzXYZ', 3)).to eql('abcABC')
    end
  end

  describe "#decode" do
    it "Shifts a few letters" do
      cipher = CaesarCipher.new
      expect(cipher.decode('cde', 2)).to eql('abc')
    end

    it "Ignores non letters" do
      cipher = CaesarCipher.new
      expect(cipher.decode('c1d2e3!! *&', 2)).to eql('a1b2c3!! *&')
    end

    it "Handles capital letters" do
      cipher = CaesarCipher.new
      expect(cipher.decode('CDE', 2)).to eql('ABC')
    end

    it "Cycles the alphabet" do
      cipher = CaesarCipher.new
      expect(cipher.decode('abcABC', 3)).to eql('xyzXYZ')
    end
  end
end
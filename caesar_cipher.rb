# frozen_string_literal: true

class CaesarCipher
  def encode(string, num_shift)
    chars = string.bytes
    new_chars = chars.map do |char|
      do_shift(char, num_shift)
    end
    new_chars.pack('c*')
  end

  def decode(string, num_shift)
    encode(string, -num_shift)
  end

  def do_shift(char, num_shift)
    new_char = char
    if char >= 65 && char <= 90
      new_char = char + num_shift
      new_char -= 26 if new_char > 90
      new_char += 26 if new_char < 65
    elsif char >= 97 && char <= 122
      new_char = char + num_shift
      new_char -= 26 if new_char > 122
      new_char += 26 if new_char < 97
    end
    new_char
  end
end

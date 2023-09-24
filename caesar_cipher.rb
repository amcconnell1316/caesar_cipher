def encode(string, numShift)
    chars = string.bytes()
    newChars = chars.map do |char|
        newChar = char
        if char >= 65 && char <=90 
            newChar = char + numShift
            newChar -= 26 if newChar > 90
        elsif char >= 97 && char <= 122
            newChar = char + numShift
            newChar -= 26 if newChar > 122    
        end
        newChar
    end
    newChars.pack('c*')
end
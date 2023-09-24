def substrings_nested(string, dictionary)
    string_array = string.downcase.split(" ")
    string_array.reduce(Hash.new(0)) do |results, current_string|
        current_string_results = dictionary.reduce(Hash.new(0)) do |string_results, substring|
            string_results[substring] += 1 if current_string.include?(substring)
            string_results
        end
        current_string_results.each {|substring, count| results[substring] +=count}
        results
    end
end

def substrings(string, dictionary)
    downcase_string = string.downcase
    dictionary.reduce(Hash.new(0)) do |results, substring|
        found_substrings = downcase_string.scan(substring)
        results[substring] += found_substrings.length unless (found_substrings.nil? || found_substrings.length == 0)
        results
    end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
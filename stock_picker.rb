# frozen_string_literal: true

def stock_picker(prices)
  low_index = 0
  high_index = 0
  prices.each_with_index do |price_low, i_low_index|
    prices.each_with_index do |price_high, i_high_index|
      next if i_high_index <= i_low_index

      if price_high - price_low > prices[high_index] - prices[low_index]
        low_index = i_low_index
        high_index = i_high_index
      end
    end
  end
  [low_index, high_index]
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
p stock_picker([1, 3, 6, 9, 15, 8, 6, 1, 17])
p stock_picker([17, 3, 6, 9, 2, 18, 6, 10, 1])
p stock_picker([1, 13, 6, 9, 15, 8, 6, 1, 12])
p stock_picker([1, 17])

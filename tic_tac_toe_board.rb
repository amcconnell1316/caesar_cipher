# frozen_string_literal: true

# This is a class for a tic-tac-toe board
class Board
  def initialize
    @spots = Array.new(3) { Array.new(3, 0) }
  end

  def play_turn(player_symbol, spot)
    spot_downcase = spot.downcase
    return 'player must be x or o' unless %w[x o].include?(player_symbol)
    return 'invaild spot' unless spot_downcase.match(/[abc]/)
    return 'invaild spot' unless spot_downcase.match(/[123]/)

    player = convert_player_symbol(player_symbol)
    row = convert_row(spot_downcase)
    col = convert_col(spot_downcase)

    return 'spot taken' if @spots[row][col] != 0

    @spots[row][col] = player
    nil
  end

  def print_board
    puts '  A B C '
    @spots.each_with_index do |row, i|
      row_string = "#{i + 1}|"
      row.each do |spot|
        row_string += display_spot(spot)
        row_string += '|'
      end
      puts row_string
    end
  end

  def check_winner
    win_conditions = []
    win_conditions << @spots[0][0] + @spots[0][1] + @spots[0][2] # row 1
    win_conditions << @spots[1][0] + @spots[1][1] + @spots[1][2] # row 2
    win_conditions << @spots[2][0] + @spots[2][1] + @spots[2][2] # row 3
    win_conditions << @spots[0][0] + @spots[1][0] + @spots[2][0] # col A
    win_conditions << @spots[0][1] + @spots[1][1] + @spots[2][1] # col B
    win_conditions << @spots[0][2] + @spots[1][2] + @spots[2][2] # col C
    win_conditions << @spots[0][2] + @spots[1][1] + @spots[2][0] # diagonal /
    win_conditions << @spots[0][0] + @spots[1][1] + @spots[2][2] # diagonal \

    ret_val = nil
    if win_conditions.max == 3
      ret_val = 'o'
    elsif win_conditions.min == -3
      ret_val = 'x'
    elsif @spots.all? { |row| row.all? { |spot| spot != 0 } }
      ret_val = 'tie'
    end

    ret_val
  end

  private

  def display_spot(spot)
    case spot
    when 0 then ' '
    when -1 then 'x'
    when 1 then 'o'
    end
  end

  def convert_player_symbol(player_symbol)
    ret_val = nil
    case player_symbol
    when 'x'
      ret_val = -1
    when 'o'
      ret_val = 1
    end
    ret_val
  end

  def convert_row(spot)
    ret_val = nil
    if spot.include?('1')
      ret_val = 0
    elsif spot.include?('2')
      ret_val = 1
    else
      ret_val = 2
    end
    ret_val
  end

  def convert_col(spot)
    ret_val = nil
    if spot.include?('a')
      ret_val = 0
    elsif spot.include?('b')
      ret_val = 1
    else
      ret_val = 2
    end
    ret_val
  end
end

# test = Board.new
# puts test.play_turn('o','a1')
# test.play_turn('o','b1')
# test.play_turn('o','c1')
# puts test.check_winner
# test.print_board

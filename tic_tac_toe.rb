require_relative 'tic_tac_toe_board.rb'
winner = nil;
puts "Welcome to tic_tac_toe!"
player = "o"
board = Board.new

while winner.nil?
  player = (player == "o" ? "x" : "o")
  board.print_board
  puts "Player #{player}'s turn: "
  move = gets.chomp
  break if move.downcase == "quit"

  error =  board.play_turn(player, move)
  if !error.nil?
    puts error
    puts "Moves must be a combination of letter and number that correspond to an open spot"
  else
    winner = board.check_winner
  end
end

if winner.nil?
  puts "Play again soon!"
elsif  !(winner == "tie")
  board.print_board
  puts "Congratulations player #{player}! You win!"
else
  puts "It's a tie!"
end

#bugs
#overwriting a spot
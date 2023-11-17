# frozen_string_literal: true

require_relative 'tic_tac_toe_board'

class Game 
  def initialize(board = Board.new)
    @board = board
    @current_player = 'x'
  end

  def play
    puts 'Welcome to tic_tac_toe!'
    take_turn until @board.game_over?
    winner = @board.winner
    puts winner.nil? ? "It's a tie!" : "Congratulations player #{winner}! You win!"
  end

  def take_turn
    @board.print_board
    puts "Player #{@current_player}'s turn: "  
    move = player_input
    @board.play_turn(@current_player, move)  
    @current_player = (@current_player == 'o' ? 'x' : 'o')
  end

  def player_input
    move = ""
    loop do
      move = gets.chomp
      break if @board.valid_move?(move)

      puts 'Moves must be a combination of letter and number that correspond to an open spot'
    end
    move
  end
end

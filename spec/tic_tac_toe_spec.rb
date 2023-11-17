require_relative '../tic_tac_toe_board'
require_relative '../tic_tac_toe'

describe Board do
  subject(:board) { described_class.new() }
  describe 'valid_move?' do
    
    context 'when spot does not start with A, B or C' do
      it "returns false" do
        result = board.valid_move?('D3')
        expect(result).to eq(false)
      end
    end

    context 'when spot does not end with 1, 2 or 3' do
      it "returns false" do
        result = board.valid_move?('A0')
        expect(result).to eq(false)
      end
    end

    context 'when spot starts with A, B or C and ends with 1, 2, or 3' do
      it "returns true" do
        result = board.valid_move?('C2')
        expect(result).to eq(true)
      end
    end

    context 'when valid spot is already taken' do
      it "returns false" do
        new_spots = Array.new(3) { Array.new(3, 0) }
        new_spots[0][0] = 1
        board.instance_variable_set(:@spots, new_spots)
        result = board.valid_move?('A1')
        expect(result).to eq(false)
      end
    end

  end

  describe 'play_turn' do

    context 'when spot is played for player x' do
      it 'spots array is updated' do
        board.play_turn('x', 'A1')
        spots = board.instance_variable_get(:@spots)
        expect(spots[0][0]).to eq(-1)
      end
    end

    context 'when spot is played for player o' do
      it 'spots array is updated' do
        board.play_turn('o', 'A1')
        spots = board.instance_variable_get(:@spots)
        expect(spots[0][0]).to eq(1)
      end
    end
  end

  describe 'game_over' do

    before do
      allow(board).to receive(:winner).and_return(nil)
      allow(board).to receive(:board_full?).and_return(false)
    end
     
    context 'when there is a winner' do
      it 'returns true' do
        expect(board).to receive(:winner).and_return('x')
        expect(board.game_over?).to eq(true)
      end
    end

    context 'when there is no winner and the board is full' do
      it 'returns true' do
        expect(board).to receive(:board_full?).and_return(true)
        expect(board.game_over?).to eq(true)
      end
    end

    context 'when there is no winner and the board is not full' do
      it 'returns false' do
        expect(board.game_over?).to eq(false)
      end
    end
  end

  describe 'winner' do
     
    context 'when x has the top row' do
      it 'returns x' do
        new_spots = Array.new(3) { Array.new(3, 0) }
        new_spots[0][0] = -1
        new_spots[0][1] = -1
        new_spots[0][2] = -1
        board.instance_variable_set(:@spots, new_spots)
        expect(board.winner).to eq('x')
      end
    end
    
    context 'when y has the right column' do
      it 'returns x' do
        new_spots = Array.new(3) { Array.new(3, 0) }
        new_spots[0][2] = 1
        new_spots[1][2] = 1
        new_spots[2][2] = 1
        board.instance_variable_set(:@spots, new_spots)
        expect(board.winner).to eq('o')
      end
    end

  end

end

describe Game do
  let(:board) { double('board') }
  subject(:game) { described_class.new(board) }

  describe 'play' do
    before do
      allow(board).to receive(:game_over?).and_return(true)
      allow(game).to receive(:take_turn)
      allow(board).to receive(:winner).and_return(nil)
      allow(game).to receive(:puts)
    end

    context 'when game_over? is true' do
      it 'take_turn is not called' do
        expect(game).to_not receive(:take_turn)
        game.play
      end
    end

    context 'when game_over? is false twice' do
      it 'take_turn is called twice' do
        expect(board).to receive(:game_over?).and_return(false, false, true)
        expect(game).to receive(:take_turn).twice
        game.play
      end
    end

    context 'when winner is nil' do
      it 'displays tie message' do
        expect(game).to receive(:puts).with("It's a tie!")
        game.play
      end
    end

    context 'when winner is a player' do
      it 'displays winner message' do
        expect(board).to receive(:winner).and_return('x')
        expect(game).to receive(:puts).with("Congratulations player x! You win!")
        game.play
      end
    end

  end

  describe 'take_turn' do
    before do
      allow(board).to receive(:print_board)
      allow(game).to receive(:puts)
      allow(game).to receive(:player_input)
      allow(board).to receive(:play_turn)
    end

    context 'when turn is over for player x' do
      it 'swaps to player o' do
        game.instance_variable_set(:@current_player, 'x')
        expect {game.take_turn}.to change {game.instance_variable_get(:@current_player) }.to('o')
      end
    end

    context 'when turn is over for player o' do
      it 'swaps to player x' do
        game.instance_variable_set(:@current_player, 'o')
        expect {game.take_turn}.to change {game.instance_variable_get(:@current_player) }.to('x')
      end
    end

  end

  describe 'player_input' do
    before do
      allow(game).to receive(:gets).and_return('A1')
      allow(board).to receive(:valid_move?).and_return(true)
    end

    context 'when initial input is valid' do
      it 'does not display error message' do
        expect(game).to_not receive(:puts)
        game.player_input
      end
    end

    context 'when initial input is invalid' do
      it 'displays error message once' do
        allow(board).to receive(:valid_move?).and_return(false, true)
        expect(game).to receive(:puts).with('Moves must be a combination of letter and number that correspond to an open spot').once
        game.player_input
      end
    end

    context 'when input is invalid twice' do
      it 'displays the error message twice' do
        allow(board).to receive(:valid_move?).and_return(false, false, true)
        expect(game).to receive(:puts).with('Moves must be a combination of letter and number that correspond to an open spot').twice
        game.player_input
      end
    end
  end
end

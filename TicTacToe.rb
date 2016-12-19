require_relative 'Board'
require_relative 'Player'

class TicTacToe
	def initialize(players, board = Board.new)
		@board = board
		@players = players
		@tokens = players.each { |p| p.token }

		(@board.dim**2).times do
			players.each do |player|
				if @board.winner
					break
				else
					self.turn(player)
				end
			end
		end
		declare_winner(@board)
	end

	#private
	def turn(player)
		player_input = player.move(@board, @tokens)
		if player_input && @board.check_move(player_input[0], player_input[1])
			@board.play(player_input[0], player_input[1], player.token)
		else
			self.turn(player)
		end
	end

	def declare_winner(board)
		if board.winner == "DRAW"
			puts "The game is a draw."
		elsif board.winner
			puts "Player #{board.winner} wins!"
		else
			puts "The game's not over yet."
		end
	end
end

def game_tests
	b = Board.new()
	player1 = HumanPlayer.new("X")
	player2 = HumanPlayer.new("Y")
	game = TicTacToe.new([player1, player2], b)
end

game_tests
require_relative 'Board'
require_relative 'Player'

class TicTacToe
	def initialize(players, board = Board.new)
		@board = board
		@players = players
		@tokens = players.map { |p| p.token }

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
		unless @board.invalid_move(player_input[0], player_input[1])
			@board.play(player_input[0], player_input[1], player.token)
		else
			announce(@board.invalid_move(player_input[0], player_input[1]))
			self.turn(player)
		end
	end

	def declare_winner(board)
		if board.winner == "DRAW"
			announce("The game is a draw.")
		elsif board.winner
			announce("Player #{board.winner} wins!")
		else
			announce("The game's not over yet.")
		end
	end

	def announce(str)
		puts str if @players.any? { |p| p.class == HumanPlayer}
	end
end

def game_tests
	b = Board.new()
	player1 = HumanPlayer.new("X")
	player2 = AIPlayer.new("O")
	game = TicTacToe.new([player1, player2], b)
end

game_tests
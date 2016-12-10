require_relative 'Board'
require_relative 'Player'

class TicTacToe
	def initialize(players, board = Board.new)
		@board = board
		@players = players

		(@board.dim**2).times do
			players.each do |player|
				if @board.winner
					break
				else
					self.turn(player)
				end
			end
		end
		puts @board.winner
	end

	def turn(player)
		player_input = player.move(@board)
		if player_input && @board.check_move(player_input[0], player_input[1])
			@board.play(player_input[0], player_input[1], player.token)
		else
			self.turn(player)
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
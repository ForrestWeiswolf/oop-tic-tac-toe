require_relative 'Board'
require_relative 'Player'

class TicTacToe
	def initialize(players, board = Board.new)
		@board = board
		@players = players

		until @board.won? do
			players.each do |player|
				self.turn(player)
				break if @board.won?
			end
		end
		puts "Player #{@board.won?} wins!"
		#needs to account for draws
	end

	def turn(player)
		puts @board.show
		player_input = player.move
		if player_input && @board.check_move(player_input[0], player_input[1])
			@board.play(player_input[0], player_input[1], player.token)
		else
			self.turn(player)
		end
	end
end

def game_tests
	player1 = Player.new("X")
	player2 = Player.new("Y")
	game = TicTacToe.new([player1, player2])
end

game_tests
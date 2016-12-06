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
	end

	def turn(player)
		puts @board.show
		move = player.move
		row = move[0].to_i
		col = move[1].to_i
		@board.play(row, col, player.token)
	end
end

def game_tests
	player1 = Player.new("X")
	player2 = Player.new("Y")
	game = TicTacToe.new([player1, player2])
end

game_tests
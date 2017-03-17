#require_relative 'TicTacToe'
require_relative 'Board'

class Player 
	attr_reader :token

	def initialize(token = "O")
		@token = token
	end

	def to_s
		"Player #{@token}"
	end
end

class HumanPlayer < Player
	def move(board, opponents = ["X", "O"])
		puts board.show
		puts "Where would you like to place a token, player #{@token}?"
		move = parse_move(gets.chomp)
		return move	
	end

	#	private 
	def parse_move(input)
		begin
			x = input[(/^([A-Z]|[a-z])/)]
			y = input[(/((\d)+)$/)]

			unless x && y
				raise "Exception"
			end

			x = x.ord
			x = x - 65 if x >= 65 && x < 91
			x = x - 97 if x >= 97 && x < 123
			y = y.to_i - 1
		rescue
			puts "Please input a move consisting of "\
			"the letter of the row you want to play in and the "\
			"number of the column. For example, A2"
			return self.move
		else
			return [x, y]
		end
	end
end

class AIPlayer < Player
	def move(board, players)
		rank = 0
		options = possible_moves(board)
		result = options[0]

		options.each do |o|
			imaginary = board.clone
			imaginary.play(o[0], o[1], self.token)

			if self.evaluate(imaginary, players) > rank
				result = o
				puts "player #{self.token} considering #{o.inspect}: ranked #{rank}"
				rank = self.evaluate(imaginary, players)
			end
		end
		return result
	end

	def evaluate(board, opponents)
		opponents.delete(self.token)
		case board.winner 
		when self.token 
			#puts "#{self.token}: winning move!"
			return 10
		when "DRAW"
			#puts "#{self.token}: draw"
			return 0
		when true
			#puts "#{self.token}: someone else won"
			return -9
		else
			players = opponents + [self.token]
			return simulate(board, players) * -1
		end
	end

	def possible_moves(board)
		result = []
		(0...board.dim).each do |row|
			(0...board.dim).each do |col|
				result.push([row, col]) unless board.invalid_move(row, col)
			end
		end
		return result
	end

	def simulate(board, players)
		 #puts players.inspect
		imaginary_board = board.clone
		imaginary_enemy = AIPlayer.new(players[0])

		enemy_move = imaginary_enemy.move(imaginary_board, players)

		imaginary_board.play(enemy_move[0], enemy_move[1], imaginary_enemy.token)

		return imaginary_enemy.evaluate(imaginary_board, players)
	end
end


def player_tests
	p = Player.new("X")
	puts p.parse_move("A1").inspect
	puts p.parse_move("b2").inspect
	puts p.parse_move("c3").inspect
	puts p.parse_move("idk").inspect
	puts p.parse_move("12").inspect
	puts p.token
end

def ai_tests
	b1 = Board.new([["O", "X", nil], 
					["O", "O", nil],
					["X", nil, nil]])
	b2 = Board.new([[nil, "O", "X"], 
					["X", nil, "X"],
					["O", "O", nil]])
	b3 = Board.new([["X", "O", nil],
					["X", nil, nil],
					[nil, nil, nil]])
	b4 = Board.new()

	ai = AIPlayer.new()

	puts ai.move(b1, ["X", "O"]).inspect
	puts ai.move(b2, ["X", "O"]).inspect
	puts ai.move(b3, ["X", "O"]).inspect

	#puts ai.move(b4).inspect
end

ai_tests
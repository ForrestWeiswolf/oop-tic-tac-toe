class Player 
	attr_reader :token

	def initialize(t)
		@token = t
	end

	def to_s
		"Player #{@token}"
	end
	
#	private 
	def parse_move(input)
		#not sure whether it should be in Player class
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
			return false
		else
			return [x, y]
		end
	end
end

class HumanPlayer < Player
	def move(board)
		puts board.show
		puts "Where would you like to place a token, player #{@token}?"
		move = parse_move(gets.chomp)
		return move	
		# Board.play will check if the move is valid
	end
end

class AIPlayer < Player
	def move(board)
		dim = board.dim
		imaginary = nil
		(0...dim).each do |row|
			(0...dim).each do |col|
				return [row, col] if self.evaluate_move(row, col, board)
			end
		end
		return false #if no winning move was found
	end
 
	def evaluate_move(x, y, board)
		imaginary = board.clone
		imaginary.play(x, y, @token)
		return imaginary.winner == @token
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
	require_relative 'Board'
	ai = AIPlayer.new("O")
	b1 = Board.new([["O", "O", nil], 
					["X", "X", nil],
					["X", nil, nil]])
	b2 = Board.new([[nil, "O", "X"], 
					["O", "X", "X"],
					["O", "X", nil]])
	b3 = Board.new([[nil, "O", nil], 
					[nil, nil, "X"],
					["O", "X", nil]])

	puts ai.move(b1).inspect
	puts ai.move(b2).inspect
	puts ai.move(b3).inspect
end

ai_tests
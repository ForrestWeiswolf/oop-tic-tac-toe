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
	def move(board, opponents = ["X", "O"])
		opponents.delete(self.token)
		rank = 0
		possible_moves = []
		result = [0, 0]

		(0...board.dim).each do |row|
			(0...board.dim).each do |col|
				possible_moves.push([row, col]) unless board.invalid_move(row, col)
			end
		end

		possible_moves.each do |option|
			if self.evaluate_move(board, option, opponents) > rank
				result = option
				rank = self.evaluate_move(board, option, opponents)
			end
		end

		return result
	end

	def evaluate_move(board, move, opponents)
		return 6 if winning_move?(board, move, self.token) #take winning moves

		opponents.each do |opponent|
			if winning_move?(board, move, opponent)
				return 5
			end
		end #block opponents

		#create two (n-1)-in-a-rows if possible
		#return 4
		#not implememented yet

		if move[0] == move[1] && move[0] == (board.dim/2) #center square
			return 3
		end

		return 1
	end
 
	def winning_move?(board, move, players_token)
		imaginary = board.clone
		imaginary.play(move[0], move[1], players_token)
		return imaginary.winner == players_token
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
	b1 = Board.new([["O", "O", nil], 
					["X", "X", nil],
					["X", nil, nil]])
	b2 = Board.new([[nil, "O", "X"], 
					["O", "X", "X"],
					["O", "X", nil]])
	b3 = Board.new([["X", "O", nil],
					["X", nil, nil],
					[nil, nil, nil]])
	b4 = Board.new()

	ai = AIPlayer.new()

	puts ai.move(b1).inspect
	puts ai.move(b2).inspect
	puts ai.move(b3).inspect
	puts ai.move(b4).inspect
end

#ai_tests
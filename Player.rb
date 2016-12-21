class Player 
	attr_reader :token

	def initialize(board, token = "O")
		@board = board
		@token = token
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
	def move()
		puts @board.show
		puts "Where would you like to place a token, player #{@token}?"
		move = parse_move(gets.chomp)
		return move	
	end
end

class AIPlayer < Player
	def move(opponents = ["X", "O"])
		opponents.delete(self.token)
		rank = 0
		possible_moves = []
		result = [0, 0]

		(0...@board.dim).each do |row|
			(0...@board.dim).each do |col|
				possible_moves.push([row, col]) if @board.check_move(row, col)
			end
		end

		possible_moves.each do |option|
			if self.evaluate_move(option, opponents) > rank
				result = option
				rank = self.evaluate_move(option, opponents)
			end
		end
		return result
	end

	def evaluate_move(move, opponents)
		return 5 if winning_move?(move, self.token)
		opponents.each do |opponent|
			return 4 if winning_move?(move, opponent)
		end
		return 3
	end
 
	def winning_move?(move, players_token)
		imaginary = @board.clone
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
	ai1 = AIPlayer.new(b1)
	b2 = Board.new([[nil, "O", "X"], 
					["O", "X", "X"],
					["O", "X", nil]])
	ai2 = AIPlayer.new(b2)
	b3 = Board.new([[nil, "O", nil], 
					["X", nil, "X"],
					["O", "X", nil]])
	ai3 = AIPlayer.new(b3)
	b4 = Board.new()
	ai4 = AIPlayer.new(b4)

	puts ai1.move().inspect
	puts ai2.move().inspect
	puts ai3.move().inspect
	puts ai4.move().inspect
end

ai_tests
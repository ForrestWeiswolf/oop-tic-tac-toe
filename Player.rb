class Player 
	def initialize(token)
		@token = token
	end

	def token
		#couldn't get attr_reader working
		@token
	end
	
	def move
		puts "Where would you like to place a token, player #{@token}?"
		move = parse_move(gets.chomp)
		return move	
		# Board.play will check if the move is valid
	end

#	private 
	def parse_move(input)
		#assumes moves like A2, C1, etc.: row-letter followed by column number
		#should sanitiz input better - maybe with regexs? 
		#also, not sure whether it should be in Player class
		x = input[0].ord
		if x >= 65 && x < 91
			x = x - 65
		elsif x >= 97 && x < 123
			x = x - 97
		else
			puts "Please input a move consisting of \
			the letter of the row you want to play in and the \
			number of the column. For example, A2"
			return false
		end

		y = input[1].to_i - 1

		return [x, y]
	end
end

def player_tests
	p = Player.new("X")
	puts p.parse_move("A1").inspect
	puts p.parse_move("b2").inspect
	puts p.parse_move("c3").inspect
end
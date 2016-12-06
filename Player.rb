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
		move = gets.chomp
		return move	
		# Board.play will check if the move is valid
	end
end
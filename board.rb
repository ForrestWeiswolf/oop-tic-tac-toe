class Board
	attr_reader :grid, :dim
	def initialize(g=[], d = 3)
		@grid = g
		if @grid == []
			d.times {@grid.push(Array.new(d))}
		end
		@dim = @grid.length
	end

	def winner
		result = false
		lines = [[], []]
		(0...@dim).each do |i|
			lines.push @grid[i] # a row
			lines.push  @grid.collect{|r| r[i]} # a column
			lines[0].push @grid[i][i] #adding to diag starting at 0, 0
			lines[1].push @grid[@dim-i-1][i] #adding to other diag
		end
		lines.each {|line| result = "Player #{are_all(line)} wins!" if are_all(line)} #did anyone win?
		result = grid.all? {|row| row.all? {|square| square}} ? "The game is a draw." : result
		return result
	end

	def show
		result = ""
		@grid.each do |row|
			result = result + row.inspect + "\n"
		end
		return result
	end
 
	def play(x, y, token) 
		@grid[x][y] = token
	end

	def check_move(x, y)
		#not sure whether this should be in Board class or TicTacToe
		if (x > @dim-1) | (y > @dim-1) | (x < 0) | (y < 0)
		 	puts "That's not a space on the board."
		 	return false
		elsif @grid[x][y]
		 	puts "That space is already filled."
		 	return false
		else
			return true
		end
	end

	def each
		@grid.each do |row|
			row.each do |square|
				yield(square)
			end
		end
	end

	private
	def	are_all(list) 
		if list.all? {|item| item == list[0]}
			list[0] 
		else
			false
		end
	end
end


def board_tests
	empty = Board.new([], 4)
	x_col = Board.new ([["X", nil, "O"], ["X", nil, nil], ["X", "O", nil]])
	o_row = Board.new ([["O", "O", "O"], [nil, nil, nil], ["O", "O", nil]])
	o_rldiag = Board.new ([["O", "X", "X"], ["X", "O", nil], ["X", "O", "O"]])
	x_lrdiag = Board.new ([["O", "X", "X"], ["X", "X", nil], ["X", nil, "O"]])
	x_row_4x4 = Board.new ([["X", "X", "X", "X"], 
							["X", "X", nil, nil], 
							["X", nil, "O", "O"]])

	puts empty.inspect

	puts empty.winner
	puts x_col.winner
	puts o_row.winner
	puts o_rldiag.winner
	puts x_lrdiag.winner
	puts x_row_4x4.winner

	puts empty.play(0, 1, "X")
	puts empty.inspect
	empty.play(0, 1, "O")
	puts empty.inspect

	o_row.each{|s| puts s.inspect}
end

#board_tests
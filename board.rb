class Board
	def initialize(grid=[], dim = 3)
		@grid = grid
		if @grid == []
			dim.times {@grid.push(Array.new(dim))}
		end
		@dim = @grid.length
	end

	def won?
		result = false
		lines = [[], []]
		(0...@dim).each do |i|
			lines.push @grid[i] # a row
			lines.push  @grid.collect{|r| r[i]} # a column
			lines[0].push @grid[i][i] #adding to diag starting at 0, 0
			lines[1].push @grid[@dim-i-1][i] #adding to other diag
		end
		lines.each {|line| result = are_all(line) if are_all(line)}
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
		# if x > @dim-1 | y > @dim-1 | x < 0 | y < 0
		# 	return "That's not a space on the board."
		# elsif @grid[x][y]
		# 	return "That space is already filled."
		# else
			@grid[x][y] = token
		# end
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
	b1 = Board.new([], 4)
	b2 = Board.new ([["X", nil, "O"], ["X", nil, nil], ["X", "O", nil]])
	b3 = Board.new ([["O", "O", "O"], [nil, nil, nil], ["O", "O", nil]])
	b4 = Board.new ([["O", "X", "X"], ["X", "O", nil], ["X", "O", "O"]])
	b5 = Board.new ([["O", "X", "X"], ["X", "X", nil], ["X", nil, "O"]])

	puts b1.won?
	puts b1.inspect
	puts b2.won?
	puts b3.won?
	puts b4.won?
	puts b5.won?

	puts b1.play(0, 1, "X")
	puts b1.inspect
	b1.play(0, 1, "O")
	puts b1.inspect
end
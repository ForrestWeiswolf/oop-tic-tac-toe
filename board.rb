class Board
	def initialize(grid = [], dim = 3)
		@grid = grid
		dim.times {@grid.push(Array.new(dim))} if @grid == []
		@dim = grid.length
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

	def to_s
		result = ""
		@grid.each do |row|
			result = result + row.inspect + "\n"
		end
		return result
	end
 
	def occupied?(x, y)
		return true if @grid[x][y]
		false
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

b1 = Board.new ([["X", nil, nil], [nil, nil, nil], ["O", "O", nil]])
b2 = Board.new ([["X", nil, "O"], ["X", nil, nil], ["X", "O", nil]])
b3 = Board.new ([["O", "O", "O"], [nil, nil, nil], ["O", "O", nil]])
b4 = Board.new ([["O", "X", "X"], ["X", "O", nil], ["X", "O", "O"]])
b5 = Board.new ([["O", "X", "X"], ["X", "X", nil], ["X", nil, "O"]])

puts b1.won?
puts b2.won?
puts b3.won?
puts b4.won?
puts b5.won?
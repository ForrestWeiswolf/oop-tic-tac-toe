class Board
	attr_reader :grid, :dim
	def initialize(g=[], d = 3) #should be in other order
		@grid = g
		if @grid == [] #which would make this unneccessary
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
		lines.each {|line| result = are_all(line) if are_all(line)} #did anyone win?
		result = grid.all? {|row| row.all? {|square| square}} ? "DRAW" : result
		return result
	end

	def show
		result = ""
		@grid.each do |row|
			result = result + row.inspect + "\n"
		end
		return result
	end
 
	def play(row, col, token)
		@grid[row][col] = token
	end

	def clone
		new_grid = []
		@grid.each do |row|
			new_grid << row.clone
		end
		return Board.new(new_grid)
	end

	def invalid_move(x, y)
		#not sure whether this should be in Board class
		if (x > @dim-1) | (y > @dim-1) | (x < 0) | (y < 0)
		 	return "That's not a space on the board."
		elsif @grid[x][y]
		 	return "That space is already filled."
		else
			return false
		end
	end

	def	are_all(list) 
		if list.all? {|item| item == list[0]}
			list[0] 
		else
			false
		end
	end
end
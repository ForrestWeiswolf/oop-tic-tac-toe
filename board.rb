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
		@grid[x][y] = token unless @grid[x][y]
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
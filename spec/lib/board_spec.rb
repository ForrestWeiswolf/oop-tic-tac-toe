require 'Board'

describe Board do
	let(:new_board) do
		Board.new()
	end
	let(:x_col) do 
		Board.new ([["X", nil, "O"], ["X", nil, nil], ["X", "O", nil]])
	end
	let(:o_row) do 
		Board.new ([["O", "O", "O"], [nil, nil, nil], ["O", "O", nil]])
	end
	let(:o_rldiag) do 
		Board.new ([["O", "X", "X"], ["X", "O", nil], ["X", "O", "O"]])
	end
	let(:x_lrdiag) do 
		Board.new ([["O", "X", "X"], ["X", "X", nil], ["X", nil, "O"]])
	end
	let(:x_row_4x4) do 
		Board.new ([["X", "X", "X", "X"], 
					["X", "X", nil, nil], 
					["X", nil, "O", "O"], 
					[nil, nil, nil, nil]])
	end
	let(:full) do 
		Board.new ([["O", "X", "X"], ["X", "O", "O"], ["X", "O", "X"]])
	end

	it "responds to .grid" do
		expect(new_board).to respond_to(:grid)
	end
	it "responds to .dim" do
		expect(new_board).to respond_to(:dim)
	end

	it "has a two dimensional grid" do
		expect(new_board.grid[0].class).to eql(Array)
	end

	it "has a square grid" do
		expect(new_board.grid.size).to eql(new_board.grid[0].size)
	end

	describe ".new" do
		context "when not passed arguments" do
			it "defaults to being empty when initialized" do
				expect(new_board.grid.flatten.any?).to eql(false)
			end

			it "defaults to having a 3x3 grid" do 
				expect(new_board.grid.size).to eql(3)
			end
		end

		context "when passed an array as the first argument" do
			it "has that array as it's grid" do
				grid = [[nil, nil], [nil, nil]]
				board = Board.new(grid)
				expect(board.grid).to eql(grid)
			end
		end
		# context "when passed an int as the second argument" do
		# end
	end

	describe ".winner" do
		context "on a 3x3 grid" do 
			it "returns false when neither player has won" do
				expect(new_board.winner).to eql(false)
			end
			context "when a player has filled a whole column" do
				it "returns that player's token" do
					expect(x_col.winner).to eql("X")
				end
			end
			context "when a player has filled a row" do
				it "returns that player's token" do
					expect(o_row.winner).to eql("O")
				end
			end
			context "when a player has filled a diagonal" do
				it "returns that player's token" do
					expect(o_row.winner).to eql("O")
					expect(x_lrdiag.winner).to eql("X")
				end
			end
			context "when the board is full and no-one has won" do
				it "returns 'DRAW'" do
					expect(full.winner).to eql("DRAW")
				end
			end
		end

		context "on a 4x4 grid" do
			pending
		end
	end

	describe ".play" do
		it "sets the square at the given coordinates to the given value" do
			new_board.play(0, 0, "X")
			expect(new_board.grid[0][0]).to eql("X")
		end
	end

	describe ".invalid_move" do
		context "when given a valid move" do 
			it "returns false" do
				expect(new_board.invalid_move(1, 1)).to eql(false)
			end
		end
		context "when given coordinates outside the board" do 
			it "returns 'That's not a space on the board.'" do
				expect(new_board.invalid_move(1, 12)).to eql("That's not a space on the board.")
				expect(new_board.invalid_move(1, -1)).to eql("That's not a space on the board.")
			end
		end
		context "when the space is already full" do 
			it "returns 'That space is already filled.'" do
				expect(full.invalid_move(1, 1)).to eql("That space is already filled.")
			end
		end
	end
end
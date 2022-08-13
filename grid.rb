# frozen_string_literal: true

require 'rspec/autorun'

class Grid
  attr_accessor :width, :height, :gridTable

  def initialize(input)
    @width = input[0].size
    @height = input.size
		@gridTable = create_table(input)
  end

  def create_table(input)
    grid = Array.new(@height) { Array.new(@width) { Cells.new } }

		@height.times do |i|
      @width.times do |j|
				grid[i][j].status = input[i][j]
      end
    end
		grid
  end
end

class View_grid
  def show_table(grid)
    (0..grid.height - 1).each do |i|
      (0..grid.width - 1).each do |j|
        print grid.gridTable[i][j].status
      end
      puts ''
    end
  end
end

# describe Grid do
#   describe '#create_table' do
#     it 'returns 3 sets of arrays containing three dots' do
#       expect(Grid.new(3, 3).create_table).to eq([['.', '.', '.'], ['.', '.', '.'], ['.', '.', '.']])
#     end
#     it 'returns 6 sets of arrays containing two dots' do
#       expect(Grid.new(6,
#                       2).create_table).to eq([['.', '.'], ['.', '.'], ['.', '.'], ['.', '.'], ['.', '.'], ['.', '.']])
#     end
#   end
# end

class Cells
  attr_accessor :status

  def initialize
    @type_of_cell = ['.', '*']
    @status = @type_of_cell[rand(2)]
  end
end

class Neighbors
  def run_matrix(grid, posx, posy)
    neighbors = 0

    (-1..1).each do |k| # each { || }
      (-1..1).each do |l|
        next if l.zero? && k.zero?

        neighbors += alive_neighbor(posx + k, posy + l, grid) ? 1 : 0
      end
    end

    neighbors
  end

  def alive_neighbor(posx, posy, grid)
    valid_neighbor(posx, posy, grid) && grid.gridTable[posy][posx].status == '*'
  end

  def valid_neighbor(x, y, grid)
    x >= 0 && x < grid.width && y >= 0 && y < grid.height
  end
end

describe Neighbors do
  describe '#run_matrix' do
		# input = [['*.'], ['.', '¡*'], ['.', '.'], ['.', '.'], ['*', '*'], ['*', '.']];

    it 'returns 1 neighbor' do
			main = Main.new
			input = main.read_file('./example.txt')
			grid = Grid.new(input)
			neighbors = Neighbors.new()
      expect(neighbors.run_matrix(grid, 0, 0)).to eq(1)
    end
    it 'returns 3 neighbors' do
			main = Main.new
			input = main.read_file('./example.txt')
			grid = Grid.new(input)
			neighbors = Neighbors.new()
      expect(neighbors.run_matrix(grid, 1, 1)).to eq(3)
    end
    it 'returns 2 neighbors' do
			main = Main.new
			input = main.read_file('./example.txt')
			grid = Grid.new(input)
			neighbors = Neighbors.new()
      expect(neighbors.run_matrix(grid, 3, 1)).to eq(2)
    end 
  end
end

class Main
  def run
	
		input = read_file('./example.txt')
    grid = Grid.new(input)

    view_grid = View_grid.new
    view_grid.show_table(grid)
    neighbors = Neighbors.new

    puts neighbors.run_matrix(grid, 0, 0)
    puts neighbors.run_matrix(grid, 2, 0)
    puts neighbors.run_matrix(grid, 0, 2)
    puts neighbors.run_matrix(grid, 2, 2)
  end

	def read_file(path)
		file_content = []
		File.open(path, 'r') do |file|
			file_content = file.readlines
		end
		file_content
	end
end

main = Main.new
main.run

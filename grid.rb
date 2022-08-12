class Grid
    attr_accessor :width, :height, :gridTable
    def initialize(height, width)
        @width = width
        @height = height
    end

    def create_table
        @gridTable = Array.new(@height){ Array.new(@width) {'.'} }
    end
   
end

class View_grid

    def show_table(grid)
        for i in 0..grid.height-1 
            p grid.gridTable[i].join(' ')
        end
    end

end

describe Grid do
    describe "#create_table" do
        it "returns 3 sets of arrays containing three dots" do
            expect(Grid.new(3, 3).create_table).to eq([[".",".","."], [".",".","."], [".",".","."]])
        end
        it "returns 6 sets of arrays containing two dots" do
            expect(Grid.new(6, 2).create_table).to eq([[".","."], [".","."], [".","."], [".","."], [".","."], [".","."]])
      end
    end
  end

class Main
    def run

        grid = Grid.new(3, 3)
        grid.create_table

        view_grid = View_grid.new()
        view_grid.show_table(grid)
    end
end

main = Main.new
main.run

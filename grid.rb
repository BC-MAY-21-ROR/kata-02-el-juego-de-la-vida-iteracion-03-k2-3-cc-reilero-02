class Grid
    attr_accessor :width, :heigth, :gridTable
    def initialize(width,heigth)
        @width = width
        @heigth = heigth
    end

    def create_table
        @gridTable = Array.new(@heigth){ Array.new(@width) {'.'} }
    end
   
end

class View_grid

    def show_table(grid)
        for i in 0..grid.heigth-1 
            p grid.gridTable[i].join(' ')
        end
    end

end

class Main
    def run

        grid = Grid.new(3,3)
        grid.create_table

        view_grid = View_grid.new()
        view_grid.show_table(grid)
    end
end


main = Main.new
main.run

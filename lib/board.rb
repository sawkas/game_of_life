module Life
  class Board
    Cell = Struct.new(:x, :y, :active)

    attr_reader :cells

    def initialize
      @cells = []
    end

    def fill
      height.times do |y|
        width.times do |x|
          cell = Cell.new(x, y, [false, true].sample)

          # # DEFAULT FILLING WITH GLIDER
          # active = [[1, 0], [2, 1], [0, 2], [1, 2], [2, 2]].include?([x, y])
          # cell = Cell.new(x, y, active)

          cells.push(cell)
        end
      end
    end

    def step
      new_cells = []

      @cells.each do |cell|
        neighbors_count = calculate_neighbors(cell)

        next_state =
          if cell.active
            [2, 3].include?(neighbors_count)
          else
            neighbors_count == 3
          end

        cell = Cell.new(cell.x, cell.y, next_state)

        new_cells.push(cell)
      end

      @cells = new_cells
    end

    private

    def calculate_neighbors(cell)
      neighbors = 0

      ((cell.x - 1)..(cell.x + 1)).each do |x|
        ((cell.y - 1)..(cell.y + 1)).each do |y|
          next if x == cell.x && y == cell.y
          next if x < 0 || y < 0
          next if x > width - 1 || y > height - 1

          cell_to_check = cells[y * width + x]

          neighbors += 1 if cell_to_check.active
        end
      end

      neighbors
    end

    def height
      Settings.app.window.height / Settings.app.cell.size
    end

    def width
      Settings.app.window.width / Settings.app.cell.size
    end
  end
end

module Life
  class DrawingArea < Gtk::DrawingArea
    attr_reader :board

    def initialize
      super

      @board = Board.new
      @board.fill

      signal_connect('draw') do |_widget, cr|
        draw_cells(cr, board.cells)
      end
    end

    private

    def draw_cells(cr, cells)
      cells.each do |cell|
        draw_cell(cr, cell)
      end
    end

    def draw_cell(cr, cell)
      cr.rectangle(*rectangle_params(cell))
      cr.set_source_rgb(*rectangle_color(cell))
      cr.stroke

      cr.rectangle(*rectangle_params(cell))
      cr.set_source_rgba(*rectangle_color(cell), 0.7)
      cr.fill
    end

    def rectangle_params(cell)
      cell_size = Settings.app.cell.size

      side = cell_size - 2
      x = cell.x * cell_size + 1
      y = cell.y * cell_size + 1

      [x, y, side, side] # x, y, width, height
    end

    def rectangle_color(cell)
      if cell.active
        Settings.app.cell.rgb_color.active
      else
        Settings.app.cell.rgb_color.inactive
      end
    end
  end
end

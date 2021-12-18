module Life
  class ApplicationWindow < Gtk::ApplicationWindow
    type_register # Register the class in the GLib world

    def initialize(application)
      super application: application

      configure_window
      add(build_main_box)

      signal_connect('button-press-event') do |_widget, _event|
        drawing_area.board.step
        drawing_area.queue_draw
      end

      show_all
    end

    private

    def build_main_box
      main_box = Gtk::Box.new(:vertical, 0)

      main_box.pack_start(drawing_area, true, true, 0)

      main_box
    end

    def drawing_area
      @drawing_area ||= Life::DrawingArea.new
    end

    def configure_window
      set_title(Settings.app.name)
      set_border_width(10)
      set_size_request(Settings.app.window.width + 20, Settings.app.window.height + 20)
    end
  end
end

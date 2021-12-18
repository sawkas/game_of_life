module Life
  class Application < Gtk::Application
    def initialize
      super 'sawkas.life', Gio::ApplicationFlags::FLAGS_NONE

      signal_connect :activate do |application|
        window = Life::ApplicationWindow.new(application)
        window.present
      end
    end
  end
end

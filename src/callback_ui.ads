with Gtk.Widget;          use Gtk.Widget;

with Gtk.Handlers;

package Callback_UI is

   package Widget_Callback is
     new Gtk.Handlers.Callback(Widget_Type => Gtk_Widget_Record);

   package Return_Callback is
     new Gtk.Handlers.Return_Callback (Gtk_Widget_Record, Boolean);

end Callback_UI;

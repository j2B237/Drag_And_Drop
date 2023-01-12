with Gtk.Widget;              use Gtk.Widget;

package Window_Pkg.Callback is

   function On_Window_Delete_Event
     (Widget : access Gtk_Widget_Record'Class)
     return Boolean;
end Window_Pkg.Callback;

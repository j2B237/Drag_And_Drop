with Gtk.Main;

package body Window_Pkg.Callback is

   ----------------------------
   -- On_Window_Delete_Event --
   ----------------------------
   function On_Window_Delete_Event
     (Widget : access Gtk_Widget_Record'Class) return Boolean
   is
      pragma Unreferenced (Widget);
      procedure Quit renames Gtk.Main.Main_Quit;

   begin
      Quit;
      return False;
   end On_Window_Delete_Event;


end Window_Pkg.Callback;

---------------------------------
-- Application for testing     --
-- Drag And Drop               --
---------------------------------
with Gtk.Main;
with Gtk.Frame;      use Gtk.Frame;
with Window_Pkg;     use Window_Pkg;

procedure Main is
   Window : Window_Access;
begin

   Gtk.Main.Init;
   Gtk_New( Window);

   Window.Show_All;
   Window.Present;

   Gtk.Main.Main;
end Main;

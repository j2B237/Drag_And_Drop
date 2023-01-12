with Gtk.Frame;        use Gtk.Frame;
with Gtk.Window;		   use Gtk.Window;


package Window_Pkg is

   type Window_Record is new Gtk_Window_Record with record
		Window : Gtk_Window;
		Frame  : Gtk_Frame;
   end record;

   -- Interface client
   -- Pointer on Window widget
	type Window_Access is access all Window_Record'Class;


	procedure Gtk_New    ( Window : out Window_Access );
	procedure Initialize ( Window : access Window_Record'Class) ;
	function  Get_Window  return Window_Access;
   procedure Run ( Frame : access Gtk.Frame.Gtk_Frame_Record'Class);
   function  Help return String;

end Window_Pkg;

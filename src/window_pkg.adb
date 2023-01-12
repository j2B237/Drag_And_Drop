with Glib;                   use Glib;
with Glib.Values;            use Glib.Values;
with Gtk.Widget;             use Gtk.Widget;
with Gtk.Box;                use Gtk.Box;
with Gtk.Dnd;                use Gtk.Dnd;
with Gtk.Target_List;        use Gtk.Target_List;
with Gdk.Types;              use Gdk.Types;
with Gtk.Enums;              use Gtk.Enums;
with Gtk.Button;             use Gtk.Button;
with Gtk.Grid;               use Gtk.Grid;
with Gtk.Label;              use Gtk.Label;
with Gtk.Image;              use Gtk.Image;
with Gtkada.Types;           use Gtkada.Types;
with Interfaces.C.Strings;   use Interfaces.C.Strings;
with Gdk.Dnd;                use Gdk.Dnd;
with Gdk.Drag_Contexts;      use Gdk.Drag_Contexts;
with Gdk.Pixbuf;             use Gdk.Pixbuf;
with Gdk.Window;             use Gdk.Window;
with Gtk.Frame;              use Gtk.Frame;
with Gtk.Selection_Data;     use Gtk.Selection_Data;
with Callback_UI;            use Callback_UI;
with Window_Pkg.Callback;    use Window_Pkg.Callback;

package body Window_Pkg is

   --  Declaration des fonctions
   Window_Ptr : Window_Access := null;

   function "+" (S : String) return Gtkada.Types.Chars_Ptr
                 renames Gtkada.Types.New_String;

   Drag_Icon_Xpm : constant Gtkada.Types.Chars_Ptr_Array
     := "36 48 9 1"
     + "       c None"
     + ".      c #020204"
     + "+      c #8F8F90"
     + "@      c #D3D3D2"
     + "#      c #AEAEAC"
     + "$      c #ECECEC"
     + "%      c #A2A2A4"
     + "&      c #FEFEFC"
     + "*      c #BEBEBC"
     + "               ....................."
     + "              ..&&&&&&&&&&&&&&&&&&&."
     + "             ...&&&&&&&&&&&&&&&&&&&."
     + "            ..&.&&&&&&&&&&&&&&&&&&&."
     + "           ..&&.&&&&&&&&&&&&&&&&&&&."
     + "          ..&&&.&&&&&&&&&&&&&&&&&&&."
     + "         ..&&&&.&&&&&&&&&&&&&&&&&&&."
     + "        ..&&&&&.&&&@&&&&&&&&&&&&&&&."
     + "       ..&&&&&&.*$%$+$&&&&&&&&&&&&&."
     + "      ..&&&&&&&.%$%$+&&&&&&&&&&&&&&."
     + "     ..&&&&&&&&.#&#@$&&&&&&&&&&&&&&."
     + "    ..&&&&&&&&&.#$**#$&&&&&&&&&&&&&."
     + "   ..&&&&&&&&&&.&@%&%$&&&&&&&&&&&&&."
     + "  ..&&&&&&&&&&&.&&&&&&&&&&&&&&&&&&&."
     + " ..&&&&&&&&&&&&.&&&&&&&&&&&&&&&&&&&."
     + "................&$@&&&@&&&&&&&&&&&&."
     + ".&&&&&&&+&&#@%#+@#@*$%$+$&&&&&&&&&&."
     + ".&&&&&&&+&&#@#@&&@*%$%$+&&&&&&&&&&&."
     + ".&&&&&&&+&$%&#@&#@@#&#@$&&&&&&&&&&&."
     + ".&&&&&&@#@@$&*@&@#@#$**#$&&&&&&&&&&."
     + ".&&&&&&&&&&&&&&&&&&&@%&%$&&&&&&&&&&."
     + ".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&."
     + ".&&&&&&&&$#@@$&&&&&&&&&&&&&&&&&&&&&."
     + ".&&&&&&&&&+&$+&$&@&$@&&$@&&&&&&&&&&."
     + ".&&&&&&&&&+&&#@%#+@#@*$%&+$&&&&&&&&."
     + ".&&&&&&&&&+&&#@#@&&@*%$%$+&&&&&&&&&."
     + ".&&&&&&&&&+&$%&#@&#@@#&#@$&&&&&&&&&."
     + ".&&&&&&&&@#@@$&*@&@#@#$#*#$&&&&&&&&."
     + ".&&&&&&&&&&&&&&&&&&&&&$%&%$&&&&&&&&."
     + ".&&&&&&&&&&$#@@$&&&&&&&&&&&&&&&&&&&."
     + ".&&&&&&&&&&&+&$%&$$@&$@&&$@&&&&&&&&."
     + ".&&&&&&&&&&&+&&#@%#+@#@*$%$+$&&&&&&."
     + ".&&&&&&&&&&&+&&#@#@&&@*#$%$+&&&&&&&."
     + ".&&&&&&&&&&&+&$+&*@&#@@#&#@$&&&&&&&."
     + ".&&&&&&&&&&$%@@&&*@&@#@#$#*#&&&&&&&."
     + ".&&&&&&&&&&&&&&&&&&&&&&&$%&%$&&&&&&."
     + ".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&."
     + ".&&&&&&&&&&&&&&$#@@$&&&&&&&&&&&&&&&."
     + ".&&&&&&&&&&&&&&&+&$%&$$@&$@&&$@&&&&."
     + ".&&&&&&&&&&&&&&&+&&#@%#+@#@*$%$+$&&."
     + ".&&&&&&&&&&&&&&&+&&#@#@&&@*#$%$+&&&."
     + ".&&&&&&&&&&&&&&&+&$+&*@&#@@#&#@$&&&."
     + ".&&&&&&&&&&&&&&$%@@&&*@&@#@#$#*#&&&."
     + ".&&&&&&&&&&&&&&&&&&&&&&&&&&&$%&%$&&."
     + ".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&."
     + ".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&."
     + ".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&."
     + "....................................";

   Trashcan_Closed_Xpm : constant Gtkada.Types.Chars_Ptr_Array
     := "64 80 17 1"
     + "        c None"
     + ".       c #030304"
     + "+       c #5A5A5C"
     + "@       c #323231"
     + "#       c #888888"
     + "$       c #1E1E1F"
     + "%       c #767677"
     + "&       c #494949"
     + "* c #9E9E9C"
     + "= c #111111"
     + "- c #3C3C3D"
     + "; c #6B6B6B"
     + "> c #949494"
     + ", c #282828"
     + "' c #808080"
     + ") c #545454"
     + "! c #AEAEAC"
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                       ==......=$$...===                        "
     + "                 ..$------)+++++++++++++@$$...                  "
     + "             ..=@@-------&+++++++++++++++++++-....              "
     + "          =.$$@@@-&&)++++)-,$$$$=@@&+++++++++++++,..$           "
     + "         .$$$$@@&+++++++&$$$@@@@-&,$,-++++++++++;;;&..          "
     + "        $$$$,@--&++++++&$$)++++++++-,$&++++++;%%'%%;;$@         "
     + "       .-@@-@-&++++++++-@++++++++++++,-++++++;''%;;;%*-$        "
     + "       +------++++++++++++++++++++++++++++++;;%%%;;##*!.        "
     + "        =+----+++++++++++++++++++++++;;;;;;;;;;;;%'>>).         "
     + "         .=)&+++++++++++++++++;;;;;;;;;;;;;;%''>>#>#@.          "
     + "          =..=&++++++++++++;;;;;;;;;;;;;%###>>###+%==           "
     + "           .&....=-+++++%;;####''''''''''##'%%%)..#.            "
     + "           .+-++@....=,+%#####'%%%%%%%%%;@$-@-@*++!.            "
     + "           .+-++-+++-&-@$$=$=......$,,,@;&)+!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           =+-++-+++-+++++++++!++++!++++!+++!++!+++=            "
     + "            $.++-+++-+++++++++!++++!++++!+++!++!+.$             "
     + "              =.++++++++++++++!++++!++++!+++!++.=               "
     + "                 $..+++++++++++++++!++++++...$                  "
     + "                      $$=.............=$$                       "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                ";

   Trashcan_Open_Xpm : constant Gtkada.Types.Chars_Ptr_Array
     := "64 80 17 1"
     + "        c None"
     + ".       c #030304"
     + "+       c #5A5A5C"
     + "@       c #323231"
     + "#       c #888888"
     + "$       c #1E1E1F"
     + "%       c #767677"
     + "&       c #494949"
     + "*       c #9E9E9C"
     + "=       c #111111"
     + "-       c #3C3C3D"
     + ";       c #6B6B6B"
     + ">       c #949494"
     + ",       c #282828"
     + "'       c #808080"
     + ")       c #545454"
     + "!       c #AEAEAC"
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                      .=.==.,@                  "
     + "                                   ==.,@-&&&)-=                 "
     + "                                 .$@,&++;;;%>*-                 "
     + "                               $,-+)+++%%;;'#+.                 "
     + "                            =---+++++;%%%;%##@.                 "
     + "                           @)++++++++;%%%%'#%$                  "
     + "                         $&++++++++++;%%;%##@=                  "
     + "                       ,-++++)+++++++;;;'#%)                    "
     + "                      @+++&&--&)++++;;%'#'-.                    "
     + "                    ,&++-@@,,,,-)++;;;'>'+,                     "
     + "                  =-++&@$@&&&&-&+;;;%##%+@                      "
     + "                =,)+)-,@@&+++++;;;;%##%&@                       "
     + "               @--&&,,@&)++++++;;;;'#)@                         "
     + "              ---&)-,@)+++++++;;;%''+,                          "
     + "            $--&)+&$-+++++++;;;%%'';-                           "
     + "           .,-&+++-$&++++++;;;%''%&=                            "
     + "          $,-&)++)-@++++++;;%''%),                              "
     + "         =,@&)++++&&+++++;%'''+$@&++++++                        "
     + "        .$@-++++++++++++;'#';,........=$@&++++                  "
     + "       =$@@&)+++++++++++'##-.................=&++               "
     + "      .$$@-&)+++++++++;%#+$.....................=)+             "
     + "      $$,@-)+++++++++;%;@=........................,+            "
     + "     .$$@@-++++++++)-)@=............................            "
     + "     $,@---)++++&)@===............................,.            "
     + "    $-@---&)))-$$=..............................=)!.            "
     + "     --&-&&,,$=,==...........................=&+++!.            "
     + "      =,=$..=$+)+++++&@$=.............=$@&+++++!++!.            "
     + "           .)-++-+++++++++++++++++++++++++++!++!++!.            "
     + "           .+-++-+++++++++++++++++++++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!+++!!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            "
     + "           =+-++-+++-+++++++++!++++!++++!+++!++!+++=            "
     + "            $.++-+++-+++++++++!++++!++++!+++!++!+.$             "
     + "              =.++++++++++++++!++++!++++!+++!++.=               "
     + "                 $..+++++++++++++++!++++++...$                  "
     + "                      $$==...........==$$                       "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                "
     + "                                                                ";

   Have_Drag : Boolean := False;
   Log       : Gtk_Label;

   Drag_Icon       : Gdk_Pixbuf;
   Trashcan_Open   : Gdk_Pixbuf;
   Trashcan_Closed : Gdk_Pixbuf;

   My_Target_String1 : constant Guint := 0;
   My_Target_String2 : constant Guint := 1;
   My_Target_Url     : constant Guint := 2;
   My_Target_Rootwin : constant Guint := 3;

   Target_Table : constant Target_Entry_Array
     := ((+"STRING",        0, My_Target_String1),
         (+"text/plain",    0, My_Target_String2),
         (+"text/uri-list", 0, My_Target_Url),
         (+"application/x-rootwin-drop", 0,
          My_Target_Rootwin));

   Target_Table_String : constant Target_Entry_Array
     := ( (+"STRING",                     0, My_Target_String1),
          (+"text/plain",                 0, My_Target_String2),
          (+"text/uri-list",              0, My_Target_Url),
          (+"application/x-rootwin-drop", 0, My_Target_Rootwin)
         );

   Target_Table_Url : constant Target_Entry_Array
     := ( 1 => (+"text/uri-list", 0, My_Target_Url) );

   ----------
   -- Help --
   ----------
   function Help return String is
   begin
      return "This demo demonstrates the drag-and-drop features of GtkAda."
        & " Several @bdrag-and-drop@B (dnd) protocols are supported, so that"
        & " your application can easily communicate with other external codes,"
        & " but this is mostly transparent for you."
        & ASCII.LF
        & "Although providing dnd capabilities in your application is not"
        & " difficult, it requires you to take care of several things, which"
        & " might be a little bit tricky the first time. You should look at"
        & " this demo while reading its source code, extensively documented"
        & " in testgtk/create_dnd.adb in the GtkAda distribution."
        & ASCII.LF
        & "Several things worth noting in this demo:"
        & ASCII.LF
        & ASCII.LF
        & " - Several @bdrag sources@B are available. The first only knows"
        & " how to transmitted plain text data. The second one only knows"
        & " about URLs, whereas the third one can provide any of the above."
        & ASCII.LF
        & ASCII.LF
        & " - Several @bdrop sites@B are also provided. Like the drag sources,"
        & " they all have special attributes and accept only special types"
        & " of data. Thus, some dnd operations will simply be rejected if"
        & " there is no common type between the drag source and the drop site."
        & ASCII.LF
        & ASCII.LF
        & " - In addition, all of the above have special types of @bactions@B"
        & " that they can handle. These are either @bAction_Copy@B,"
        & " @bAction_Move@B, or a combination of the two. These actions"
        & " control the default behavior of the drag and drop operation. The"
        & " action selected will be the first one common to both the drag"
        & " source and the drop site, unless you press @bshift@B at the same"
        & " time to force a move. Notice than when Action_Move is selected,"
        & " GtkAda asks the drag source to delete the data, thus the Delete"
        & " message that you see on the output."
        & ASCII.LF
        & ASCII.LF
        & " - The @btrashcan@B has a special behavior, since no default"
        & " behavior is associated to it, and everything is managed directly"
        & " by the demo, by connecting to the appropriate signals. We also"
        & " chose to change its visual aspect when the mouse is over the"
        & " widget and a drag-and-drop operation is taking place."
        & ASCII.LF
        & ASCII.LF
        & " - The @bicons@B can be freely modified. Note that the pixmap used"
        & " when dragging from the first button is different than the one used"
        & " for the other buttons. This can provide some interesting visual"
        & " clues for the user.";
   end Help;

   -------------
   -- Put_Log --
   ------------
   procedure Put_Log (Str : String) is
   begin
      Log.Set_Text(Str => Str);
   end Put_Log;


   ----------------------
   -- Target_Drag_Drop --
   ----------------------
   function Target_Drag_Drop
     ( Widget : access Gtk_Widget_Record'Class;
       Args : Glib.Values.GValues) return Boolean
   is
      Context : Drag_Context := Drag_Context( Get_Object(Nth(Args, 1)) );
      X       : constant Gint:= Get_Int (Nth (Args, 2));
      Y       : constant Gint:= Get_Int (Nth (Args, 3));
      Time    : constant Guint:= Get_Uint(Nth (Args, 4));

      pragma Unreferenced (Context, X, Y, Time);

   begin
      Have_Drag := False;
      Put_Log("Drop");
      Gtk_Image (Widget ).set (Trashcan_Closed);
      return False;

   end Target_Drag_Drop;

   -------------------------------
   -- Target_Drag_Data_Received --
   -------------------------------
   procedure Target_Drag_Data_Received
     (Widget : access Gtk_Widget_Record'Class;
      Args   : Glib.Values.GValues)
   is
      Context : constant Drag_Context :=
        Drag_Context ( Get_Object (Nth(Args, 1) ) );
      X       : constant Gint  := Get_Int (Nth (Args, 2) );
      Y       : constant Gint  := Get_Int (Nth (Args, 3));
      Data    : constant Gtk_Selection_Data :=
        From_Object (Get_Address ( Nth(Args, 4) ) );

      Info    : constant Guint  := Get_Uint ( Nth (Args, 5) );
      Time    : constant Guint  := Get_Uint ( Nth (Args, 6) );

      pragma Unreferenced (Widget, X, Y, Info);

   begin

      if Get_Length (Data) >= 0
        and then Get_Format (Data) = 8
      then
         Put_Log("Received " & Get_Data_As_String(Data) & " in trashcan");
         Finish(Context, Success => True, Del => False, Time => Guint32 (Time));
      else
         Finish (Context, Success => False, Del => False, Time => Guint32 (Time));
      end if;

   end Target_Drag_Data_Received;

   ------------------------
   -- Target_Drag_Motion --
   ------------------------
   function Target_Drag_Motion
     (Widget : access Gtk_Widget_Record'Class;
      Args   : Glib.Values.GValues )  return Boolean
   is

      Context  : Drag_Context :=
        Drag_Context ( Get_Object ( Nth(Args, 1) ) );
      X        : constant Gint := Get_Int (Nth (Args, 2));
      Y        : constant Gint := Get_Int (Nth (Args, 3));
      Time     : constant Guint:= Get_Uint(Nth (Args, 4));

      pragma Unreferenced (X, Y);

   begin
      if not Have_Drag then

         Have_Drag := True;
         Gtk_Image (Widget).set (Trashcan_Open);

      end if;

      Drag_Status (Context, Get_Suggested_Action (Context), Guint32 (Time) );
      return True;

   end Target_Drag_Motion;


   -----------------------
   -- Target_Drag_Leave --
   -----------------------
   procedure Target_Drag_Leave
     (Widget : access Gtk_Widget_Record'Class;
      Args   : Glib.Values.GValues)
   is
      Context : Drag_Context := Drag_Context (Get_Object ( Nth (Args, 1) ) );
      Time    : constant Guint := Get_Uint ( Nth (Args, 2) );
      pragma Unreferenced (Context, Time);

   begin
      Put_Log(" Leave ");
      Have_Drag := False;
      Gtk_Image(Widget).Set (Trashcan_Closed);

   end Target_Drag_Leave;


   ------------------------------
   -- Label_Drag_Data_Received --
   ------------------------------
   procedure Label_Drag_Data_Received
     (Widget : access Gtk_Widget_Record'Class;
      Args   : Glib.Values.GValues)
   is

      Context : constant Drag_Context :=
        Drag_Context ( Get_Object ( Nth (Args, 1) ) );
      X       : constant Gint  := Get_Int ( Nth (Args, 2) );
      Y       : constant Gint  := Get_Int ( Nth (Args, 3) );
      Data    : constant Gtk_Selection_Data :=
        From_Object ( Get_Address ( Nth (Args, 4) ) );
      Info    : constant Guint := Get_Uint ( Nth (Args, 5) ) ;
      Time    : constant Guint := Get_Uint ( Nth (Args, 6) );
      pragma Unreferenced (Widget, X, Y, Info);

   begin

      if Get_Length (Data) >= 0 and then Get_Format (Data) = 8
      then
         Put_Log("Received "
                 & Get_Data_As_String(Data)
                 & " in label" );
         Gtk.Dnd.Finish
           (Context, Success => True, Del => False, Time => Guint32(Time));
      else
         Gtk.Dnd.Finish
           (Context, Success => False, Del => False, Time => Guint32(Time) );

      end if;

   end Label_Drag_Data_Received;


   --------------------------
   -- Source_Drag_Data_Get --
   --------------------------
   procedure Source_Drag_Data_Get
     (Widget : access Gtk_Widget_Record'Class;
      Args   : Glib.Values.GValues)
   is
      Context : constant Drag_Context :=
        Drag_Context ( Get_Object ( Nth (Args, 1) ) );
      Data    : constant Gtk_Selection_Data :=
        From_Object (Get_Address ( Nth (Args, 2) ) );
      Info    : constant Guint := Get_Uint ( Nth (Args, 3) ) ;
      Time    : constant Guint := Get_Uint ( Nth (Args, 4) );
      pragma Unreferenced (Widget, Context, Time);

   begin

      if Info = My_Target_Rootwin then
         Put_Log ("I was dropped on the root window ");
      elsif Info = My_Target_Url then
         Selection_Data_Set (Data, Get_Target (Data), 8,
                             "file://www.act-europe.fr");
      else
         Selection_Data_Set (Data, Get_Target (Data), 8,
                             "I'm Data, Info was " & Guint'Image(Info)
                            );
      end if;

   end Source_Drag_Data_Get;


   -----------------------------
   -- Source_Drag_Data_Delete --
   -----------------------------
   procedure Source_Drag_Data_Delete
     (Widget : access Gtk_Widget_Record'Class;
      Args   : Glib.Values.GValues)

   is
      Context  : constant Drag_Context :=
        Drag_Context (Get_Object ( Nth (Args, 1) )) ;
      pragma Unreferenced (Context, Widget);

   begin
      Put_Log ("Delete the data");

   end Source_Drag_Data_Delete;


   -----------------
   -- Drag_Failed --
   -----------------
   function Drag_Failed
     (Widget : access Gtk_Widget_Record'Class;
      Args   : Glib.Values.GValues) return Boolean
   is

   begin
      Put_Log ("Drag failed ");
      return True;

   end Drag_Failed;

   ---------
   -- Run --
   ---------
   procedure Run (Frame : access Gtk.Frame.Gtk_Frame_Record'Class) is
      Table : Gtk_Grid;
      Label : Gtk_Label;
      Button: Gtk_Button;
      Pixmap: Gtk_Image;
      Box   : Gtk_Box;
   begin

      Set_Label (Frame, "Drag and Drop");
      Gtk_New_Vbox (Box, Homogeneous => False );
      Add (Frame, Box);

      Gtk_New (Table);
      Box.Pack_Start (Table);

      Drag_Icon := Gdk_New_From_Xpm_Data (Drag_Icon_Xpm);
      Trashcan_Open := Gdk_New_From_Xpm_Data (Trashcan_Open_Xpm);
      Trashcan_Closed := Gdk_New_From_Xpm_Data (Trashcan_Closed_Xpm);


      ----------------
      -- Drop sites --
      ----------------
      Gtk_New ( Label, "Drop plain text here." & ASCII.LF
                & "Action_Move only" & ASCII.LF);
      Gtk.Dnd.Dest_Set (Label,
                        Dest_Default_All,
                        Target_Table_String,   -- Only STRING OR plain/text
                        Action_Move);
      Table.Attach (Label, 0, 0);
      Callback_UI.Widget_Callback.Connect (Label, "drag_data_received",
                                           Label_Drag_Data_Received'Access);

      -- Second drop site  : a simple label
      Gtk_New (Label, "Drop Url here" & ASCII.LF
               & "Action_Copy or Action_Move" & ASCII.LF);
      Gtk.Dnd.Dest_Set (Label,
                        Dest_Default_All,
                        Target_Table_Url,   -- Onlyy URL
                        Action_Copy + Action_Move);
      Table.Attach (Label, 1, 0);
      Callback_UI.Widget_Callback.Connect (Label, "drag_data_received",
                                           Label_Drag_Data_Received'Access);

      -- Third drop site : a simple label
      Gtk_New ( Label, "Drop Anything" & ASCII.LF
                & "only here" & ASCII.LF);
      Gtk.Dnd.Dest_Set (Label,
                        Dest_Default_All,
                        Target_Table,     -- only urls
                        Action_Copy + Action_Move);
      Table.Attach ( label, 2, 0);
      Callback_UI.Widget_Callback.Connect (Label, "drag_data_received",
                                           Label_Drag_Data_Received'Access);

      -----------------
      --  Drag sites --
      -----------------

      --  First Drag site

      Gtk_New (Button, "Drag String from Here" & ASCII.LF);
      Gtk.Dnd.Source_Set (Button,
                          Button1_Mask or Button3_Mask,
                          Target_Table_String,
                          Action_Copy + Action_Move);
      Table.Attach (Button, 0, 1);

      Callback_UI.Widget_Callback.Connect (Button, "drag_data_get",
                               Source_Drag_Data_Get'Access);
      Callback_UI.Widget_Callback.Connect (Button, "drag_data_delete",
                               Source_Drag_Data_Delete'Access);
      Callback_UI.Return_Callback.Connect (Button, "drag-failed",
                               Drag_Failed'Access);

      Gtk.Dnd.Source_Set_Icon_Pixbuf (Button, Drag_Icon);

      --  Second Drag site

      Gtk_New (Button, "Drag Url from Here" & ASCII.LF);
      Gtk.Dnd.Source_Set (Button,
                          Button1_Mask or Button3_Mask,
                          Target_Table_Url,
                          Action_Copy + Action_Move);
      Table.Attach (Button, 1, 1);

      Callback_UI.Widget_Callback.Connect (Button, "drag_data_get",
                               Source_Drag_Data_Get'Access);
      Callback_UI.Widget_Callback.Connect (Button, "drag_data_delete",
                               Source_Drag_Data_Delete'Access);

      --  Third Drag site

      Gtk_New (Button, "Drag String or" & ASCII.LF
               & "Url from Here" & ASCII.LF);
      Gtk.Dnd.Source_Set (Button,
                          Button1_Mask or Button3_Mask,
                          Target_Table,
                          Action_Copy + Action_Move + Action_Ask);
      Table.Attach (Button, 2, 1);

      Callback_UI.Widget_Callback.Connect (Button, "drag_data_get",
                               Source_Drag_Data_Get'Access);
      Callback_UI.Widget_Callback.Connect (Button, "drag_data_delete",
                               Source_Drag_Data_Delete'Access);

      --  Special drop site

      Gtk_New (Pixmap, Trashcan_Closed);
      Gtk.Dnd.Dest_Set (Pixmap);
      Table.Attach (Pixmap, 0, 2);

      Callback_UI.Return_Callback.Connect (Pixmap, "drag_drop",
                               Target_Drag_Drop'Access);
      Callback_UI.Widget_Callback.Connect (Pixmap, "drag_data_received",
                               Target_Drag_Data_Received'Access);
      Callback_UI.Return_Callback.Connect (Pixmap, "drag_motion",
                               Target_Drag_Motion'Access);
      Callback_UI.Widget_Callback.Connect (Pixmap, "drag_leave",
                               Target_Drag_Leave'Access);

      --  The log window
      Gtk_New (Log);
      Pack_Start (Box, Log);

      Show_All (Frame);

   end Run;


   -- Gtk_New --
	-------------
	procedure Gtk_New ( Window : out Window_Access ) is
	begin
		Window := new Window_Record;
		Window_Pkg.Initialize (Window);
		Window_Ptr := Window;
	end Gtk_New;



   ----------------
	-- Initialize --
	----------------
	procedure Initialize ( Window : access Window_Record'Class) is
		pragma Suppress (All_Checks);

	begin

      Gtk.Window.Initialize (Window);
      Window.Set_Title ("Drag And Drop with GtkAda");

      Gtk_New (Window.Frame);
      Window.Add (Window.Frame);

      Run( Window.Frame);

      Return_Callback.Connect (Widget => Window,
                               Name   => "delete_event",
                               Cb  => On_Window_Delete_Event'Access,
                               After  => False);

	end Initialize;


   ----------------
	-- Get_Window --
	----------------
	function Get_Window  return Window_Access is
	begin
		return Window_Ptr;
	end Get_Window;


end Window_Pkg;

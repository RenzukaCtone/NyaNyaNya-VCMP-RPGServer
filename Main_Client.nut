//Thank bdc ([Mk]Rest)
local scrSize = GUI.GetScreenSize(); //Get Screen Size
local Information, Register_CN, Login_CN, Help, Registered_Tip, Game_Guide, Language_Select, Register_Background, Language_Select_Background, AD, Update, huaji, TIP, BLACK; //Reset
local Passbox, Passboxa; //Edit box
local ButtonOK; //Button
local ReglogPlayerName, Name; //Lable
local EditState, PlayerID, PlayerName, VehSpeed, Time, FPS, Info, State, Timer, VehStart, HealthBar, WelcomeCN, VehDamage, WTFDamage, WTFSpeed, NotDalao, VehName, VehNameAlpha=255;
local hhhhh, Attacking, Drinking, Eating, exciting, excitingwater, Foundsth, godie, manQAQ, miaowHH, miaowmorning, nmdwhy, nomoney, QQAQ, Rubbish, wannasleep, howmuchwoc, yjsp, aaaaaa;
local Language = "EN";
local IsDamaging = false;
local VehAngle = 0;

function Script::ScriptLoad()
{
	LoadBasicGUI();
	LoadAlwaysGUI();
}
//仅在需要时显示 在RemoveFlags和AddFlags后不会受到影响
function LoadBasicGUI()
{
	scrSize = GUI.GetScreenSize();
	//Define
	Language_Select = GUISprite("Language_Select.png", VectorScreen( scrSize.X/2-281, scrSize.Y/2-100 ));
	Registered_Tip = GUISprite("Registered_Tip.png", VectorScreen( scrSize.X/2-156, scrSize.Y-110 ));
	Game_Guide = GUISprite("Game_Guide.png", VectorScreen( scrSize.X/2-281, scrSize.Y-110 ));
	Help = GUISprite("Help.png", VectorScreen( scrSize.X/2-320, scrSize.Y/2-240 ), Colour( 255, 255, 255, 222 ));
	Register_Background = GUISprite("AD.png", VectorScreen( 0, 0 ), Colour( 255, 255, 255, 233 ));
	Language_Select_Background = GUISprite("AD.png", VectorScreen( 0, 0 ), Colour( 255, 255, 255, 233 ));
	AD = GUISprite("AD.png", VectorScreen( scrSize.X/2-250, scrSize.Y/2-400 ), Colour( 255, 255, 255, 200 ));
	Update = GUISprite("Update.png", VectorScreen( scrSize.X/2-289, scrSize.Y/2-300 ), Colour( 255, 255, 255, 240 ));
	huaji = GUISprite("huaji1.png", VectorScreen( scrSize.X/2-200, scrSize.Y/2-300 ), Colour( 255, 255, 255, 250 ));
	BLACK = GUISprite("Black.png", VectorScreen( 0, 0 ), Colour( 255, 255, 255, 250 )); BLACK.Size = VectorScreen(scrSize.X, scrSize.Y);
	TIP = GUISprite("TIP.png", VectorScreen( scrSize.X/2-320, scrSize.Y/2-201.5 ), Colour( 255, 255, 255, 150 ));
	VehDamage = GUISprite("VehDamage.png", VectorScreen(0, 0), Colour(255, 255, 255, 0));
	NotDalao = GUISprite("NotDalao.png", VectorScreen(scrSize.X-299, scrSize.Y-263), Colour(255, 255, 255, 150));
	WTFDamage = GUISprite("WTFDamage.png", VectorScreen(0, 0), Colour(255, 255, 255, 0));
	WTFSpeed = GUISprite("WTFSpeed.png", VectorScreen(0, 0), Colour(255, 255, 255, 0));
	yjsp = GUISprite("yjsp.png", VectorScreen(0, scrSize.Y-192), Colour(255, 255, 255, 233));
	aaaaaa = GUISprite("aaaaaa.png", VectorScreen(scrSize.X-244, scrSize.Y-154), Colour(255, 255, 255, 233));
	VehDamage.Size = VectorScreen(scrSize.X, scrSize.Y);
	WTFDamage.Size = VectorScreen(scrSize.X, scrSize.Y);
	WTFSpeed.Size = VectorScreen(scrSize.X, scrSize.Y);

	VehSpeed = GUILabel(VectorScreen(scrSize.X/2-470, scrSize.Y-200), Colour(255, 255, 255, 120), "0 km/h"), VehSpeed.FontSize = 100;
	VehStart = GUILabel(VectorScreen(scrSize.X-370, scrSize.Y-85), Colour(70, 70, 70), "Alt to Start"), VehStart.FontSize = 45;
	VehName = GUILabel(VectorScreen(scrSize.X/2-70, scrSize.Y-80), Colour(255, 255, 255, 200), "");
	VehName.FontSize = 60;
	VehName.AddFlags(GUI_FLAG_TEXT_SHADOW);
	VehName.TextAlignment = GUI_ALIGN_CENTER;

	//表情包
	hhhhh = GUISprite("hhhhh.png", VectorScreen(scrSize.X-198, scrSize.Y-198), Colour(255, 255, 255, 130));
	Attacking = GUISprite("Attacking.png", VectorScreen(scrSize.X-320, scrSize.Y-173), Colour(255, 255, 255, 130));
	Drinking = GUISprite("Drinking.png", VectorScreen(scrSize.X-308, scrSize.Y-240), Colour(255, 255, 255, 130));
	Eating = GUISprite("Eating.png", VectorScreen(scrSize.X-240, scrSize.Y-240), Colour(255, 255, 255, 130));
	exciting = GUISprite("exciting.png", VectorScreen(scrSize.X-93, scrSize.Y-73), Colour(255, 255, 255, 130));
	excitingwater = GUISprite("excitingwater.png", VectorScreen(scrSize.X-198, scrSize.Y-166), Colour(255, 255, 255, 130));
	Foundsth = GUISprite("Foundsth.png", VectorScreen(scrSize.X-186, scrSize.Y-68), Colour(255, 255, 255, 130));
	godie = GUISprite("godie.png", VectorScreen(scrSize.X-70, scrSize.Y-54), Colour(255, 255, 255, 130));
	manQAQ = GUISprite("manQAQ.png", VectorScreen(scrSize.X-159, scrSize.Y-197), Colour(255, 255, 255, 130));
	miaowHH = GUISprite("miaowHH.png", VectorScreen(scrSize.X-217, scrSize.Y-240), Colour(255, 255, 255, 130));
	miaowmorning = GUISprite("miaowmorning.png", VectorScreen(scrSize.X-220, scrSize.Y-220), Colour(255, 255, 255, 130));
	nmdwhy = GUISprite("nmdwhy.png", VectorScreen(scrSize.X-266, scrSize.Y-240), Colour(255, 255, 255, 130));
	nomoney = GUISprite("nomoney.png", VectorScreen(scrSize.X-198, scrSize.Y-198), Colour(255, 255, 255, 130));
	QQAQ = GUISprite("QQAQ.png", VectorScreen(scrSize.X-213, scrSize.Y-178), Colour(255, 255, 255, 130));
	Rubbish = GUISprite("Rubbish.png", VectorScreen(scrSize.X-280, scrSize.Y-240), Colour(255, 255, 255, 130));
	wannasleep = GUISprite("wannasleep.png", VectorScreen(scrSize.X-240, scrSize.Y-240), Colour(255, 255, 255, 130));
	howmuchwoc = GUISprite("howmuchwoc.png", VectorScreen(scrSize.X-240, scrSize.Y-240), Colour(255, 255, 255, 60));

	//Flags
	Language_Select.RemoveFlags( GUI_FLAG_VISIBLE );
	Registered_Tip.RemoveFlags(GUI_FLAG_VISIBLE);
	Game_Guide.RemoveFlags(GUI_FLAG_VISIBLE);
	Help.RemoveFlags(GUI_FLAG_VISIBLE);
	Register_Background.RemoveFlags(GUI_FLAG_VISIBLE);
	Language_Select_Background.RemoveFlags(GUI_FLAG_VISIBLE);
	AD.RemoveFlags(GUI_FLAG_VISIBLE);
	Update.RemoveFlags(GUI_FLAG_VISIBLE);
	huaji.RemoveFlags(GUI_FLAG_VISIBLE);
	BLACK.RemoveFlags(GUI_FLAG_VISIBLE)
	TIP.RemoveFlags(GUI_FLAG_VISIBLE)
	VehSpeed.RemoveFlags(GUI_FLAG_VISIBLE);
	VehStart.RemoveFlags(GUI_FLAG_VISIBLE);
	VehDamage.RemoveFlags(GUI_FLAG_VISIBLE);
	NotDalao.RemoveFlags(GUI_FLAG_VISIBLE);
	WTFDamage.RemoveFlags(GUI_FLAG_VISIBLE);
	WTFSpeed.RemoveFlags(GUI_FLAG_VISIBLE);
	yjsp.RemoveFlags(GUI_FLAG_VISIBLE);
	aaaaaa.RemoveFlags(GUI_FLAG_VISIBLE);
	
	//表情包
	hhhhh.RemoveFlags(GUI_FLAG_VISIBLE);
	Attacking.RemoveFlags(GUI_FLAG_VISIBLE);
	Drinking.RemoveFlags(GUI_FLAG_VISIBLE);
	Eating.RemoveFlags(GUI_FLAG_VISIBLE);
	exciting.RemoveFlags(GUI_FLAG_VISIBLE);
	excitingwater.RemoveFlags(GUI_FLAG_VISIBLE);
	Foundsth.RemoveFlags(GUI_FLAG_VISIBLE);
	godie.RemoveFlags(GUI_FLAG_VISIBLE);
	manQAQ.RemoveFlags(GUI_FLAG_VISIBLE);
	miaowHH.RemoveFlags(GUI_FLAG_VISIBLE);
	miaowmorning.RemoveFlags(GUI_FLAG_VISIBLE);
	nmdwhy.RemoveFlags(GUI_FLAG_VISIBLE);
	nomoney.RemoveFlags(GUI_FLAG_VISIBLE);
	QQAQ.RemoveFlags(GUI_FLAG_VISIBLE);
	Rubbish.RemoveFlags(GUI_FLAG_VISIBLE);
	wannasleep.RemoveFlags(GUI_FLAG_VISIBLE);
	howmuchwoc.RemoveFlags(GUI_FLAG_VISIBLE);

	VehSpeed.AddFlags(GUI_FLAG_SHADOW | GUI_FLAG_TEXT_SHADOW);
	VehSpeed.FontName = "After Disaster";
	VehName.FontName = "Uranium";
	VehName.TextAlignment = GUI_ALIGN_CENTER;
	VehStart.AddFlags(GUI_FLAG_SHADOW | GUI_FLAG_TEXT_SHADOW);
	VehStart.FontFlags = GUI_FFLAG_BOLD;
}
//总是显示
function LoadAlwaysGUI()
{
	Hud.RemoveFlags(HUD_FLAG_CLOCK | HUD_FLAG_WANTED);
	Info = GUILabel(VectorScreen(0, scrSize.Y-48), Colour(100, 150, 250), ">w< | V2.0.123b | 04rel006"), Info.FontSize = 16;
	State = GUILabel(VectorScreen(0, scrSize.Y-23), Colour(250, 250, 111), "FPS: -- | Ping: -- ms"), State.FontSize = 16;
	Info.TextAlignment = GUI_ALIGN_LEFT;
	Info.FontFlags = GUI_FFLAG_BOLD;
	Info.AddFlags(GUI_FLAG_SHADOW | GUI_FLAG_TEXT_SHADOW);
	State.TextAlignment = GUI_ALIGN_LEFT;
	State.FontFlags = GUI_FFLAG_BOLD;
	State.AddFlags(GUI_FLAG_SHADOW | GUI_FLAG_TEXT_SHADOW);
}

//仅在需要时显示 在RemoveFlags和AddFlags后会受到影响
function LoadAccReg()
{
	GUI.SetMouseEnabled(true);
	Register_CN = GUISprite("Register_"+Language+".png", VectorScreen( scrSize.X/2-248, scrSize.Y/2-91 ), Colour(255, 255, 255, 200));
	Name = GUILabel(VectorScreen(scrSize.X/2+110-263, scrSize.Y/2+47-109), Colour(255, 255, 255));
	Passbox = GUIEditbox(VectorScreen( scrSize.X/2-153, scrSize.Y/2-4 ), VectorScreen(349, 26), Colour(120, 120, 120, 150), "", GUI_FLAG_EDITBOX_MASKINPUT);
	Passbox.FontSize = 26;
	Passbox.TextColour = Colour(255, 255, 255, 255);
	ButtonOK = GUISprite("ButtonOK.png", VectorScreen( scrSize.X/2-100, scrSize.Y/2+42 ), Colour(255, 255, 255, 255));
	GUI.SetFocusedElement(Passbox);
}

function LoadAccLog()
{
	GUI.SetMouseEnabled(true);
	Login_CN = GUISprite("Login_"+Language+".png", VectorScreen( scrSize.X/2-248, scrSize.Y/2-91 ), Colour(255, 255, 255, 255));
	Name = GUILabel(VectorScreen(scrSize.X/2+110-263, scrSize.Y/2+47-109), Colour(255, 255, 255));
	Passbox = GUIEditbox(VectorScreen( scrSize.X/2-153, scrSize.Y/2-4 ), VectorScreen(349, 26), Colour(120, 120, 120, 150), "", GUI_FLAG_EDITBOX_MASKINPUT);
	Passbox.FontSize = 26;
	Passbox.TextColour = Colour(255, 255, 255, 255);
	ButtonOK = GUISprite("ButtonOK.png", VectorScreen( scrSize.X/2-100, scrSize.Y/2+42 ), Colour(255, 255, 255, 255));
	GUI.SetFocusedElement(Passbox);
}

function DelAcc()
{
	GUI.SetMouseEnabled(false);
	Register_CN = null;
	Login_CN = null;
	Name.Text = "";
	Passbox = null;
	ButtonOK = null;
}

function Server::ServerData( stream )
{
	local MODE = stream.ReadString();
	local strA = stream.ReadString();
	local strB = stream.ReadString();
	local strC = stream.ReadString();
	local intA = stream.ReadInt();
	local intB = stream.ReadInt();
	local intC = stream.ReadInt();
	local numA = stream.ReadFloat();
	local numB = stream.ReadFloat();
	local numC = stream.ReadFloat();
	local IsInVeh;
	switch( MODE.tolower() )
	{
		case "sprite":
		{
			//Sprite State Control
			switch( strA.tolower() )
			{
				case "addlang": Language_Select.AddFlags(GUI_FLAG_VISIBLE); break;
				case "removelang": Language_Select.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "addreg": LoadAccReg(), Name.Text = strB, Name.FontSize = 24, EditState = "register"; break;
				case "removereg": DelAcc(); break;
				case "addlog": LoadAccLog(), Name.Text = strB, Name.FontSize = 24, EditState = "login"; break;
				case "removelog": DelAcc(); break;
				case "addplay": Game_Guide.AddFlags(GUI_FLAG_VISIBLE); break;
				case "removeplay": Game_Guide.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "addrempass": Registered_Tip.AddFlags(GUI_FLAG_VISIBLE); break;
				case "removerempass": Registered_Tip.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "addhelp": Help.AddFlags(GUI_FLAG_VISIBLE); break;
				case "removehelp": Help.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "addregbg": Register_Background.AddFlags(GUI_FLAG_VISIBLE); break;
				case "addlangsbg": Language_Select_Background.AddFlags(GUI_FLAG_VISIBLE); break;
				case "removeregbg": Register_Background.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "removelangsbg": Language_Select_Background.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "addad": AD.AddFlags(GUI_FLAG_VISIBLE); break;
				case "removead": AD.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "addwanted": Hud.AddFlags(HUD_FLAG_WANTED); break;
				case "removewanted": Hud.RemoveFlags(HUD_FLAG_WANTED); break;
				case "addupdate": Update.AddFlags(GUI_FLAG_VISIBLE); break;
				case "removeupdate": Update.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "addtip": BLACK.AddFlags(GUI_FLAG_VISIBLE), TIP.AddFlags(GUI_FLAG_VISIBLE); break;
				case "removetip": BLACK.RemoveFlags(GUI_FLAG_VISIBLE), TIP.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "allblack": BLACK.AddFlags(GUI_FLAG_VISIBLE); break;
				case "noblack": BLACK.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "addspeed":
				{
					local intD = stream.ReadInt();
					VehSpeed.AddFlags(GUI_FLAG_VISIBLE);
					VehSpeed.Text = intA+" km/h";
					VehSpeed.TextColour = Colour(intB,intC,intD,120);
					VehSpeed.Alpha = 90;
					VehSpeed.Position = VectorScreen(scrSize.X-470+(intA/3)+(VehAngle*1.6), scrSize.Y-200+(intA/5)-(VehAngle/6.2));
					VehName.AddFlags(GUI_FLAG_VISIBLE);
					VehName.Text = strB;
					VehName.TextColour = Colour(intD,intC,intB);
					VehName.Alpha = VehNameAlpha;
					VehName.Position.X = scrSize.X/2-70+(VehAngle/4);
					VehStart.RemoveFlags(GUI_FLAG_VISIBLE);
					break;
				}
				case "removespeed": VehSpeed.RemoveFlags(GUI_FLAG_VISIBLE), VehSpeed.Text = ""; VehName.Text = ""; WTFSpeed.Alpha = 0; break;
				case "updateinfo": State.AddFlags(GUI_FLAG_VISIBLE), State.Text = "FPS: "+intA+" | Ping: "+intB+"ms"; break;
				case "vehstart": VehStart.AddFlags(GUI_FLAG_VISIBLE), VehSpeed.Text = ""; break;
				case "removevehstart": VehStart.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "updatehuaji": huaji.AddFlags(GUI_FLAG_VISIBLE), huaji.SetTexture("huaji"+intA+".png"); break;
				case "donehuaji": huaji.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "setlang": Language = strB; break;
				case "vehdamage": VehDamage.AddFlags(GUI_FLAG_VISIBLE); VehDamage.Alpha = 250-(intA/4); VehNameAlpha = intA/4; break;
				case "wtf???":
				{
					WTFDamage.AddFlags(GUI_FLAG_VISIBLE);
					WTFDamage.Alpha = intA;
					switch(intA)
					{
						case 0: IsDamaging = false;
						break;
						default: IsDamaging = true;
					}
					break;
				}
				case "wtf????":
				{
					switch(IsDamaging)
					{
						case true: break;
						case false:
						WTFSpeed.AddFlags(GUI_FLAG_VISIBLE);
						WTFSpeed.Alpha = intA;
						break;
					}

					break;
				}
				case "qaq!": VehName.Position.X+=intA;VehName.Position.Y+=intA;Info.Position.X+=intA;Info.Position.Y+=intA;State.Position.X+=intA;State.Position.Y+=intA; break;
				case "addnotdalao": NotDalao.AddFlags(GUI_FLAG_VISIBLE); break;
				case "removenotdalao": NotDalao.RemoveFlags(GUI_FLAG_VISIBLE); break;
				case "aaaaaa":
				{
					yjsp.AddFlags(GUI_FLAG_VISIBLE);
					aaaaaa.AddFlags(GUI_FLAG_VISIBLE);
					yjsp.Position.X += intA;
					yjsp.Position.Y += intA;
					aaaaaa.Position.X += intA;
					aaaaaa.Position.Y += intA;
					break;
				}
				case "aaaaaastop!":
				{
					yjsp.RemoveFlags(GUI_FLAG_VISIBLE);
					aaaaaa.RemoveFlags(GUI_FLAG_VISIBLE);
					break;
				}
				case "vehangle": VehAngle = intA; break;
				case "qaq":
				{
					switch(strB.tolower())
					{
						case "ahhhhh": hhhhh.AddFlags(GUI_FLAG_VISIBLE); break;
						case "aattacking": Attacking.AddFlags(GUI_FLAG_VISIBLE); break;
						case "adrinking": Drinking.AddFlags(GUI_FLAG_VISIBLE); break;
						case "aeating": Eating.AddFlags(GUI_FLAG_VISIBLE); break;
						case "aexciting": exciting.AddFlags(GUI_FLAG_VISIBLE); break;
						case "aexcitingwater": excitingwater.AddFlags(GUI_FLAG_VISIBLE); break;
						case "afoundsth": Foundsth.AddFlags(GUI_FLAG_VISIBLE); break;
						case "agodie": godie.AddFlags(GUI_FLAG_VISIBLE); break;
						case "amanqaq": manQAQ.AddFlags(GUI_FLAG_VISIBLE); break;
						case "amiaowhh": miaowHH.AddFlags(GUI_FLAG_VISIBLE); break;
						case "amiaowmorning": miaowmorning.AddFlags(GUI_FLAG_VISIBLE); break;
						case "anmdwhy": nmdwhy.AddFlags(GUI_FLAG_VISIBLE); break;
						case "anomoney": nomoney.AddFlags(GUI_FLAG_VISIBLE); break;
						case "aqqaq": QQAQ.AddFlags(GUI_FLAG_VISIBLE); break;
						case "arubbish": Rubbish.AddFlags(GUI_FLAG_VISIBLE); break;
						case "awannasleep": wannasleep.AddFlags(GUI_FLAG_VISIBLE); break;
						case "ahowmuchwoc": howmuchwoc.AddFlags(GUI_FLAG_VISIBLE); break;
						case "rhhhhh": hhhhh.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rattacking": Attacking.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rdrinking": Drinking.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "reating": Eating.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rexciting": exciting.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rexcitingwater": excitingwater.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rfoundsth": Foundsth.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rgodie": godie.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rmanqaq": manQAQ.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rmiaowhh": miaowHH.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rmiaowmorning": miaowmorning.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rnmdwhy": nmdwhy.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rnomoney": nomoney.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rqqaq": QQAQ.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rrubbish": Rubbish.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rwannasleep": wannasleep.RemoveFlags(GUI_FLAG_VISIBLE); break;
						case "rhowmuchwoc": howmuchwoc.RemoveFlags(GUI_FLAG_VISIBLE); break;
					}
					break;
				}
				case "removeall":
					Language_Select.RemoveFlags( GUI_FLAG_VISIBLE );
					Registered_Tip.RemoveFlags(GUI_FLAG_VISIBLE);
					Game_Guide.RemoveFlags(GUI_FLAG_VISIBLE);
					Help.RemoveFlags(GUI_FLAG_VISIBLE);
					Register_Background.RemoveFlags(GUI_FLAG_VISIBLE);
					Language_Select_Background.RemoveFlags(GUI_FLAG_VISIBLE);
					Update.RemoveFlags(GUI_FLAG_VISIBLE);
					huaji.RemoveFlags(GUI_FLAG_VISIBLE);
					BLACK.RemoveFlags(GUI_FLAG_VISIBLE)
					TIP.RemoveFlags(GUI_FLAG_VISIBLE)
					VehSpeed.RemoveFlags(GUI_FLAG_VISIBLE);
					VehStart.RemoveFlags(GUI_FLAG_VISIBLE);
				break;
				default: Console.Print( "Unknown option" );
			}
		}
	}
}

function GUI::ElementRelease(element, mouseX, mouseY)
{
	if (element == ButtonOK)
	{
		GUI.InputReturn(Passbox);
	}
}

function GUI::InputReturn(editbox)
{
	switch (editbox)
	{
		case Passbox:
		if (EditState == "register")
		{
			if (Passbox.Text.len() > 0 && Passbox.Text.len() < 30) Sign("register", Passbox.Text);
		}
		else if (EditState == "login")
		{
			if (Passbox.Text.len() > 0 && Passbox.Text.len() < 30) Sign("login", Passbox.Text);
		}
		break;
		default: Console.Print( "Unknown option" );
	}
}

function GUI::ElementHoverOver(element)
{
	switch (element)
	{
		case ButtonOK:
		ButtonOK.Position = VectorScreen(scrSize.X/2+161, scrSize.Y/2+43);
		ButtonOK.Colour = Colour(30, 30, 30, 222);
		break;
	}
}

function GUI::ElementHoverOut(element)
{
	switch (element)
	{
		case ButtonOK:
		ButtonOK.Position = VectorScreen(scrSize.X/2+160, scrSize.Y/2+42);
		ButtonOK.Colour = Colour(255, 255, 255, 255);
		break;
	}
}

function Sign(mode, pass)
{
	local message = Stream();
	message.WriteString(mode);
	message.WriteString(pass)
	Server.SendData(message);
}

function GUI::GameResize(width, height)
{
	LoadBasicGUI();
	LoadAlwaysGUI();
}

function errorHandling(err)
{
	/* credits: ysc3839 */
 local stackInfos = getstackinfos(2);

 if (stackInfos)
 {
  local locals = "";

  foreach( index, value in stackInfos.locals )
  {
   if( index != "this" )
    locals = locals + "[" + index + "] " + value + "\n";
  }

  local callStacks = "";
  local level = 2;
  do {
   callStacks += "*FUNCTION [" + stackInfos.func + "()] " + stackInfos.src + " line [" + stackInfos.line + "]\n";
   level++;
  } while ((stackInfos = getstackinfos(level)));

  local errorMsg = "AN ERROR HAS OCCURRED [" + err + "]\n";
  errorMsg += "\nCALLSTACK\n";
  errorMsg += callStacks;
  errorMsg += "\nLOCALS\n";
  errorMsg += locals;

  Console.Print(errorMsg);
 }
}
seterrorhandler(errorHandling);
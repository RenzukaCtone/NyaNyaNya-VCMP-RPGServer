function STextAll( text, style )
{
	AnnounceAll( text, style );
}

function SText( text, player, style )
{
	local player = FindPlayer(player);
	if (player) Announce( text, player, style );
}

function ProgressBar( text, player, style )
{
	local player = FindPlayer(player);
	if (player && Status[player.ID].StopProgress == false) Announce( text, player, style );
}

function Progress( player, time )
{
	local player = FindPlayer(player)
	local playerID = player.ID;
	local ftime = (time/20);
	Status[player.ID].StopProgress = false;
	NewTimer( "ProgressBar", 1, 1, "~o~Please Wait...", playerID, 7 );
	NewTimer( "ProgressBar", 1, 1, "~h~--------------------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*1, 1, "~b~-~h~-------------------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*2, 1, "~b~--~h~------------------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*3, 1, "~b~---~h~-----------------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*4, 1, "~b~----~h~----------------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*5, 1, "~b~-----~h~---------------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*6, 1, "~b~------~h~--------------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*7, 1, "~b~-------~h~-------------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*8, 1, "~b~--------~h~------------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*9, 1, "~b~---------~h~-----------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*10, 1, "~b~----------~h~----------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*11, 1, "~b~-----------~h~---------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*12, 1, "~b~------------~h~--------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*13, 1, "~b~-------------~h~-------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*14, 1, "~b~--------------~h~------", playerID, 1 );
	NewTimer( "ProgressBar", ftime*15, 1, "~b~---------------~h~-----", playerID, 1 );
	NewTimer( "ProgressBar", ftime*16, 1, "~b~----------------~h~----", playerID, 1 );
	NewTimer( "ProgressBar", ftime*17, 1, "~b~-----------------~h~---", playerID, 1 );
	NewTimer( "ProgressBar", ftime*18, 1, "~b~------------------~h~--", playerID, 1 );
	NewTimer( "ProgressBar", ftime*19, 1, "~b~-------------------~h~-", playerID, 1 );
	NewTimer( "ProgressBar", ftime*20, 1, "~t~--------------------", playerID, 1 );
}

function HotelRestoreCamera( player )
{
	local player = FindPlayer(player)
	if(player)
	{
		player.RestoreCamera();
		player.Pos = Vector( 229.772, -1265.11, 19.4887 );
		player.Widescreen = false;
		player.IsFrozen = false;
	}
}

function RestoreCamera( player )
{
	local player = FindPlayer(player)
	if (player)
	{
		player.RestoreCamera();
		player.Widescreen = false;
		player.IsFrozen = false;
	}
}

function SetCamera( player, camposx, camposy, camposz, lookposx, lookposy, lookposz )
{
	local player = FindPlayer(player)
	if (player && camposx && camposy && camposz && lookposx && lookposy && lookposz)
	{
		player.SetCameraPos(Vector(camposx, camposy, camposz), Vector(lookposx, lookposy, lookposz));
	}
}

function SendPacketToClient( player, mode, opcode )
{
	if(player)
	{
		local data = Stream();
		data.WriteString( mode );
		data.WriteString( opcode );
		data.SendStream( player );
	}
}

function SendIDPacketToClient( player, mode, opcode )
{
	local player = FindPlayer(player)
	if (player)
	{
		local data = Stream();
		data.WriteString( mode );
		data.WriteString( opcode );
		data.SendStream( player );
	}
}

function VehicleState( driver )
{
	local player = FindPlayer(driver)
	if ( player.Vehicle && player.Vehicle.Health && player.IsFrozen == false )
	{
		player.SetDrunkLevel( 1, 1);
		NewTimer("Undrunk", 88, 1, player.ID);
		local speed = (player.Vehicle.Speed.Length() * 180).tointeger();
		local speed = ""; //暂时禁用速度显示功能
		if ( player.Vehicle.Health > 900 && player.Vehicle.Health < 1001 ) SText("    " + speed + "Vehicle HP~t~---------- ", player.ID, 1);
		else if ( player.Vehicle.Health > 800 && player.Vehicle.Health < 900 ) SText("    " + speed + "Vehicle HP~t~---------~h~- ", player.ID, 1);
		else if ( player.Vehicle.Health > 700 && player.Vehicle.Health < 800 ) SText("    " + speed + "Vehicle HP~t~--------~h~-- ", player.ID, 1);
		else if ( player.Vehicle.Health > 600 && player.Vehicle.Health < 700 ) SText("    " + speed + "Vehicle HP~b~-------~h~--- ", player.ID, 1);
		else if ( player.Vehicle.Health > 500 && player.Vehicle.Health < 600 ) SText("    " + speed + "Vehicle HP~b~------~h~---- ", player.ID, 1);
		else if ( player.Vehicle.Health > 400 && player.Vehicle.Health < 500 ) SText("    " + speed + "Vehicle HP~y~-----~h~----- ", player.ID, 1);
		else if ( player.Vehicle.Health > 300 && player.Vehicle.Health < 400 ) SText("    " + speed + "Vehicle HP~y~----~h~------ ", player.ID, 1);
		else if ( player.Vehicle.Health > 200 && player.Vehicle.Health < 300 ) SText("    " + speed + "Vehicle HP~o~---~h~------- ", player.ID, 1);
		else if ( player.Vehicle.Health > 100 && player.Vehicle.Health < 200 ) SText("    " + speed + "Vehicle HP~w~--~h~-------- ", player.ID, 1);
		else if ( player.Vehicle.Health > 0 && player.Vehicle.Health < 100 ) SText("    " + speed + "HP~w~-~h~--------- ", player.ID, 1);
		else if ( player.Vehicle.Health == 0 ) SText("    " + speed + "HP~a~---------- ", player.ID, 1);
	}
}

function VehicleSpeed(player)
{
	local player = FindPlayer(player)
	if(player && player.Vehicle)
	{
		local speed = (player.Vehicle.Speed.Length() * 180).tointeger(), r, g, b;
		r = 255-(speed*0.2), g = 255-(speed*1.2), b = 255-(speed*1.7);
		if(r<0) r=0;
		if(g<0) g=0;
		if(b<0) b=0;
		if(player.Alpha == 254 && player.Vehicle && player.IsFrozen == true)
		{
			local data = Stream();
			data.WriteString( "Sprite" );
			data.WriteString( "vehstart" );
			data.SendStream( player );
			NewTimer("VehicleSpeed", 33, 1, player.ID)
		}
		else
		{
			local data = Stream();
			data.WriteString( "Sprite" );
			data.WriteString( "addspeed" );
			data.WriteString( GetVehicleNameFromModel(player.Vehicle.Model) );
			data.WriteString( "" );
			data.WriteInt( speed );
			data.WriteInt( r );
			data.WriteInt( g );
			data.WriteFloat( 0.0 );
			data.WriteFloat( 0.0 );
			data.WriteFloat( 0.0 );
			data.WriteInt( b );
			data.SendStream( player );
			local qaqaq, qaq = random(1,5);
			if(qaq == 1) qaqaq = -1;
			else if (qaq == 2) qaqaq = 0;
			else if (qaq == 3) qaqaq = 1;
			else if (qaq == 4) qaqaq = -2;
			else if (qaq == 5) qaqaq = 2;
			local qaqaqaq, qaq = random(1,5);
			if(qaq == 1) qaqaqaq = -1;
			else if (qaq == 2) qaqaqaq = 0;
			else if (qaq == 3) qaqaqaq = 1;
			else if (qaq == 4) qaqaqaq = -2;
			else if (qaq == 5) qaqaqaq = 2;
			local data = Stream();
			data.WriteString("Sprite");
			data.WriteString("wtf????");
			data.WriteString("");
			data.WriteString("");
			data.WriteInt(random((speed/5).tointeger()-1, (speed/5).tointeger()+1));
			data.SendStream(player);

			local data = Stream();
			data.WriteString("Sprite");
			data.WriteString("vehangle");
			data.WriteString("");
			data.WriteString("");
			local angle = (((player.Vehicle.Angle.x+player.Vehicle.Angle.y+player.Vehicle.Angle.z)*100).tointeger());
			if(angle > 0) angle = (angle*(-1));
			data.WriteInt(angle);
			data.SendStream(player);
			if(speed > 135)
			{
				local fudu;
				Status[player.ID].SpeedEffectLoop++;
				if(Status[player.ID].SpeedEffectLoop == 1) fudu = 1;
				else if(Status[player.ID].SpeedEffectLoop == 2) fudu = 1;
				else if(Status[player.ID].SpeedEffectLoop == 3) fudu = -1;
				else if(Status[player.ID].SpeedEffectLoop == 4) fudu = 1;
				else if(Status[player.ID].SpeedEffectLoop == 5) fudu = -2;
				else if(Status[player.ID].SpeedEffectLoop == 6) fudu = -1;
				else if(Status[player.ID].SpeedEffectLoop == 7) fudu = -1;
				else Status[player.ID].SpeedEffectLoop = 0, fudu = 2;
				local data = Stream();
				data.WriteString("Sprite");
				data.WriteString("QAQ!");
				data.WriteString("");
				data.WriteString("");
				data.WriteInt(fudu);
				data.SendStream(player);
				if(Status[player.ID].wocOK == false)
				{
					Status[player.ID].wocOK = true;
					local data = Stream();
					data.WriteString("Sprite");
					data.WriteString("qaq");
					data.WriteString("ahowmuchwoc");
					data.SendStream(player);
				}
			}
			else
			{
				Status[player.ID].wocOK = false;
				local data = Stream();
				data.WriteString("Sprite");
				data.WriteString("qaq");
				data.WriteString("rhowmuchwoc");
				data.SendStream(player);
			}
			NewTimer("VehicleSpeed", 25, 1, player.ID)
		}
	}
	else
	{
		local data = Stream();
		data.WriteString( "Sprite" );
		data.WriteString( "removespeed" );
		data.WriteString( "" );
		data.WriteString( "" );
		data.SendStream( player );
	}
}

function ServerInfo(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		local data = Stream();
		data.WriteString( "Sprite" );
		data.WriteString( "updateinfo" );
		data.WriteString( "" );
		data.WriteString( "" );
		data.WriteInt( player.FPS );
		data.WriteInt( player.Ping );
		data.SendStream( player );
		NewTimer("ServerInfo", 2000, 1, player.ID)
	}
}

function Undrunk(player)
{
	local player = FindPlayer(player)
	if(player) player.SetDrunkLevel( 0, 0);
}

function random(start, finish)
{
	local r = ((rand() % (finish - start)) + start);
	return r;
}

function IsNewHere( player )
{
	local player = FindPlayer(player)
	if (player)
	{
		if( Status[player.ID].IsNew == true )
		{
			player.Pos = Vector( -1512.111328, -926.874634, 20.882317 );
			Announce("~o~Welcome to the ~y~RCG~o~ City ~t~=w=", player, 7);
			Announce("~t~Leave ~o~here and ~t~go out ~t~=w=", player, 7);
			PlaySoundForPlayer(player, 50067);
			Announce("Gou li guo jia sheng si yi, qi yin huo fu ~g~BI QU ZHI", player, 1);
			player.IsFrozen = false;
			NewTimer("SText", 3000, 1, "Loading OldData..", player.ID, 1)
			NewTimer("PlayMusicForPlayer", 8000, 1, player.ID, 50068);
			NewTimer("SText", 8000, 1, "Airport, zou ma", player.ID, 1)
			NewTimer("GetOldData", 3800, 1, player.ID)
			Status[player.ID].CanTeleport = false;
		}
		else if (Status[player.ID].CanTeleport == false)
		{
			PlaySound( player.World, random(524, 713), player.Pos );
			local spawnmoney = random(20,50)
			Announce("~g~You have been spawned -$" + spawnmoney, player, 1);
			if (player.Cash < spawnmoney) player.Cash = 0;
			else player.Cash -= spawnmoney;
			player.Health = 100;
			local num = random(0, 5);
			if ( num == 1 ) player.Pos = Vector(-882.919, -470.346, 13.1098);
			else if ( num == 2 ) player.Pos = Vector(492.2126, 701.4702, 12.1033);
			else if ( num == 3 ) player.Pos = Vector(-136.0121, -980.9905, 10.4639);
			else if ( num == 4 ) player.Pos = Vector(-822.7803, 1151.4686, 12.4111);
			else player.Pos = Vector(-882.919, -470.346, 13.1098);
		}
	}
}

function PosTeleport( player )
{
	local player = FindPlayer(player)
	if (player && Status[player.ID].IsNew == false)
	{
		if ( Status[player.ID].CanTeleport == true )
		{
			local x = GetSQLColumnData(QuerySQL(Account, "SELECT PosX FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0),
			y = GetSQLColumnData(QuerySQL(Account, "SELECT PosY FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0),
			z = GetSQLColumnData(QuerySQL(Account, "SELECT PosZ FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
			if ( x && y && z )
			{
				PlaySound( player.World , 357 , player.Pos );
				PlaySound( player.World , 357 , player.Pos );
				local pos = Vector( x, y, z );
				player.Pos = pos;
				Status[player.ID].CanTeleport = false;
				Status[player.ID].IsNew = false
				player.Skin = GetSQLColumnData(QuerySQL(Account, "SELECT Skin FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
				NewTimer("PlayMusicForPlayer", 1000, 1, player.ID, 50006);
			}
			else Status[player.ID].CanTeleport = false;
		}
	}
}

function CheckRegister( player )
{
	local player = FindPlayer(player)
	if ( player && GetLevel(player.ID) < 1 )
	{
		LangText("[#FF8000]    !Ni Hai'mei'you [#FF8000]Zhu Ce!","[#FF8000]    !You haven't [#FF8000]Registered yet!",player.ID,false),PlaySound( player.World , 335 , player.Pos );
		player.IsFrozen = true;
		player.Widescreen = true;
	}
}

function CheckLogin( player )
{
	local player = FindPlayer(player)
	if ( player && GetLevel(player.ID) >= 1 )
	{
		if( Status[player.ID].IsLogin == false )
		{/*
			if( GetSQLColumnData(QuerySQL( Account, "SELECT IP FROM Account WHERE Name='" + player.Name.tolower() + "'"), 0) != player.IP )
			{
				PlaySound( player.World , 357 , player.Pos );
				PlaySound( player.World , 357 , player.Pos );
				player.Widescreen = false;
				player.IsFrozen = false;
				Status[player.ID].IsLogin = true;
				LangText("[#FFFAFA]  *Ni Yi'jing [#FF8000]Zi'dong-Deng'lu[#FFFAFA] =w=", "[#FFFAFA]  *You have been [#FF8000]Auto-Logged[#FFFAFA] =w=", player.ID, false)
				SendPacketToClient( player, "Sprite", "addad");
				NewTimer("SendIDPacketToClient", 4321, 1, player.ID, "Sprite", "removead");
			}
			else
			{*/
				PlaySound( player.World , 335 , player.Pos );
				SendLanguage(player.ID);
				player.Widescreen = true;
				player.IsFrozen = true;
				local data = Stream();
				data.WriteString("Sprite");
				data.WriteString("addlog");
				data.WriteString(player.Name);
				data.SendStream(player);
				player.World = player.ID+100;
			//}
		}
	}
}

function Login( player, password )
{
	local player = FindPlayer(player)
	if(player)
	{
		if(!password) MessagePlayer( "[#FF8000]    !Please type your Password", player ),PlaySound( player.World , 335 , player.Pos );
		else
		{
			if (GetLevel(player.ID) < 1) LangText("[#FF8000]    !Ni Hai'mei'you [#FF8000]Zhu Ce!","[#FF8000]    !You haven't [#FF8000]Registered yet!",player.ID,false);
			else if ( Status[player.ID].IsLogin == true ) LangText( "[#FF8000]    !Bu'xu'yao Chong'xin Deng'lu[#FF8000] =w=","[#FF8000]    !Do not need to re-login[#FF8000] =w=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
			else
			{
				local rpassword = GetSQLColumnData(QuerySQL(Account, "SELECT Password FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
				if ( password == rpassword )
				{
					PlaySound(player.World, 50005, player.Pos);
					PlaySound(player.World, 50005, player.Pos);
					LangText( "[#00DB00]    >Deng'lu Cheng'gong =w=","[#00DB00]    >Logining was successful =w=", player.ID,false );
					player.World = player.ID-100;
					player.IsFrozen = false;
					player.Widescreen = false;
					QuerySQL( Account, "UPDATE Account SET IP='" + player.IP + "' WHERE Name='" + player.Name.tolower() + "'");
					SendPacketToClient( player, "Sprite", "removelog" );
					Status[player.ID].IsLogin = true;
					SendPacketToClient( player, "Sprite", "addad");
					NewTimer("SendIDPacketToClient", 4444, 1, player.ID, "Sprite", "removead");
					if(player.Name.tolower() == "[rcg]ctone") Status[player.ID].Admin = true;
					if(player.Name.tolower() == "ctone") Status[player.ID].Admin = true;
					if(player.Name.tolower() == "takumi") Status[player.ID].Admin = true;
					if(player.Name.tolower() == "[sas]fanice") Status[player.ID].Admin = true;
				}
				else
				{
					LangText( "[#FF8000]    !Mi'ma Cuo'wu! Qing Chong'xin Shu'ru Ni'de Mi'ma.","[#FF8000]    !Wrong Password! Please re-type your password.", player.ID,false ),PlaySound( player.World , 335 , player.Pos );
				}
			}
		}
	}
}

function Register( player, password )
{
	local player = FindPlayer(player)
	if(player)
	{
		if(!password) MessagePlayer( "[#FF8000]    !Please type your Password", player ),PlaySound( player.World , 335 , player.Pos );
		else if ( GetLevel(player.ID) >= 1 )
		{
			LangText( "[#FF8000]    !Bu'xu'yao Chong'xin Zhu'ce =w=, Ru'guo Ni Xu'yao Gai'mi'ma, Qing shu'ru [#00E3E3]/changepw <Mi'ma> [#FF8000]=w=","[#FF8000]    !Do not need to re-register =w= ,if you need to change the password, please type [#00E3E3] /changepw <password> [#FF8000]=w=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
		}
		else
		{
			PlaySound(player.World, 50005, player.Pos);
			PlaySound(player.World, 50005, player.Pos);
			QuerySQL( Account, "UPDATE Account SET Password='" + password + "', User='" + player.Name + "', Name='" + player.Name.tolower() + "' WHERE Name='" + player.Name.tolower() + "'");
			SendPacketToClient( player, "Sprite", "RemoveReg" );
			LangText( "[#00DB00]    >Zhu'ce Cheng'gong =w=","[#00DB00]    >Register was successful =w=", player.ID, false );
			Message( "[#FFFAFA]  *<" + GetRGBCode( player.ID ) + player.Name +" [#FFFAFA]is a Registered Nick-Name Now!>*");
			LangText( "[#00DB00]    >Ji zhu ni de mima: [[#00CCFF]" + password + "[#00DB00]] yi hou shu ru [#00CCFF]/newpass[#00DB00] ke yi gai mi ma =w=","[#00DB00]    >Please Remember your password: [[#00CCFF]" + password + "[#00DB00]] and type [#00CCFF]/newpass[#00DB00] to change your password =w=", player.ID,false );
			QuerySQL( Account, "UPDATE Account SET IP='" + player.IP + "' WHERE Name='" + player.Name.tolower() + "'");
			Status[player.ID].IsLogin = true;
			IncExp(player.ID, 10);
			player.IsFrozen = false;
			player.Spawn();
			if(player.Name.tolower() == "[rcg]ctone") Status[player.ID].Admin = true;
			if(player.Name.tolower() == "ctone") Status[player.ID].Admin = true;
			if(player.Name.tolower() == "takumi") Status[player.ID].Admin = true;
			if(player.Name.tolower() == "[sas]fanice") Status[player.ID].Admin = true;
		}
	}
}

function ChangePassword( player, password )
{
	local player = FindPlayer(player)
	if(player)
	{
		if(!password) MessagePlayer( "[#FF8000]    !Use /" + cmd + " <Password>!", player ),PlaySound( player.World , 335 , player.Pos );
		else if ( Status[player.ID].IsLogin != true ) LangText("[#FF8000]    !Ni Hai'mei'you [#FF8000]Deng Lu!","[#FF8000]    !You haven't [#FF8000]Logged yet!",player.ID,false),PlaySound( player.World , 335 , player.Pos );
		else if ( GetSQLColumnData(QuerySQL(Account, "SELECT Password FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) )
		{
			PlaySound(player.World, 50005, player.Pos);
			PlaySound(player.World, 50005, player.Pos);
			QuerySQL( Account, "UPDATE Account SET Password='" + password + "', User='" + player.Name + "', Name='" + player.Name.tolower() + "' WHERE Name='" + player.Name.tolower() + "'");
			LangText( "[#00DB00]    >Xiu'gai Cheng'gong =w=","[#00DB00]    >Changing the password was successful =w=", player.ID, false );
			LangText( "[#00DB00]    >Ji zhu ni de mima: [[#00CCFF]" + password + "[#00DB00]] yi hou shu ru [#00CCFF]/newpass[#00DB00] ke yi gai mi ma =w=","[#00DB00]    >Please Remember your password: [[#00CCFF]" + password + "[#00DB00]] and type [#00CCFF]/newpass[#00DB00] to change your password =w=", player.ID,false );
		}
		else LangText("[#FF8000]    !Ni Hai'mei'you [#FF8000]Zhu Ce!","[#FF8000]    !You haven't [#FF8000]Registered yet!",player.ID,false),PlaySound( player.World , 335 , player.Pos );
	}
}

function LangText( TextCN, TextEN, player, SendAll )
{
	if ( SendAll == true ) Message( TextEN );
	else if ( SendAll == false)
	{
		local player = FindPlayer(player)
		if ( player && GetSQLColumnData(QuerySQL(Account, "SELECT Language FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) == "Chinese" ) MessagePlayer( TextCN, player );
		else MessagePlayer( TextEN, player );
	}
}

function CheckPlayer( checker, player )
{
	local checker = FindPlayer(checker)
	local player = FindPlayer(player)
	PlaySound( player.World , 335 , player.Pos );
	Status[player.ID].CanCheck = false;
	LangText(null, "[#FFFAFA]  *<"+GetRGBCode( player.ID ) + player.Name+"[#FFFAFA] is checking " + GetRGBCode( checker.ID ) + checker.Name+"[#FFFAFA]...>*",player.ID,true);
	LangText("[#FFFAFA]  *"+GetRGBCode( player.ID )+player.Name+"[#FFFAFA] Zheng'zai Jian'cha Ni...", "[#FFFAFA]  *Player "+GetRGBCode( player.ID ) + player.Name+"[#FFFAFA] is checking you...",checker.ID,false);
	if ( checker.Ping > 200 ) LangText(null,"[#FFFAFA]  *<[#00E3E3]"+checker.Name+" [#FFFAFA] 's Ping higher than 200ms, So server is checking whether he is cheating...>*",player.ID,true),CheckCheat(checker.ID, player.ID, 0);
	else if ( checker.Ping > 400 ) LangText(null,"[#FFFAFA]  *<[#00E3E3]"+checker.Name+" [#FFFAFA] 's Ping higher than 400ms, So server is checking whether he is cheating...>*",player.ID,true),CheckCheat(checker.ID, player.ID, 0);
	else if ( checker.Ping > 500 ) CheckCheat(checker.ID, player.ID, 1);
	else CheckCheat(checker.ID, player.ID, 0);
}

function CheckCheat( checker, player, pingstate )
{
	local checker = FindPlayer(checker);
	local player = FindPlayer(player);
	local oldhealth = checker.Health;
	local oldarmour = checker.Armour;
	local oldposx = checker.Pos.x;
	local oldposy = checker.Pos.y;
	local oldposz = checker.Pos.z;
	checker.World += player.ID;
	checker.Pos = Vector(-424.623, 32.7852, 5.19233);
	checker.Pos = Vector(-424.623, 32.7852, 5.19233);
	Status[player.ID].CheckingStep = 1;
	NewTimer( "CheckEnd", 666, 1, checker.ID, player.ID, pingstate, oldhealth, oldarmour, oldposx, oldposy, oldposz );
}

function CheckEnd( checker, player, pingstate, oldhealth, oldarmour, oldposx, oldposy, oldposz )
{
	local checker = FindPlayer(checker);
	local player = FindPlayer(player);
	local newhealth = checker.Health;
	local newarmour = checker.Armour;
	local plrname = player.Name;
	local plrid = player.ID;
	NewTimer( "FreeCheck", 120000, 1, plrid );
	if ( newhealth < oldhealth || newarmour < oldarmour)
	{
		if (Status[player.ID].CheckingStep != 2)
		{
			checker.Pos = Vector(-424.623, 32.7852, 12.19233);
			Status[player.ID].CheckingStep = 2;
			NewTimer( "CheckEnd", 1234, 1, checker.ID, player.ID, pingstate, oldhealth, oldarmour, oldposx, oldposy, oldposz );
		}
		else if ( Status[player.ID].CheckingStep == 2)
		{
			Status[player.ID].CheckingStep = 0;
			LangText(null,"[#FFFAFA]  *<"+GetRGBCode(checker.ID)+checker.Name+"[#FFFAFA] did not cheat =w=>*",player.ID,true);
			checker.World -= player.ID;
			checker.Health = oldhealth;
			checker.Armour = oldarmour;
			checker.Pos = Vector(oldposx, oldposy, oldposz);
			PlaySoundForWorld(checker.World, 50060);
			if ( pingstate == 1 )
			{
				LangText(null,"[#FFFAFA]  *<But "+GetRGBCode(checker.ID)+checker.Name+"[#FFFAFA] 's Ping is higher than 500ms =w=>*",player.ID,true);
				Message("[#FFFAFA]  *<Auto-Kick: "+GetRGBCode( checker.ID )+checker.Name + "[#FFFAFA], Reason:[#00E3E3] Ping Higher Than 500ms>*");
				player.Cash += 6666;
				LangText("[#FFFAFA]  *Jiang'li ni [#00CCFF]$6666[#FFFAFA]!", "[#FFFAFA]  *You got cash [#00CCFF]$6666[#FFFAFA]!",player.ID,false)
				KickPlayer( checker );
				PlaySound( checker.World , 335 , checker.Pos );
			}
		}
	}
	else if ( newhealth == oldhealth || newarmour == oldarmour) Message("[#FFFAFA]  *<Auto-Ban: "+GetRGBCode( checker.ID )+checker.Name + "[#FFFAFA], Reason:[#00E3E3] Health Hack, [#FFFAFA]Time:[#00E3E3] 30 minutes>*"),BanPlayer( checker ),NewTimer( "UnbanIP", 1800000, 1, checker.IP );
	else Message("[#FFFAFA]  *<Error-Kick: "+GetRGBCode( checker.ID )+checker.Name + "[#FFFAFA], Reason:[#00E3E3] Error, [#FFFAFA]Time:[#00E3E3] None>*"),KickPlayer( checker );
}

function FreeCheck(player)
{
	local player = FindPlayer(player)
	if(player) Status[player.ID].CanCheck = true;
}

RandomMessagesCN <-
{
	Message1 = @"[#FAFAD2]-Wan De Kai'xin =w=~",
	Message2 = @"[#FAFAD2]-Zhao'dao GB Yao [#FF8000]/check + player.ID [#FAFAD2]=w=",
	Message3 = @"[#FAFAD2]-Bu'hui Wan? [#FF8000]    !F2! [#FAFAD2]=w=",
	Message4 = @"[#FAFAD2]-Su'zhi [#FAFAD2]Jue'ding Yi'qie.",
	Message5 = @"[#FAFAD2]-You Wen'ti Yao [#FF8000]/report[#FAFAD2], GB Yao [#FF8000]/check [#FAFAD2]=w=",
	Message6 = @"[#FAFAD2]-Fu'zhu Laji! -w-",
	Message7 = @"[#FAFAD2]-Miaow =w=",
	Message8 = @"[#FAFAD2]-Fu'wu'qi Laji !??? [#FF8000]/report [#FAFAD2]=w=",
}

RandomMessages <-
{
	Message1 = @"....../aaaaaa......",
	Message2 = @"Use !check + player.ID to check hacker =w =",
	Message3 = @"F2 Help Menu =w =",
	Message4 = @"Please use polite language QAQ",
	Message5 = @"Our QQ Group: 531886706, Welcome to join =w =",
	Message6 = @"Miaow =w =",
}

RandomGameModeName <-
{
	GameModeName1 = @"QAQ",
	GameModeName2 = @"Nya =w=",
	GameModeName3 = @"QWQ",
	GameModeName4 = @"QQGroup:531886706",
	GameModeName5 = @"NRealLife V2",
	GameModeName6 = @"wwwwww",
	GameModeName7 = @"NRPG V2",
	GameModeName8 = @"Welcome =w=",
}

function SetRandomMessages (state)
{
	if (state == true)
	{
		NewTimer( "STextAll", 60000, 1, RandomMessages.Message1, 1 );
		NewTimer( "STextAll", 120000, 1, RandomMessages.Message2, 1 );
		NewTimer( "STextAll", 180000, 1, RandomMessages.Message3, 1 );
		NewTimer( "STextAll", 240000, 1, RandomMessages.Message4, 1 );
		NewTimer( "STextAll", 300000, 1, RandomMessages.Message5, 1 );
		NewTimer( "STextAll", 360000, 1, RandomMessages.Message6, 1 );
		NewTimer( "SetRandomMessages", 360000, 1, true );
	}
}

function SetRandomGameModeName (state)
{
	if (state == true)
	{
		NewTimer( "SetGameModeName", 750, 1, RandomGameModeName.GameModeName1 );
		NewTimer( "SetGameModeName", 1500, 1, RandomGameModeName.GameModeName2 );
		NewTimer( "SetGameModeName", 2250, 1, RandomGameModeName.GameModeName3 );
		NewTimer( "SetGameModeName", 3000, 1, RandomGameModeName.GameModeName4 );
		NewTimer( "SetGameModeName", 3750, 1, RandomGameModeName.GameModeName5 );
		NewTimer( "SetGameModeName", 4500, 1, RandomGameModeName.GameModeName6 );
		NewTimer( "SetGameModeName", 5250, 1, RandomGameModeName.GameModeName7 );
		NewTimer( "SetGameModeName", 6000, 1, RandomGameModeName.GameModeName8 );
		NewTimer( "SetRandomGameModeName", 6000, 1, true );
	}
}

function GetTok(string, separator, n, ...)
{
	local m = vargv.len() > 0 ? vargv[0] : n,
	tokenized = split(string, separator),
	text = "";
	if (n > tokenized.len() || n < 1) return null;
	for (; n <= m; n++)
	{
		text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
	}
	return text;
}

function NumTok(string, separator)
{
	local tokenized = split(string, separator);
	return tokenized.len();
}

function PrintCmdMessges(player, cmd, text)
{
	local player = FindPlayer(player)
	if (cmd && text) timeprint("指令 - "+player.Name+": "+cmd+" "+text+"" );
	else if (!cmd && text) timeprint("指令 - "+player.Name+": "+text+"" );
	else if (cmd && !text) timeprint("指令 - "+player.Name+": "+cmd+"" );
	else null
}

function ResetPlayer(player)
{
	local player = FindPlayer(player)
	Status[player.ID].IsLogin = false;
}

function IpToCountry( string ) { return !(string == "127.0.0.1") ? ( ( string = geoip_country_name_by_addr( string ) ) ? string : "Unknown" ) : "Localhost"; }

function StartAkinaRacing(player)
{
	local player = FindPlayer(player);
	if(player)
	{
		if(Status[player.ID].IsReady == true && Status[player.ID].IsReady2 == true)
		{
			Status[player.ID].IsRacingAkina = true;
			Status[player.ID].IsReady = false;
			Status[player.ID].IsReady2 = false;
			local id = player.ID;
			NewTimer("PlayMusicForPlayer", 999, 1, id, 50009);
			NewTimer("PlayMusicForPlayer", 999, 1, id, 50009);
			NewTimer("PlayMusicForPlayer", 999, 1, id, 50009);
			NewTimer("PlayMusicForPlayer", 1000, 1, id, 50005);
			NewTimer("PlayMusicForPlayer", 2000, 1, id, 50005);
			NewTimer("PlayMusicForPlayer", 3000, 1, id, 50005);
			NewTimer("PlayMusicForPlayer", 4000, 1, id, 50005);
			NewTimer("PlayMusicForPlayer", 5000, 1, id, 50005);
			/*
			NewTimer("SendIDPacketToClient", 1000, 1, id, "Sprite", "count5");
			NewTimer("SendIDPacketToClient", 2000, 1, id, "Sprite", "count4");
			NewTimer("SendIDPacketToClient", 3000, 1, id, "Sprite", "count3");
			NewTimer("SendIDPacketToClient", 4000, 1, id, "Sprite", "count2");
			NewTimer("SendIDPacketToClient", 5000, 1, id, "Sprite", "count1");
			*/
			NewTimer("SText", 1000, 1, "5", id, 1);
			NewTimer("SetCamera", 1000, 1, id, player.Pos.x+2, player.Pos.y+5, player.Pos.z+6.3, player.Pos.x, player.Pos.y, player.Pos.z);
			NewTimer("SText", 2000, 1, "4", id, 1);
			NewTimer("SetCamera", 2000, 1, id, player.Pos.x+5, player.Pos.y+2, player.Pos.z+8.3, player.Pos.x, player.Pos.y, player.Pos.z);
			NewTimer("SText", 3000, 1, "~y~3", id, 1);
			NewTimer("SetCamera", 3000, 1, id, player.Pos.x, player.Pos.y, player.Pos.z+9, 946.1308, 318.3987, 395.1787);
			NewTimer("SText", 4000, 1, "~y~2", id, 1);
			NewTimer("SetCamera", 4000, 1, id, 946.1308, 318.3987, 400.1787, player.Pos.x, player.Pos.y, player.Pos.z+9 );
			NewTimer("SText", 5000, 1, "~g~1", id, 1);
			NewTimer("SetCamera", 5000, 1, id, player.Pos.x, player.Pos.y+7, player.Pos.z+3, player.Pos.x, player.Pos.y, player.Pos.z+1.3);
			NewTimer("PlayMusicForPlayer", 5998, 1, id, 50101);
			NewTimer("PlayMusicForPlayer", 5999, 1, id, 50072);
			NewTimer("SText", 6000, 1, "Go!", id, 7);
			NewTimer("RestoreCamera", 6000, 1, id);
			//NewTimer("SendIDPacketToClient", 6000, 1, id, "Sprite", "counttiao");
			NewTimer("Message", 6000, 1, "[#FFFAFA]  *<"+GetRGBCode( id )+player.Name+" [#FFFAFA] is racing car in [#00E3E3]Akina[#FFFAFA]! =w=>*");
			NewTimer("TimerStart", 6000, 1, id);
			//NewTimer("ccheckpoint", 6000, 1, id);
		}
	}
}
/*秋名山超时提示(待使用)
function AkinaEnd( player )
{
local player= FindPlayer( player )
if (player) {
if ( ReadIniBool("Userdata/UserState.ini", "IsAkinaRacing", player.Name) == true )
{
SText("Sorry that Time Out	You lose!	But Failure is the mother of success", player.ID, 7);
Message("[#FFFAFA]  *<[#00E3E3]"+player.Name+" [#FFFAFA] Failed reaching the top of [#00E3E3]Akina[#FFFAFA]in 5 minutes! >_< >*")
WriteIniBool("Userdata/UserState.ini", "IsAkinaRacing", player.Name,false)
}
}
}
*/

function GetAkina( player, MScore, SScore )
{
	local player = FindPlayer( player );
}

function BodyPartText(bodypart)
{
	switch(bodypart)
	{
		case 0:return "to body";
		case 1:return "to torso";
		case 2:return "to left arm";
		case 3:return "to right arm";
		case 4:return "to left leg";
		case 5:return "to right leg";
		case 6:return "to head";
		case 7:return "hitting his car";
		default:return "unknown";
	}
}

function SpecialCarName(CarID)
{
	switch(CarID)
	{
		case 6400:return "Toyota Sprinter Trueno AE86"
		case 6401:return "PCJ600 Xbox";
		case 6402:return "Cheetah Xbox";
		case 6403:return "Police HD";
		case 6404:return "Grotti Cheetah Classic";
		default:return "Unknown";
	}
}

function SpecialWeaponName(WeaponID)
{
	switch(WeaponID)
	{
		case 100:return "fist";
		case 101:return "colt45 HD";
		case 102:return "stubby HD";
		case 103:return "spas12 HD";
		case 104:return "m4 HD";
		case 105:return "python HD";
		case 106:return "AK-47M";
		case 107:return "M14 EBR";
		default:return "Unknown";
	}
}

function ChoosingVehicle( player, shopname, vehicle )
{
	local player = FindPlayer(player)
	local vehicle = FindVehicle(vehicle)
	if( shopname.tolower() == "sunshine" )
	{
		PlaySound( player.World , 366 , player.Pos );
		player.IsFrozen = true;
		vehicle.Pos = Vector(-1011.6929, -882.9532, 12.9868);
		player.SetCameraPos( Vector( -1008.6556, -875.0151, 14.6868 ), Vector( -1011.6929, -882.9532, 12.8868 ) );
		SText("~y~Sunshine ~b~Vehicle ~g~Shop", player.ID, 0);
		SText("~y~Are you sure to buy it? ~g~-Shift- ~y~? or Exit ~g~-Backspace-", player.ID, 1);
		SText("ID: " + vehicle.ID + " " + GetVehicleNameFromModel(vehicle.Model) + " - $" + GetSQLColumnData(QuerySQL(World, "SELECT Price FROM VehiclePrice WHERE VehicleModel='"+vehicle.Model+"'"), 0), player.ID, 7);
	}
}

function BuyVehicle( player, vehicle )
{
	local player = FindPlayer(player)
	local vehicle = FindVehicle(vehicle)
	if(player.Cash < GetSQLColumnData(QuerySQL(World, "SELECT Price FROM VehiclePrice WHERE VehicleModel='"+vehicle.Model+"'"), 0)) SText("~y~You don't have enough money! [$" + GetSQLColumnData(QuerySQL(World, "SELECT Price FROM VehiclePrice WHERE VehicleModel='"+vehicle.Model+"'"), 0), player.ID, 1);
	else
	{
		PlaySound( player.World , 367 , player.Pos );
		QuerySQL(World, "UPDATE WorldVehicle SET Owner='" + player.Name.tolower() + "', User='"+ player.Name + "' WHERE VehID='"+vehicle.ID+"'")
		player.Cash -= GetSQLColumnData(QuerySQL(World, "SELECT Price FROM VehiclePrice WHERE VehicleModel='"+vehicle.Model+"'"), 0);
		player.IsFrozen = false;
		player.RestoreCamera();
		LangText("[#00DB00]    >Ni Mai'le Zhe Liang Che! =w=", "[#00DB00]    >You bought it! =w=", player.ID, false);
		Status[player.ID].IsBuyingVehicle = false;
	}
}

function ExitVehicleShop( player, vehicle )
{
	local player = FindPlayer(player)
	PlaySound( player.World , 377 , player.Pos );
	local vehicle = FindVehicle(vehicle)
	player.IsFrozen = false;
	player.RestoreCamera();
	Status[player.ID].IsBuyingVehicle = false;
}

function OwnVehicle(player)
{
	local player = FindPlayer(player)
	MessagePlayer("[#FFFAFA]  *---Your Vehicle List:---", player)
	for (local v = 0; v <= GetVehicleCount(); v++)
	{
		local vehicle = FindVehicle(v)
		if (vehicle)
		{
			if (GetSQLColumnData(QuerySQL(World, "SELECT Owner FROM WorldVehicle WHERE VehID='"+vehicle.ID+"'"), 0) == player.Name.tolower())
			{
				PlaySound( player.World , 357 , player.Pos );
				MessagePlayer("[#FFFAFA](Name: [#00CCFF]" + GetVehicleNameFromModel(vehicle.Model) + "[#FFFAFA], ID: [#00CCFF]" + v.tostring(), player)
			}
		}
	}
	MessagePlayer("[#FFFAFA]  *---Done---", player)
}

function GetBodyPartName(BodyPart)
{
	switch(BodyPart)
	{
		case 0:return "to body";
		case 1:return "to torso";
		case 2:return "to left arm";
		case 3:return "to right arm";
		case 4:return "to left leg";
		case 5:return "to right leg";
		case 6:return "to head";
		case 7:return "hitting his car";
		default:return "Unknown";
	}
}

function GetBodyPartCNName(BodyPart)
{
	switch(BodyPart)
	{
		case 0:return "身体";
		case 1:return "躯干";
		case 2:return "左胳膊";
		case 3:return "右胳膊";
		case 4:return "左腿";
		case 5:return "右腿";
		case 6:return "头部";
		case 7:return "车辆";
		default:return "身体?...";
	}
}

function GetTeamName(ID)
{
	switch(ID)
	{
		case 0:return "None";
		case 1:return "RCG";
		case 2:return "MVPchina";
		case 3:return "Demon";
		case 4:return "Trast";
		case 5:return "1Rx";
		case 6:return "CKM";
		case 7:return "ET";
		case 8:return "Gai";
		case 9:return "GVS";
		default:return "None";
	}
}

function GetRGBCode( player )
{
	local player = FindPlayer(player);
	local color = player.Colour.r;
	color = (color << 8) + player.Colour.g;
	color = (color << 8) + player.Colour.b;
	local msg = format("[#%06x]",color);
	return msg;
}

OldGetWeaponName <- GetWeaponName;
function GetWeaponName(weaponid)
{
	local wname = OldGetWeaponName(weaponid);
	if (!wname || wname == "Unknown" || wname == "unknown") return SpecialWeaponName(weaponid);
	else return wname;
}

OldGetVehicleNameFromModel <- GetVehicleNameFromModel;
function GetVehicleNameFromModel(id)
{
	local vname = OldGetVehicleNameFromModel(id);
	if (!vname || vname == "Unknown") return SpecialCarName(id)
	else return vname;
}

function ChoosingWeapon( player, x, y, z )
{
	local player = FindPlayer(player)
	if (Status[player.ID].IsBuyingWeapon == true)
	{
		PlaySound( player.World , 366 , player.Pos );
		SText("~y~RCG ~b~Weapon ~g~Shop", player.ID, 0);
		SText("~y~<A ~g~ Shift ~b~or ~g~Backspace ~y~ D>", player.ID, 1);
		player.IsFrozen = true;
		player.Pos = player.Pos;
		local ID = Status[player.ID].ViewWeapon;
		//Fix Weapon ID
		if (ID < 18) Status[player.ID].ViewWeapon = 18, ID = 18;
		else if (ID > 32) Status[player.ID].ViewWeapon = 32, ID = 32;
		else if (ID == 19) Status[player.ID].ViewWeapon = 21, ID = 21;
		else if (ID == 20) Status[player.ID].ViewWeapon = 18, ID = 18;
		else if (ID == 23) Status[player.ID].ViewWeapon = 26, ID = 26;
		else if (ID == 25) Status[player.ID].ViewWeapon = 22, ID = 22;
		else if (ID == 27) Status[player.ID].ViewWeapon = 29, ID = 29;
		else if (ID == 28) Status[player.ID].ViewWeapon = 26, ID = 26;
		else if (ID == 30) Status[player.ID].ViewWeapon = 32, ID = 32;
		else if (ID == 31) Status[player.ID].ViewWeapon = 29, ID = 29;
		local weapon = Status[player.ID].ViewWeapon;
		SText("Ammo: " + GetSQLColumnData(QuerySQL(World, "SELECT Ammo FROM WorldWeapon WHERE WepID='"+ID+"'"), 0).tostring() + " " + GetWeaponName(weapon) + " - $" + GetSQLColumnData(QuerySQL(World, "SELECT Price FROM WorldWeapon WHERE WepID='"+ID+"'"), 0).tostring(), player.ID, 6);
		if (x && y && z) player.SetCameraPos( Vector( x, y, z ), Vector( player.Pos.x, player.Pos.y, player.Pos.z ) );
		else player.SetCameraPos( Vector( player.Pos.x, player.Pos.y-2, player.Pos.z+1.5 ), Vector( player.Pos.x, player.Pos.y, player.Pos.z ) );
	}
}

function BuyWeapon( player )
{
	local player = FindPlayer(player)
	if (Status[player.ID].IsBuyingWeapon == true)
	{
		local weapon = Status[player.ID].ViewWeapon;
		local ID = Status[player.ID].ViewWeapon;
		if (player.Cash < GetSQLColumnData(QuerySQL(World, "SELECT Price FROM WorldWeapon WHERE WepID='"+ID+"'"), 0) && weapon) SText("~y~You don't have enough money! [$" + GetSQLColumnData(QuerySQL(World, "SELECT Price FROM WorldWeapon WHERE WepID='"+ID+"'"), 0) + "]  ~g~-Backspace-", player.ID, 1);
		else
		{
			PlaySound(player.World, 50005, player.Pos);
			PlaySound( player.World , 368 , player.Pos );
			player.GiveWeapon(weapon, GetSQLColumnData(QuerySQL(World, "SELECT Ammo FROM WorldWeapon WHERE WepID='"+ID+"'"), 0));
			player.Cash -= GetSQLColumnData(QuerySQL(World, "SELECT Price FROM WorldWeapon WHERE WepID='"+ID+"'"), 0);
			LangText("[#00DB00]    >Ni Mai'le " + GetWeaponName(weapon) + " and " + GetSQLColumnData(QuerySQL(World, "SELECT Ammo FROM WorldWeapon WHERE WepID='"+ID+"'"), 0) + " ammo! =w=", "[#00DB00]    >You bought it! =w=", player.ID, false);
			Announce("~g~A ~y~LShift ~b~You bought it! ~y~Backspace ~g~D", player, 1)
			SaveWeapon(player.ID);
		}
	}
}

function ExitWeaponShop( player )
{
	local player = FindPlayer(player)
	PlaySound( player.World , 377 , player.Pos );
	player.IsFrozen = false;
	RestoreCamera(player.ID);
	Status[player.ID].IsBuyingWeapon = false;
}

function TimerStart(player)
{
	local player = FindPlayer(player)
	if (player)
	{
		Status[player.ID].TimerState = true;
		Status[player.ID].TimerValue = 0;
		TimerVisible(player.ID)
		NewTimer("TimerWork", 1000, 1, player.ID)
	}
}

function TimerWork(player)
{
	local player = FindPlayer(player);
	if (player)
	{
		if(Status[player.ID].TimerState == true)
		{
			Status[player.ID].TimerValue += 1;
			TimerVisible(player.ID)
			NewTimer("TimerWork", 1000, 1, player.ID)
		}
	}
}

function TimerEnd(player)
{
	local player = FindPlayer(player);
	if (player)
	{
		Status[player.ID].TimerState = false;
		return Status[player.ID].TimerValue.tointeger();
		NewTimer("TimerInVisible", 4000, 1, player.ID)
	}
}

function TimerVisible(player)
{
	local player = FindPlayer(player)
	if (player && Status[player.ID].TimerState == true)
	{
		//FixTime
		local allsec = Status[player.ID].TimerValue.tointeger();
		local min = (allsec/60).tointeger();
		local sec = (allsec-(min*60));
		if(min < 10) min = "0"+min.tostring()
		else min = min.tostring();
		if(sec < 10) sec = "0"+sec.tostring()
		else sec = sec.tostring();
		Announce(min+":"+sec, player, 1)
		if(allsec >= 290 && allsec <= 299) PlaySoundForPlayer(player, 50006);
	}
}

function TimerInVisible(player)
{
	local player = FindPlayer
	if (player)
	{
		Status[player.ID].TimerState = false;
		Announce("", player, 1)
	}
}

function GetSpecialSkinName(ID)
{
	switch(ID)
	{
		case 201: return "Casual";
		case 202: return "Western";
		case 203: return "Gangster";
		case 204: return "Light";
		case 205: return "Sport";
		case 206: return "Forces";
		default: return "Unknown";
	}
}

function ChoosingClothes(player)
{
	local player = FindPlayer(player)
	if (Status[player.ID].IsBuyingClothes == true)
	{
		PlaySound( player.World , 366 , player.Pos );
		SText("~y~RCG ~b~Clothes ~g~Shop", player.ID, 0);
		SText("~y~A ~g~ Shift ~b~or ~g~Backspace ~y~ D", player.ID, 1);
		player.IsFrozen = true;
		player.SetCameraPos( Vector( 415.9041, 1038.61, 26.2998 ), Vector( player.Pos.x, player.Pos.y, player.Pos.z ) );
		local ID = Status[player.ID].ViewClothes;
		if (ID > 206) Status[player.ID].ViewClothes = 206;
		if (ID < 201) Status[player.ID].ViewClothes = 201;
		local ID = Status[player.ID].ViewClothes;
		player.Skin = ID;
		SText(GetSpecialSkinName(ID) + " $" + GetSQLColumnData(QuerySQL(World, "SELECT Price FROM SkinPrice WHERE SkinID='"+ID+"'"), 0), player.ID, 7)
	}
}

function BuyClothes(player)
{
	local player = FindPlayer(player)
	if (Status[player.ID].IsBuyingClothes == true)
	{
		local chooseid = Status[player.ID].ViewClothes;
		if (player.Cash < GetSQLColumnData(QuerySQL(World, "SELECT Price FROM SkinPrice WHERE SkinID='"+chooseid+"'"), 0)) SText("~y~You don't have enough money! [$" + GetSQLColumnData(QuerySQL(World, "SELECT Price FROM SkinPrice WHERE SkinID='"+chooseid+"'"), 0) + "] ~g~-Backspace-", player.ID, 1);
		else
		{
			PlaySound(player.World, 50005, player.Pos);
			PlaySound( player.World , 368 , player.Pos );
			player.IsFrozen = false;
			player.RestoreCamera();
			player.Cash -= GetSQLColumnData(QuerySQL(World, "SELECT Price FROM SkinPrice WHERE SkinID='"+chooseid+"'"), 0);
			LangText("[#00DB00]    >Ni Mai'le Zhe Jian Yi'fu! =w=", "[#00DB00]    >You bought it! =w=", player.ID, false);
			QuerySQL(Account, "UPDATE Account SET Skin='"+chooseid+"' WHERE Name='"+player.Name.tolower()+"'")
			player.Skin = chooseid;
			Status[player.ID].IsBuyingClothes = false;
		}
	}
}

function ExitClothesShop( player )
{
	local player = FindPlayer(player)
	PlaySound( player.World , 377 , player.Pos );
	player.IsFrozen = false;
	player.RestoreCamera();
	Status[player.ID].IsBuyingClothes = false;
	player.Skin = GetSQLColumnData(QuerySQL(Account, "SELECT Skin FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0)
}

function EatPizza( player )
{
	local player = FindPlayer(player)
	if (Status[player.ID].IsBuyingPizza == true)
	{
		if (player.Cash < 29) SText("~g~You don't have enough money! ~p~[$30]", player.ID, 1)
		else
		{
			PlaySound( player.World , 359 , player.Pos );
			SText("Enjoy......eating!", player.ID, 7)
			SText("~g~+5%HP! You can press ~y~LShift ~g~to eat pizza again..", player.ID, 1)
			player.Health += 5;
			player.Cash -= 30;
			FunPic("Eating", 1000);
		}
	}
}

function PutUpHotel(player)
{
	local player = FindPlayer(player)
	if (Status[player.ID].CanPutup == true)
	{
		PlaySound( player.World , 357 , player.Pos );
		local playerid = player.ID;
		player.Pos = Vector(228.551, -1263.4272, 20.5741);
		NewTimer("Wakeup", 30000, 1, playerid);
		SText("Please wait 30 second and you'll wake up...", playerid, 7)
		Status[player.ID].CanPutup = false;
		player.IsFrozen = true;
		SendPacketToClient(player, "Sprite", "allblack");
	}
}

function Wakeup(player)
{
	local player = FindPlayer(player);
	player.Health += 10;
	SText("You have been wake up!", player.ID, 7);
	player.Pos = Vector(228.551, -1263.4272, 20.5741);
	player.SetAnim( 172 );
	Status[player.ID].CanPutup = false;
	player.IsFrozen = false;
	PlaySound( player.World , 357 , player.Pos );
	SendPacketToClient(player, "Sprite", "noblack");
}

function ChoosingVehicleCol1(player)
{
	local player = FindPlayer(player)
	if (Status[player.ID].ViewVehicleCol1 < 0) Status[player.ID].ViewVehicleCol1 = 0;
	if (Status[player.ID].ViewVehicleCol1 > 99) Status[player.ID].ViewVehicleCol1 = 99;
	if (player.Vehicle)
	{
		PlaySound( player.World , 366 , player.Pos );
		player.Vehicle.Colour1 = Status[player.ID].ViewVehicleCol1;
		SText("~g~Select Color1 - "+Status[player.ID].ViewVehicleCol1.tostring(), player.ID, 1);
		SText("~y~A ~g~LShift(OK) ~y~D", player.ID, 7)
	}
}

function ChoosingVehicleCol2(player)
{
	local player = FindPlayer(player)
	if (Status[player.ID].ViewVehicleCol2 < 0) Status[player.ID].ViewVehicleCol2 = 0;
	if (Status[player.ID].ViewVehicleCol2 > 99) Status[player.ID].ViewVehicleCol2 = 99;
	if (player.Vehicle)
	{
		PlaySound( player.World , 366 , player.Pos );
		player.Vehicle.Colour2 = Status[player.ID].ViewVehicleCol2;
		SText("~g~Select Color~y~2~g~ - "+Status[player.ID].ViewVehicleCol2.tostring(), player.ID, 1);
		SText("~y~A ~g~LShift($233) ~y~D", player.ID, 7)
	}
}

function VehicleFix( player, checkpoint )
{
	local player = FindPlayer(player)
	if (player.Cash < 233) SText("~g~You don't have enough money! ~p~[$233] -Backspace-", player.ID, 1)
	else
	{
		PlaySound( player.World , 367 , player.Pos );
		PlaySound( player.World , 368 , player.Pos );
		SText("Your vehicle was fixed.", player.ID, 7)
		RestoreCamera(player.ID);
		player.Vehicle.Fix();
		player.Cash -= 233;
		if ( checkpoint == VehicleFix1.ID ) Status[player.ID].IsEnteringVRS1 = false, DVehicleFix1.MoveTo( Vector(-874.696, -116.696, 15.9875), 3000 );
		if ( checkpoint == VehicleFix2.ID ) Status[player.ID].IsEnteringVRS2 = false, DVehicleFix2.MoveTo( Vector(-7.80468, -1257.64, 15.8187), 3000 );
	}
}

function Getcar(player, vehicle)
{
	local player = FindPlayer(player);
	local vehicle = FindVehicle(vehicle);
	if(player && vehicle)
	{
		if(player.Health != 0)
		{
			PlaySound(player.World, 50002, player.Pos);
			vehicle.Pos.x = player.Pos.x+1.0, vehicle.Pos.y = player.Pos.y+1.0, vehicle.Pos.z = player.Pos.z;
			LangText("[#00DB00]    >Kuai Kan'kan Ni De Che! =w=", "[#00DB00]    >Look around! Your car! =w=", player.ID, false)
			Status[player.ID].CanGetVehicle = false;
			local plrid = player.ID;
			NewTimer("FreeGetVehicle", 30000, 1, plrid)
			SText("You got your vehicle successfully!", player.ID, 7)
		}
		else SText("You got your vehicle unsuccessfully!", player.ID, 7)
	}
}

function FreeGetVehicle(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		Status[player.ID].CanGetVehicle = true;
	}
}

function ExitFight(player)
{
	local player = FindPlayer(player)
	if(player.Health != 0 && Status[player.ID].StopProgress == false)
	{
		player.Pos = Vector(-1716.6895, -156.2967, 14.8683);
		MessagePlayer("[#FFFAFA]  *You have been exited [#66CCFF]FIGHT~[#00CCFF] [#FFFAFA]=w=", player);
		SText("You have been exited FIGHT", player.ID, 7)
		Status[player.ID].IsFighting = false;
	}
	else SText("Faild!", player.ID, 7)
}

function ClearWeapon( player )
{
	local player = FindPlayer(player)
	for (local i = 0; i < 200; i++)
	{
		player.RemoveWeapon(i);
	}
}

function GetOwnWeapon( player )
{
	//from Fantasy City
	local player = FindPlayer(player)
	player.Disarm();
	local wdata = GetSQLColumnData( QuerySQL( Account, "SELECT Weapons FROM Account WHERE Name='" + player.Name.tolower() + "'"), 0 );
	if( wdata ) wdata = split( wdata, " " );
	for( local i = 0; i < wdata.len(); i++ )
	{
		local weapon = split( wdata [ i ], "," );
		if( weapon && weapon != 0) player.GiveWeapon( weapon [ 0 ].tointeger(), weapon [ 1 ].tointeger() );
	}
}

function StealHotel( player )
{
	local player = FindPlayer(player)
	if(player)
	{
		local stealmoney = random(600, 1000), lvl;
		if (stealmoney >= 600 && stealmoney < 700) lvl = 1;
		else if (stealmoney >= 700 && stealmoney < 800) lvl = 1;
		else if (stealmoney >= 800 && stealmoney < 900) lvl = 2;
		else if (stealmoney >= 900 && stealmoney < 1000) lvl = 3;
		else lvl = 1;
		if ((player.WantedLevel.tointeger()+lvl) > 6) local wl = 6;
		else local wl = (player.WantedLevel.tointeger()+lvl);
		player.SetWantedLevel(wl.tointeger());
		if(random(1,3) == 1) player.Cash += stealmoney, SText("~y~You get ~g~$" + stealmoney.tostring(), player.ID, 7 )
		else player.Cash -= stealmoney, SText("~g~You lost ~y~$" + stealmoney.tostring(), player.ID, 7 )
		SText("", player.ID, 1)
		PlaySound( player.World , 359 , player.Pos );
	}
}

function Stunting(player)
{
	local player = FindPlayer(player)
	if(player && player.Vehicle)
	{
		//LangText("[#FFFAFA]  *Zhe li you dian wen ti dai xiufu...", "[#FFFAFA]  *This Function has some wrong...", player.ID, false)
		Status[player.ID].IsStunting = true;
		Status[player.ID].StuntFHigh = player.Pos.z;
		Status[player.ID].StuntHigh = 0.0;
		SText("Stunt High: 0m", player.ID, 1)
		NewTimer("StuntTimeout", 6666, 1, player.ID)
		StuntHigh(player.ID);
	}
}

function StuntTimeout(player)
{
	local player = FindPlayer(player)
	if(player) Status[player.ID].IsStunting = false;
}

function StuntHigh(player)
{
	local player = FindPlayer(player)
	if (player && player.Vehicle && Status[player.ID].IsStunting == true)
	{
		local High = player.Pos.z - Status[player.ID].StuntFHigh;
		if (High > Status[player.ID].StuntHigh)
		{
			Status[player.ID].StuntHigh = High;
			SText("~g~Stunt High: ~y~" + High.tostring() + "~g~m", player.ID, 1)
			NewTimer("StuntHigh", 40, 1, player.ID)
		}
		else NewTimer("StuntHigh", 40, 1, player.ID)
	}
	else
	{
		local High = Status[player.ID].StuntHigh;
		SText("~g~Stunt Score: ~y~" + High.tostring() + "~g~m", player.ID, 7)
		Message("[#FFFAFA]  *" + GetRGBCode(player.ID) + player.Name + "[#FFFAFA] 's Stunt Score: [#00CCFF]" + High.tostring() + "[#FFFAFA]!")
		SText("~g~Stunt High: ~y~" + High.tostring() + "~g~m", player.ID, 1)
		player.Cash += High.tointeger()*50;
	}
}

function TeamColor( player )
{
	local player = FindPlayer(player)
	local team = GetSQLColumnData(QuerySQL(Account, "SELECT Team FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0)
	if (!team) QuerySQL(Account, "UPDATE Account SET Team='0' WHERE Name='"+player.Name.tolower()+"'"), player.Team = 0, player.Colour = RGB( 255, 255, 255 );
	else
	{
		if ( team == 0 ) player.Colour = RGB( 255, 255, 255 );
		if ( team == 1 ) player.Colour = RGB( 102, 204, 255 );
		if ( team == 2 ) player.Colour = RGB( 0, 200, 200 );
		if ( team == 3 ) player.Colour = RGB( 0, 200, 50 );
		if ( team == 4 ) player.Colour = RGB( 222, 222, 222 );
		if ( team == 5 ) player.Colour = RGB( 128, 128, 255 );
		if ( team == 6 ) player.Colour = RGB( 255, 128, 192 );
		if ( team == 7 ) player.Colour = RGB( 192, 128, 200 );
		if ( team == 8 ) player.Colour = RGB( 123, 233, 66 );
		if ( team == 9 ) player.Colour = RGB( 22, 55, 88 );
		player.Team = team;
	}
}

function CheckPing()
{
    for(local p = 0; p <= GetMaxPlayers(); p++)
    {
        local player = FindPlayer(p);
	    if ( player )
		{
			if (player.Ping > 650) onPlayerPart(player, "highping")
		}
	}
	NewTimer("CheckPing", 10000, 1)
}

function SaveData()
{
	for(local p = 0; p < GetMaxPlayers(); p++)
    {
        local player = FindPlayer(p);
	    if ( player )
		{
			local Today = GetYear()+"-"+GetMonth()+"-"+GetDay();
			QuerySQL(Account, "UPDATE Account SET PosX='"+player.Pos.x+"', PosY='"+player.Pos.y+"', PosZ='"+player.Pos.z+"', Cash='"+player.Cash+"', HP='"+player.Health+"', AP='"+player.Armour+"', WantedLevel='"+player.WantedLevel+"', User='"+player.Name+"', Skin='"+player.Skin+"', LastActive='"+Today+"' WHERE Name='"+player.Name.tolower()+"'");
			SaveWeapon(player.ID);
		}
	}
}

function SaveWeapon(player)
{
	local player = FindPlayer( player );
	local w = "";
	for(local i = 0; i <= 8; i++ )
	{
		local wep = player.GetWeaponAtSlot( i );
		local ammo = player.GetAmmoAtSlot( i );
		if( wep != 0 )
		{
			if( i == 0 ) w = w + format( "%d,%d", wep, ammo );
			else w = w + format( " %d,%d", wep, ammo );
		}
	}
	QuerySQL( Account, "UPDATE Account SET Weapons='" + w + "' WHERE Name='" + player.Name.tolower() + "'" );
}

function AfterNewSelectingLanguage(player)
{
}
/*
function Message_CN(R, G, B, ...)
{
	local wordtype, X;
	for (local j = 0; j < GetMaxPlayers(); j++)
	{
		local player = FindPlayer(j)
		if (player && CNTER[player.ID].CNTypeLine != 30) CNTER[player.ID].CNTypeLine += 1, CNTER[player.ID].CNTypeLongSize = 22;
	}
	for (local i = 4; i < 10; i++)
	{
		if(vargv[i].len() == 1) wordtype = "EN", X = 22;
		else wordtype = "CN", X = 22;
		for (local k = 0; k < GetMaxPlayers(); k++)
		{
			local player = FindPlayer(k)
			if (player)
			{
				local data = Stream();
				data.WriteString( "Sprite" )
				data.WriteString( "cn" );
				data.WriteString( vargv[i] );
				data.WriteString("")
				data.WriteInt( R );
				data.WriteInt( G );
				data.WriteInt( B );
				data.WriteFloat(0);data.WriteFloat(0);data.WriteFloat(0);
				data.WriteInt( CNTER[player.ID].CNTypeLongSize );
				data.WriteInt( CNTER[player.ID].CNTypeLine*22+50 );
				data.SendStream( player );
				CNTER[player.ID].CNTypeLongSize += X;
			}
		}
	}
}
*/

function TXTAddLine(filename, text)
{
	local fhnd = file(filename, "a+");
	foreach(char in text)
	fhnd.writen(char, 'c');	
	fhnd.writen('\n', 'c');
	fhnd=null;
}

//定义升级所需经验值
function LevelExp(exp)
{
	if(exp)
	{
		switch(exp)
		{
			case 1: return 10; break;
			case 2: return 20; break;
			case 3: return 40; break;
			case 4: return 70; break;
			case 5: return 110; break;
			case 6: return 160; break;
			case 7: return 220; break;
			case 8: return 290; break;
			case 9: return 370; break;
			case 10: return 460; break;
			case 11: return 560; break;
			case 12: return 670; break;
			case 13: return 790; break;
			case 14: return 920; break;
			case 15: return 1060; break;
			case 16: return 1210; break;
			case 17: return 1370; break;
			case 18: return 1540; break;
			case 19: return 1720; break;
			case 20: return 1910; break;
			case 21: return 2110; break;
			case 22: return 2320; break;
			case 23: return 2540; break;
			case 24: return 2770; break;
			case 25: return 3010; break;
			case 26: return 3260; break;
			case 27: return 3520; break;
			case 28: return 3790; break;
			case 29: return 4070; break;
			case 30: return 4360; break;
			case 31: return 5000; break; //Max level
		}
	}
}

function IncExp(player, exp)
{
	local player = FindPlayer(player)
	if(player && exp)
	{
		local lvl = GetSQLColumnData(QuerySQL(Account, "SELECT Level FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) //当前等级
		local lvll = (lvl+1) //当前等级+1
		local lvlll = (lvl+2) //当前等级+2
		local lvllll = (lvl+3) //当前等级+3
		local Bexp = GetSQLColumnData(QuerySQL(Account, "SELECT Exp FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) //之前经验值
		local Aexp = (Bexp + exp); //现在经验值
		QuerySQL(Account, "UPDATE Account SET Exp='"+Aexp+"' WHERE Name='"+player.Name.tolower()+"'") //写入现在经验值
		MessagePlayer("[#00DB00]    >You just got [#00CCFF]" + exp.tostring() + " [#00DB00]exp~", player)
		if(Aexp >= LevelExp(lvll))
		{
			if(Aexp >= LevelExp(lvlll))
			{
				if(Aexp >= LevelExp(lvllll))
				{
					PlaySound(player.World, 50005, player.Pos);
					Announce("LEVEL UP", player, 7)
					QuerySQL(Account, "UPDATE Account SET Level='"+lvllll+"' WHERE Name='"+player.Name.tolower()+"'");
					player.Cash += 3000;
					MessagePlayer("[#00DB00]    >Level up! Level up! Level up! You are [#FFD700]Lv." + lvllll.tostring() + " [#00DB00]Now! AND You got [#00CCFF]$3000[#00DB00] =W=", player)
				}
				else
				{
					PlaySound(player.World, 50005, player.Pos);
					Announce("LEVEL UP", player, 7)
					QuerySQL(Account, "UPDATE Account SET Level='"+lvlll+"' WHERE Name='"+player.Name.tolower()+"'");
					player.Cash += 2000;
					MessagePlayer("[#00DB00]    >Level up! Level up! You are [#FFD700]Lv." + lvlll.tostring() + " [#00DB00]Now! AND You got [#00CCFF]$2000[#00DB00] =W=", player)
				}
			}
			else
			{
				PlaySound(player.World, 50005, player.Pos);
				Announce("LEVEL UP", player, 7)
				QuerySQL(Account, "UPDATE Account SET Level='"+lvll+"' WHERE Name='"+player.Name.tolower()+"'");
				player.Cash += 1000;
				MessagePlayer("[#00DB00]    >Level up! You are [#FFD700]Lv." + lvll.tostring() + " [#00DB00]Now! AND You got [#00CCFF]$1000[#00DB00] =W=", player)
			}
		}
	}
}

function GetLevel(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		local lvl = GetSQLColumnData(QuerySQL(Account, "SELECT Level FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0)
		if(lvl) return lvl.tointeger();
		else return 0;
	}
}

function GetExp(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		local exp = GetSQLColumnData(QuerySQL(Account, "SELECT Exp FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0)
		if(exp) return exp.tointeger();
		else return 0;
	}
}

function VehicleEndAlarm(vehicle)
{
	local vehicle = FindVehicle(vehicle);
	if(vehicle) vehicle.Alarm = false;
}

function IsHealSphere(SphereID)
{
	local result;
	for(local p = 0; p < GetMaxPlayers(); p++)
	{
		local plr = FindPlayer(p);
		if(plr)
		{
			if(ReadIniString("Data/Sphere.ini", "SphereID", SphereID.tostring()) != "None" && ReadIniString("Data/Sphere.ini", "SphereID", SphereID.tostring())) result = true;
		}
	}
	return result;
}

function HealPlayer(player, plr)
{
	local player = FindPlayer(player)
	local plr = FindPlayer(plr)
	if(player && Status[player.ID].StopProgress == false)
	{
		local BHealth = player.Health.tointeger();
		local AHealth = 100;
		if(BHealth < AHealth)
		{
			player.Cash -= (AHealth-BHealth)*5;
			plr.Cash += (AHealth-BHealth)*5;
			player.Health = 100.0;
			Status[player.ID].WheretoHeal = "None";
			Status[player.ID].IsHealing = false;
			IncExp(plr.ID, 2)
		}
	}
}

function RandomWeather()
{
	local num = random(1, 11);
	if ( num == 1 )
	{
		SetWeather(0);
		Message( "[#FFFAFA]  *It's a good weather!" );
	}
	else if ( num == 2 ) 
	{
		SetWeather(1);
		Message( "[#FFFAFA]  *It's cloudy.." );
	}
	else if ( num == 3 ) 
	{
		SetWeather(2);
		Message( "[#FFFAFA]  *It's a rain day~" );
	}
	else if ( num == 4 ) 
	{
		SetWeather(3);
		Message( "[#FFFAFA]  *It's a heavy fog!" );
	}
	else if ( num == 5 ) 
	{
		SetWeather(5);
		Message( "[#FFFAFA]  *Badly, It's a thunderstorm days!!!" );
	}
	else if ( num == 6 ) 
	{
		SetWeather(4);
		Message( "[#FFFAFA]  *It's a sunny day!" );
	}
	else if ( num == 7 ) 
	{
		SetWeather(1);
		Message( "[#FFFAFA]  *It's cloudy.." );
	}
	else if ( num == 8 ) 
	{
		SetWeather(0);
		Message( "[#FFFAFA]  *It's a good weather!" );
	}
	else if ( num == 9 ) 
	{
		SetWeather(1);
		Message( "[#FFFAFA]  *It's cloudy.." );
	}
	else if ( num == 10 ) 
	{
		SetWeather(4);
		Message( "[#FFFAFA]  *It's a sunny day!" );
	}
	NewTimer("RandomWeather", 600000, 1);
}

function GetWeaponType(weaponid)
{
//By Ctone
	if(weaponid)
	{
		switch(weaponid)
		{
			case 0:
			case 1:
			case 2:
			case 3:
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
			case 11:
				return "melee";
			case 12:
			case 13:
			case 14:
			case 15:
			case 16:
				return "missile";
			case 17:
			case 18:
				return "pistol";
			case 19:
			case 20:
			case 21:
				return "shotgun";
			case 22:
			case 23:
			case 24:
			case 25:
				return "submachine";
			case 26:
			case 27:
				return "rifle";
			case 28:
			case 29:
				return "sniper";
			default: return "Unknown";
		}
	}
}

function SlotWeapons(player)
{
    local WeaponID;
    for (local i = 0; i <= 8; i++)// Loops from slot 0 to 8.
    {
        WeaponID = player.GetWeaponAtSlot(i); // Will return the weapon ID
        MessagePlayer( "Player Weapon slot " + i + ": " + GetWeaponName(WeaponID), player ); // Displays the name of the weapons in each slot
    }
}

function ResetViewTeam(player) { if(FindPlayer(player)) Status[FindPlayer(player).ID].ViewTeam = null }
function ResetViewJob(player) { if(FindPlayer(player)) Status[FindPlayer(player).ID].ViewJob = null }
function GetVehicleType( model )
{
        // by Force
        // Returns: Car / Bike / Heli / Plane / Boat / RC
        switch ( model ) {
                case 136:
                case 160:
                case 176:
                case 182:
                case 183:
                case 184:
                case 190:
                case 202:
                case 203:
                case 214:
                case 223:
                        return "Boat";
                case 155:
                case 165:
				case 177:
				case 199:
                case 217:
                case 218:
                case 227:
                        return "Heli";
                case 166:
                case 178:
                case 191:
                case 192:
                case 193:
                case 198:
                        return "Bike";
                case 171:
                case 194:
                case 195:
                case 231:
                        return "RC";
                case 180:
                case 181:
                        return "Plane";
                case 6400:
                case 6401:
                case 6402:
                case 6403:
                case 6404:
                default:
				return "Car";
        }
}

function CheckWanted()
{
	for(local i = 0; i < GetMaxPlayers(); i++)
	{
		local player = FindPlayer(i)
		if(player)
		{
			local wl = player.WantedLevel;
			if(wl == 0)
			{
				local data = Stream();
				data.WriteString( "Sprite" );
				data.WriteString( "removewanted" );
				data.SendStream( player );
			}
			else
			{
				local data = Stream();
				data.WriteString( "Sprite" );
				data.WriteString( "addwanted" );
				data.SendStream( player );
			}
		}
	}
	NewTimer("CheckWanted", 5000, 1);
}

function CheckDistrict()
{
	for(local i = 0; i < GetMaxPlayers(); i++)
	{
		local player = FindPlayer(i)
		if(player)
		{
			if(Status[player.ID].DistrictName == GetDistrictName( player.Pos.x, player.Pos.y )) null
			else
			{
				Announce(GetDistrictName( player.Pos.x, player.Pos.y ), player, 2)
				GetDistrictName( player.Pos.x, player.Pos.y )
			}
		}
	}
	NewTimer("CheckDistrict", 5000, 1);
}

/*
function CheckDistance()
{
	DistanceFromPoint( x1, y1, x2, y2 )
	local ok = false;
	for(local i = 0; i < GetMaxPlayers(); i++)
	{
		local player = FindPlayer(i)
		if(player)
		{
			for(local j = 0; j < GetMaxPlayers(); j++)
			{
				local plr = FindPlayer(j)
				if(DistanceFromPoint( player.Pos.x, player.Pos.y, plr.Pos.x, plr.Pos.y ) < 4)
				{
					ok = true;
					Status[player.ID].NearPlr = plr.Name;
					local data = Stream();
					data.WriteString( "Sprite" );
					data.WriteString( "addmenutip" );
					data.SendStream( player );
				}
			}
			if(ok == false)
			{
				Status[player.ID].NearPlr = null;
				local data = Stream();
				data.WriteString( "Sprite" );
				data.WriteString( "removemenutip" );
				data.SendStream( player );
			}
		}
	}
	NewTimer("CheckWanted", 10000, 1);
}
*/
OldBanPlayer <- BanPlayer;
function BanPlayer(player, reason, time)
{
	local player = FindPlayer(player), timeh;
	if(player)
	{
		if(time < 60) timeh = time.tostring()+" minutes";
		else if(time < 1440)
		{
			if(((time/60)-(time/60).tointeger()) == 0) timeh = (time/60).tostring()+" hours";
			else timeh = (time/60).tostring()+" hours "+((time/60)-(time/60).tointeger()).tostring()+" minutes";
		}
		else timeh = time.tostring()+" minutes";
		if(player && reason && time)
		{
			QuerySQL( Account, "UPDATE Banned SET IsBanned='true', Time='"+time+"', BanTime='"+GetYear()+"-"+GetMonth()+"-"+GetDay()+"-"+GetHour()+"-"+GetMin()+"', Reason='"+reason+"' WHERE Name='" + player.Name.tolower() + "'");
			Message( "[#FFFAFA]  *<Ban Player: " + GetRGBCode(player.ID) + player.Name + "[#FFFAFA] , Reason: [#00CCFF]"+reason+"[#FFFAFA], Time: [#00CCFF]"+timeh+"[#FFFAFA]>*" );
			KickPlayer( player );
		}
	}
}

function CheckBanned(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		local isbanned = GetSQLColumnData(QuerySQL(Account, "SELECT IsBanned FROM Banned WHERE Name='"+player.Name.tolower()+"'"), 0);
		local time = GetSQLColumnData(QuerySQL(Account, "SELECT Time FROM Banned WHERE Name='"+player.Name.tolower()+"'"), 0);
		local bantime = GetSQLColumnData(QuerySQL(Account, "SELECT BanTime FROM Banned WHERE Name='"+player.Name.tolower()+"'"), 0);
		local reason = GetSQLColumnData(QuerySQL(Account, "SELECT Reason FROM Banned WHERE Name='"+player.Name.tolower()+"'"), 0);
		if(isbanned == true)
		{
			local param = split( bantime, "-" );
			local byear = param[0], bmonth = param[1], bday = param[2], bhour = param[3], bminute = param[4];
			local year = GetYear(), month = GetMonth(), day = GetDay(), hour = GetHour(), minute = GetMin();
			if(byear != year || bmonth != month) QuerySQL( Account, "UPDATE Banned SET IsBanned='false', Time='0', WHERE Name='" + player.Name.tolower() + "'");
			else if(bday == day)
			{
				local minuted = 60*(hour-bhour)+(minute-bminute);
				if(minuted >= time) QuerySQL( Account, "UPDATE Banned SET IsBanned='false', Time='0', WHERE Name='" + player.Name.tolower() + "'");
				else
				{
					local timew = (time-minuted).tointeger();
					if(timew < 60) timeh = timew.tostring()+" minutes";
					else if(timew < 1440)
					{
						if(((timew/60)-(timew/60).tointeger()) == 0) timeh = (timew/60).tostring()+" hours";
						else timeh = (timew/60).tostring()+" hours "+((timew/60)-(timew/60).tointeger()).tostring()+" minutes";
					}
					else timeh = timew.tostring()+" minutes";
					Message( "[#FFFAFA]  *<Banned Player: " + GetRGBCode(player.ID) + player.Name + "[#FFFAFA] , Reason: "+reason+", Time: "+timeh+">*" );
				}
			}
			else
			{
				local minuted = 60*(24-bhour)+(0-bminute)+(hour*60)+minute;
				if(minuted >= time) QuerySQL( Account, "UPDATE Banned SET IsBanned='false', Time='0', WHERE Name='" + player.Name.tolower() + "'");
				else
				{
					local timew = (time-minuted).tointeger();
					if(timew < 60) timeh = timew.tostring()+" minutes";
					if(timew < 1440)
					{
						if(((timew/60)-(timew/60).tointeger()) == 0) timeh = (timew/60).tostring()+" hours";
						else timeh = (timew/60).tostring()+" hours "+((timew/60)-(timew/60).tointeger()).tostring()+" minutes";
					}
					else timeh = timew.tostring()+" minutes";
					Message( "[#FFFAFA]  *<Banned Player: " + GetRGBCode(player.ID) + player.Name + "[#FFFAFA] , Reason: "+reason+", Time: "+timeh+">*" );
				}
			}
		}
	}
}

//FROM FANTASY CITY 2.0
function Check_MAC( player )
{
	local player = FindPlayer(player)
	if(player)
	{
		for( local plr, i = 0; i <= GetMaxPlayers(); plr = FindPlayer( i++ ) )
		{
			if ( player && plr )
			{
				if ( plr.ID == player.ID ) return;
				if ( player.IP == plr.IP )
				{
					MessagePlayer("[#FFFAFA]  *Please don't open multiple clients...", player);
					Announce("~y~MAC Check Kick!", player, 7)
					Message( "[#FFFAFA]  *<Auto-Kick: " + GetRGBCode(player.ID) + player.Name + "[#FFFAFA] , Reason: Multiple Clients>*" );
					KickPlayer( player );
				}
			}
		}
	}
}

function QAQInteresting()
{
	if(InterestingNow >= 8)
	{
		InterestingNow = 0;
		local data = Stream();
		data.WriteString( "Sprite" );
		data.WriteString( "donehuaji" );
		data.SendStream( null );
	}
	else
	{
		local data = Stream();
		InterestingNow += 1;
		data.WriteString( "Sprite" );
		data.WriteString( "updatehuaji" );
		data.WriteString( "" );
		data.WriteString( "" );
		data.WriteInt( InterestingNow );
		data.SendStream( null );
		NewTimer("QAQInteresting", 100, 1)
	}
}

function IpToCountry(IP)
{
	local result, query, IPsplit = split( IP, "." );
	if ( !IpToCountryDB ) return "Error";
	if ( IP == "127.0.0.1" ) return "Localhost";
	if ( IPsplit.len() != 4 ) return "Invalid IP";
	result = QuerySQL(IpToCountryDB, "SELECT Country FROM countrydetected WHERE ((" + IPsplit[0].tointeger() + " * 16777216) + (" + IPsplit[1].tointeger() + " * 65536) + (" + IPsplit[2].tointeger() + " * 256) + " + IPsplit[3].tointeger() + ") BETWEEN Ip_From AND Ip_to LIMIT 1");
	query = GetSQLColumnData( result, 0 );
	if ( !query ) query = "Unknown";
	FreeSQLQuery( result );
	return query;
}

function SendLanguage(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		local lang = GetSQLColumnData(QuerySQL(Account, "SELECT Language FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
		if(lang && lang != "Selecting")
		{
			local sendto;
			if(lang == "Chinese") sendto = "CN";
			else sendto = "EN";
			local data = Stream();
			data.WriteString("Sprite");
			data.WriteString("setlang");
			data.WriteString(sendto);
			data.SendStream(player);
		}
	}
}

function VehDamage(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		local data = Stream();
		data.WriteString("Sprite");
		data.WriteString("wtf???");
		data.WriteString("");
		data.WriteString("");
		data.WriteInt(Status[player.ID].VehDamage);
		data.SendStream(player);
		RestoreDamage(player.ID, Status[player.ID].VehDamage)
	}
}

function RestoreDamage(player, dam)
{
	local player = FindPlayer(player)
	if(player)
	{
		dam--;
		local data = Stream();
		data.WriteString("Sprite");
		data.WriteString("wtf???");
		data.WriteString("");
		data.WriteString("");
		data.WriteInt(dam);
		data.SendStream(player);
		if(dam != 0) NewTimer("RestoreDamage", 25, 1, player.ID, dam);
	}
}

function Voice(player, string)
{
	local player = FindPlayer(player)
	if(player && string)
	{
		switch (string)
		{
			case "shuo ju hua":
			case "shuo hua":
			case "kuai shuo":
			PlaySoundForWorld(player.World, 50050);
			break;
			case "bai bai":
			case "bye":
			case "88":
			case "xia le":
			case "zai jian":
			PlaySoundForWorld(player.World, 50051);
			break;
			case "you ren ma":
			PlaySoundForWorld(player.World, 50053);
			break;
			case "lai le":
			case "lu shang":
			PlaySoundForWorld(player.World, 50054);
			break;
			case "mei you kai g":
			case "mei g":
			case "mei kai g":
			PlaySoundForWorld(player.World, 50055);
			break;
			case "nihao":
			case "ni hao":
			case "hello":
			case "halo":
			case "hi":
			PlaySoundForWorld(player.World, 50056);
			break;
			case"wo you":
			PlaySoundForWorld(player.World, 50062);
			break;
			case "nb":
			case "niu bi":
			case "niu p":
			case "li hai":
			case "lihai":
			case "ke yi":
			case "keyi":
			PlaySoundForWorld(player.World, 50063);
			break;
			case "mai qiang":
			PlaySoundForWorld(player.World, 50069);
			break;
			case "bie dong":
			PlaySoundForWorld(player.World, 50090);
			break;
		}
	}
}

function LubenweiWenhou(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		PlaySoundForPlayer(player, 50057);
		local id = player.ID;
		NewTimer("LubenweiWenhou", 1200000, 1, id);
	}
}

function FunPic(name, time)
{
	if(name && time)
	{
		local data = Stream();
		data.WriteString("Sprite");
		data.WriteString("qaq");
		data.WriteString("a"+name);
		data.SendStream(null);
		if(time != 99999999) NewTimer("DelFunPic", time, 1, name)
	}
}

function DelFunPic(name)
{
	if(name)
	{
		local data = Stream();
		data.WriteString("Sprite");
		data.WriteString("qaq");
		data.WriteString("r"+name);
		data.SendStream(null);
	}
}

function aaaaaa(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		if(Status[player.ID].Dontstop == true)
		{
			Status[player.ID].AAAAAAEffectLoop++;
			local qaq = 0;
			if(Status[player.ID].AAAAAAEffectLoop == 1) qaq = 1;
			else if(Status[player.ID].AAAAAAEffectLoop == 2) qaq = -1;
			else if(Status[player.ID].AAAAAAEffectLoop == 3) qaq = 2;
			else if(Status[player.ID].AAAAAAEffectLoop == 4) qaq = -2;
			else if(Status[player.ID].AAAAAAEffectLoop == 5) qaq = 3;
			else if(Status[player.ID].AAAAAAEffectLoop == 6) qaq = -3;
			else if(Status[player.ID].AAAAAAEffectLoop == 7) qaq = 2;
			else if(Status[player.ID].AAAAAAEffectLoop == 8) qaq = -2;
			else if(Status[player.ID].AAAAAAEffectLoop == 9) qaq = 1;
			else if(Status[player.ID].AAAAAAEffectLoop == 10)
			{
				qaq = -1;
				Status[player.ID].AAAAAAEffectLoop = 0;
			}
			local data = Stream();
			data.WriteString("Sprite")
			data.WriteString("aaaaaa");
			data.WriteString("");
			data.WriteString("");
			data.WriteInt(qaq);
			data.SendStream(player);
			NewTimer("aaaaaa", 50, 1, player.ID);
		}
		else
		{
			local data = Stream();
			data.WriteString("Sprite")
			data.WriteString("aaaaaastop!");
			data.SendStream(player);
		}
	}
}

function stoplease(player)
{
	local player = FindPlayer(player);
	if(player) Status[player.ID].Dontstop = false;
}

function PlayMusic(world, mid, posx, posy, posz) PlaySound(world, mid, Vector(posx, posy, posz));
function PlayMusicForPlayer(id, mid)
{
	if(FindPlayer(id)) PlaySoundForPlayer(FindPlayer(id), mid);
}
function PlayMusicForWorld(world, mid) PlaySoundForWorld(world, mid);

function GetOldData(player)
{
	local player = FindPlayer(player)
	if(player)
	{
		local cash = ReadIniInteger("Data/OldData/UserState.ini", "cash", player.Name)
		local bank = ReadIniInteger("Data/OldData/UserState.ini", "bank", player.Name)
		local team = ReadIniInteger("Data/OldData/UserState.ini", "team", player.Name)
		local skin = ReadIniInteger("Data/OldData/UserState.ini", "skin", player.Name)
		local level = ReadIniInteger("Data/OldData/UserState.ini", "level", player.Name)
		local kills = ReadIniInteger("Data/OldData/UserState.ini", "kills", player.Name)
		local deaths = ReadIniInteger("Data/OldData/UserState.ini", "deaths", player.Name)
		if(cash) player.Cash = cash, QuerySQL(Account, "UPDATE Account SET Cash='"+cash+"' WHERE Name='"+player.Name.tolower()+"'"), Announce("~g~You got your old data (ini).", player, 1);
		if(bank) QuerySQL(Account, "UPDATE Account SET Bank='"+bank+"' WHERE Name='"+player.Name.tolower()+"'")
		if(team) player.Team = team, QuerySQL(Account, "UPDATE Account SET Team='"+team+"' WHERE Name='"+player.Name.tolower()+"'")
		if(skin) player.Skin = skin, QuerySQL(Account, "UPDATE Account SET Skin='"+skin+"' WHERE Name='"+player.Name.tolower()+"'")
		if(level) QuerySQL(Account, "UPDATE Account SET Level='"+level+"' WHERE Name='"+player.Name.tolower()+"'")
		if(kills) QuerySQL(Account, "UPDATE Account SET Kills='"+kills+"' WHERE Name='"+player.Name.tolower()+"'")
		if(deaths) QuerySQL(Account, "UPDATE Account SET Deaths='"+deaths+"' WHERE Name='"+player.Name.tolower()+"'")
	}
}

function ccheckpoint(player)
{
	local player = FindPlayer(player)
	if(player && Status[player.ID].IsRacingAkina == true)
	{
		Status[player.ID].cpid++;
		QuerySQL( Akina, "INSERT INTO Checkpoint ( ID, PosX, PosY, PosZ ) VALUES ( '"+Status[player.ID].cpid+"', '"+player.Pos.x+"', '"+player.Pos.y+"', '"+player.Pos.z+"' )" );
		NewTimer("ccheckpoint", 150, 1, player.ID);
	}
}
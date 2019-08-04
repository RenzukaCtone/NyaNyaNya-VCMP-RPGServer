function onPlayerJoin( player )
{
	if ( player.Name.find("=") != null ) MessagePlayer("[#FF8000]    !Please don't use a name with [#00CCFF]''=''[#FF8000], otherwise the server will have some wrong QAQ", player), Message("*[#FFFAFA]  *<Auto-Kick: " + "[#FFFFFF]" + player.Name + "[#FFFAFA], Reason: [ Use a name with ''='']>*"), SText("Please don't use a name with ''=''"), KickPlayer(player);
	else
	{
		PlaySoundForWorld(0, 50065);
		if ( !QuerySQL( Account, "SELECT * FROM Account WHERE Name='" + player.Name.tolower() + "'" ) )
		{
			//local country = IpToCountry(player.IP);
			QuerySQL( Account, "INSERT INTO Account ( Language, Weapons, User, Password, Name, LastActive, Job, IP, WantedLevel, Team, Skin, PosZ, PosY, PosX, Level, Kills, HP, Exp, Deaths, Cash, Bank, AP ) VALUES ( 'Selecting', '100,1', '"+player.Name+"', '123', '"+player.Name.tolower()+"', 'null', 'None', '"+player.IP+"', '0', '0', '0', '"+player.Pos.z+"', '"+player.Pos.y+"', '"+player.Pos.x+"', '0', '0', '100', '0', '0', '2000', '2000', '0' )" );
			player.SetCameraPos( Vector( -1683.12, -1085.73, 22.0308 ), Vector( -1638.42, -918.336, 52.0308 ) );
			timeprint(player.Name + " 加入, ID:" + player.ID + ", IP:" + player.IP + ", 国家:"+"Unknown"+".")
			Message("[#FFFAFA]  *" + GetRGBCode( player.ID )+player.Name + "[#FFFAFA], [#FFFAFA]welcomeQAQ")
			MessagePlayer("[#FFFAFA]  *This is NyaNyaNya Real Life [#00E3E3]V2.0.123Beta[#FFFAFA], plugins version: [#00E3E3]04rel006[#FFFAFA].>*", player)
		}
		if ( !QuerySQL( Akina, "SELECT * FROM AkinaScore WHERE Name='" + player.Name.tolower() + "'" ) )
		{
			QuerySQL( Akina, "INSERT INTO AkinaScore ( User, Minute, Second, Name ) VALUES ( '"+player.Name+"', '99', '99', '"+player.Name.tolower()+"' )" );
		}
		if ( !QuerySQL( Account, "SELECT * FROM Banned WHERE Name='" + player.Name.tolower() + "'" ) )
		{
			QuerySQL( Account, "INSERT INTO Banned ( IsBanned, Time, BanTime, Reason, Name ) VALUES ( 'false', '0', 'null', 'null', '"+player.Name.tolower()+"' )" );
		}
		Check_MAC( player.ID );
		CheckBanned( player.ID );
		Status[player.ID] = PlayerClass();
		YSWorkMarker[player.ID] = null;
		DoctorSphere[player.ID] = null;
		ServerInfo(player.ID);
		Status[player.ID].IsLoaded = false;
		QAQInteresting();
		NewTimer("QAQInteresting", 800, 1);
		NewTimer("QAQInteresting", 1600, 1);
		NewTimer("LubenweiWenhou", 1200000, 1, player.ID);
		if( GetLevel(player.ID) >= 1 )
		{
			Status[player.ID].IsNew = false;
			if(GetSQLColumnData(QuerySQL(Account, "SELECT Password FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0)) Status[player.ID].IsNew = false;
			player.Skin = GetSQLColumnData(QuerySQL(Account, "SELECT Skin FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
			player.Cash = GetSQLColumnData(QuerySQL(Account, "SELECT Cash FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
			player.Health = GetSQLColumnData(QuerySQL(Account, "SELECT HP FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
			player.Armour = GetSQLColumnData(QuerySQL(Account, "SELECT AP FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
			player.SetWantedLevel(GetSQLColumnData(QuerySQL(Account, "SELECT WantedLevel FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0));
			TeamColor( player.ID );
			player.SetWeapon(100, 1);
			player.SetCameraPos( Vector( 545.243, -1742.35, 30.6455 ), Vector( 475.614, -1695.92, 47.2713 ) );
			//local country = IpToCountry(player.IP);
			timeprint(player.Name + " 加入, ID:" + player.ID + ", IP:" + player.IP + ", 国家:"+"Unknown"+".")
			Message("[#FFFAFA]  *" + GetRGBCode( player.ID )+player.Name + "[#FFFAFA]![#FFFAFA] is Coming Back!")
			MessagePlayer("[#FFFAFA]  *This is NyaNyaNya Real Life [#00E3E3]V2.0.123Beta[#FFFAFA], plugins version: [#00E3E3]04rel006[#FFFAFA].>*", player)
			Announce("~o~04rel~y~006 ~t~=w=", player, 1);
			if ( !GetSQLColumnData(QuerySQL(Account, "SELECT Level FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) ) QuerySQL(Account, "UPDATE Account SET Level='0' WHERE Name='"+player.Name.tolower()+"'");
			else player.Pos = Vector(-1513.53, -926.914, 19.862);
			SendLanguage(player.ID);
		}
	}
}

function onPlayerPart( player, reason )
{
	if ( player.Name.find("=") != null ) null
	else
	{
		YSWorkMarker[player.ID] = null;
		DoctorSphere[player.ID] = null;
		if(Status[player.ID].IsLoaded == true)
		{
			local Today = GetYear()+"-"+GetMonth()+"-"+GetDay();
			QuerySQL(Account, "UPDATE Account SET PosX='"+player.Pos.x+"', PosY='"+player.Pos.y+"', PosZ='"+player.Pos.z+"', Cash='"+player.Cash+"', HP='"+player.Health+"', AP='"+player.Armour+"', WantedLevel='"+player.WantedLevel+"', User='"+player.Name+"', Skin='"+player.Skin+"', LastActive='"+Today+"' WHERE Name='"+player.Name.tolower()+"'");
			SaveWeapon(player.ID);
			if (Status[player.ID].IsRacingAkina == true)
			{
				Status[player.ID].IsRacingAkina = false;
				SText("~g~Akina Misson Faild!", player.ID, 6);
				timeprint(player.Name + " 退出秋名山比赛");
				TimerEnd(player.ID);
			}
		}
		if ( reason == 0 ) timeprint(player.Name + " 因超时而退出服务器"), Message("[#FFFAFA]  *<" + GetRGBCode( player.ID )+player.Name + " [#FFFAFA]quit[#00E3E3](time out)[#FFFAFA].>*");
		else if ( reason == 1 ) timeprint(player.Name + " 退出服务器"), Message("[#FFFAFA]  *<" + GetRGBCode( player.ID )+player.Name + " [#FFFAFA]quit[#FFFAFA].>*");
		else if ( reason == 2 ) timeprint(player.Name + " 被强制退出服务器"), Message("[#FFFAFA]  *<" + GetRGBCode( player.ID )+player.Name + " [#FFFAFA]quit[#00E3E3](Unknown reasons)[#FFFAFA]>*");
		else if ( reason == 3 && player.Ping < 650 ) timeprint(player.Name + " 因崩溃而退出服务器"), Message("[#FFFAFA]  *<" + GetRGBCode( player.ID )+player.Name + " [#FFFAFA]quit[#00E3E3](crash)[#FFFAFA]>*");
		else if ( player.Ping > 650 || reason == "highping" ) timeprint(player.Name + " 因ping值过高(>650ms)而被强制退出服务器"), Message("[#FFFAFA]  *<Auto-Kick - " + GetRGBCode( player.ID ) + player.Name + " 's ping is higher than 650 ms>*"), KickPlayer(player)
		else if ( reason == 2 && player.Armour ) return 0;
		PlaySoundForWorld(0, 50061);
		Status[player.ID] = null;
	}
}

function onPlayerRequestClass( player, classID, team, skin )
{
	if ( player.Name.find("=") != null ) null
	else
	{
		SendPacketToClient( player, "Sprite", "addtip");
		NewTimer("SendIDPacketToClient", 4000, 1, player.ID, "Sprite", "RemoveTip");
		PlaySound( player.World , 357 , player.Pos );
		Status[player.ID].IsLoaded = true;
		player.SetCameraPos( Vector( -1683.12, -1085.73, 22.0308 ), Vector( -1638.42, -918.336, 52.0308 ) );
		local isregister = false;
		if(GetLevel(player.ID) >= 1) isregister = true;
		if( isregister == false )
		{
			QuerySQL(Account, "UPDATE Account SET Language='Selecting' WHERE Name='"+player.Name.tolower()+"'");
			SendPacketToClient( player, "Sprite", "addlang" );
			SendPacketToClient( player, "Sprite", "removead" );
			Status[player.ID].CanTeleport = false;
			MessagePlayer("[#FFFAFA]  *Please [#00E3E3]Register[#FFFAFA] first~", player)
			MessagePlayer("[#FFFAFA]  *Type [#00E3E3]/register <password>[#FFFAFA] and Enter to register~",player)
			Announce("~o~Register ~t~First", player, 0);
			Announce("~o~04rel~y~006 ~t~=w=", player, 1);
			Announce("~o~/register~y~ password", player, 7);
			return 1;
		}
		else
		{
			player.Spawn();
			return 0;
		}
	}
}

function onPlayerRequestSpawn( player )
{
	if ( player.Name.find("=") != null ) null
	else
	{
		PlaySound( player.World , 357 , player.Pos );
		Status[player.ID].IsLoaded = true;
		if ( GetSQLColumnData(QuerySQL(Account, "SELECT Language FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) == "Selecting" )
		{
			LangText("[#FF8000]    !Ni Hai'mei'you [#FF8000]Xuan'ze Yu'yan","[#FF8000]    !You haven't chose your language yet...",player.ID, false);
			return 0;
		}
		else if ( GetLevel(player.ID) >= 1 ) return 1;
		else
		{
			LangText("[#FF8000]    !Ni Hai'mei'you [#FF8000]Zhu Ce!","[#FF8000]    !You haven't Registered yet...",player.ID, false);
			return 0;
		}
	}
}

function onPlayerSpawn( player )
{
	if ( player.Name.find("=") != null ) null
	else
	{
		player.SetWeapon(100, 1);
		RestoreCamera(player.ID);
		player.Widescreen = false;
		MessagePlayer("[#FFFAFA]  *Try pressing [#00E3E3]F2 [#FFFAFA]to know how to play =w=",player);
		SendPacketToClient( player, "Sprite", "addplay");
		NewTimer("SendIDPacketToClient", 4321, 1, player.ID, "Sprite", "RemovePlay");
		PlaySound( player.World, 50000, player.Pos );
		player.SetDrunkLevel( 0, 0);
		player.IsFrozen = false;
		IsNewHere( player.ID );
		PosTeleport( player.ID );
		CheckRegister( player.ID );
		CheckLogin( player.ID );
		TeamColor( player.ID );
		GetOwnWeapon(player.ID);
		NewTimer("PlayMusicForPlayer", 500, 1, player.ID, 50006);
	}
}

function onPlayerDeath( player, reason )
{
	if ( player.Name.find("=") != null ) null
	else
	{
		PlaySoundForPlayer(player, random(50100, 50102));
		PlaySound( player.World , 335 , player.Pos );
		player.Widescreen = true;
		SaveWeapon(player.ID);
		Status[player.ID].Dontstop = true;
		aaaaaa(player.ID);
		local id = player.ID;
		NewTimer("stoplease", 3333, 1, id);
		Announce("~g~aaa--ikuikuiku...", player, 1)
		if (Status[player.ID].IsRacingAkina == true)
		{
			Status[player.ID].IsRacingAkina = false;
			SText("~g~Akina Misson Faild!", player.ID, 6);
			timeprint(player.Name + " 终止秋名山任务 =w=");
			TimerEnd(player.ID);
		}
		local Text, CNText;
		if (reason==70) Text="[#FFFAFA]   *<"+GetRGBCode( player.ID )+player.Name+" [#FF4500]committed suicide[#FFFAFA]>*", CNText = " 使用了/kill指令.",Message(Text),timeprint(player.Name + " " + CNText + "");
		else if (reason==39)
		{
			if(Status[player.ID].IsBuyingPizza == true) Text="[#FFFAFA]   *<"+GetRGBCode( player.ID )+player.Name+" [#B22222]died because of eating too much 233[#FFFAFA]>*", CNText = " 撑得受不了了.",Message(Text),timeprint(player.Name + " " + CNText + "");
			else Text="[#FFFAFA]   *<"+GetRGBCode( player.ID )+player.Name+" [#B22222]died in a car crash[#FFFAFA]>*", CNText = " 在车中受到重伤.",Message(Text),timeprint(player.Name + " " + CNText + "");
		}
		else if (reason==31) Text="[#FFFAFA]   *<"+GetRGBCode( player.ID )+player.Name+" [#B22222]burned to death[#FFFAFA]>*", CNText = " 被高温燃烧至重伤.",Message(Text),timeprint(player.Name + " " + CNText + "");
		else if (reason==14) Text="[#FFFAFA]   *<"+GetRGBCode( player.ID )+player.Name+" [#A9A9A9]choked to death[#FFFAFA]>*", CNText = " 哽咽窒息.",Message(Text),timeprint(player.Name + " " + CNText + "");
		else if (reason==43) Text="[#FFFAFA]   *<"+GetRGBCode( player.ID )+player.Name+" [#20B2AA]drowned[#FFFAFA]>*", CNText = " 溺水.",Message(Text),timeprint(player.Name + " " + CNText + "");
		else if (reason==41 || reason==51) Text="[#FFFAFA]  *<"+GetRGBCode( player.ID )+player.Name+" [#FF4500]exploded[#FFFAFA]>*", CNText = " 因爆炸而受到重伤.",Message(Text),timeprint(player.Name + " " + CNText + "");
		else if (reason==44) Text="[#FFFAFA]  *<"+GetRGBCode( player.ID )+player.Name+" [#FFE4C4]fell to death[#FFFAFA]>*", CNText = " 摔出重伤.",Message(Text),timeprint(player.Name + " " + CNText + "");
		else Text="[#FFFAFA]  *<"+GetRGBCode( player.ID )+player.Name+" [#F5F5F5]died for...I don't know233[#FFFAFA]>*", CNText = " 重伤,因为...好吧我也不知道233 =w=",Message(Text),timeprint(player.Name + " " + CNText + "");
	}
}

function onPlayerKill( player, killer, reason, bodypart )
{
	PlaySound( player.World , 357 , player.Pos );
	killer.Widescreen = true;
	SaveWeapon(player.ID);
	SaveWeapon(killer.ID);
	if (Status[killer.ID].IsRacingAkina == true)
	{
		Status[killer.ID].IsRacingAkina = false;
		SText("~g~Akina Misson Faild!", killer.ID, 6);
		timeprint(killer.Name + " 终止秋名山任务 =w=");
		TimerEnd(killer.ID);
	}
	Announce("~g~Kill! +$500", player, 1);
	player.Cash += 500;
	local wantedLevel = player.WantedLevel.tointeger(), wantedLevelp = killer.WantedLevel.tointeger();
	if ( wantedLevel < 6 ) player.SetWantedLevel(wantedLevel+1);
	if ( wantedLevelp > 0 ) killer.SetWantedLevel(wantedLevelp-1);
	if (reason == 14 || reason == 31 || reason == 39 || reason == 40 || reason == 41 || reason == 44 || reason == 51) Message("[#FFFAFA]   *<" + GetRGBCode( player.ID ) + player.Name + "[#FFFAFA] killed " + GetRGBCode( killer.ID )+killer.Name + " [#FFFAFA]with [#00E3E3] " + GetWeaponName(reason) + "[#FFFAFA]>*"), timeprint(player.Name + " 使用" + GetWeaponName(reason) + " 攻击" + killer.Name + " 使其受到重伤")
	else Message("[#FFFAFA]   *<" + GetRGBCode( player.ID ) + player.Name + "[#FFFAFA] killed " + GetRGBCode( killer.ID ) + killer.Name + "[#FFFAFA] with a [#00E3E3]" + GetWeaponName(reason) + " [#FF4500]" + GetBodyPartName(bodypart) + "[#FFFAFA]>*"), timeprint(player.Name + " 使用" + GetWeaponName(reason) + " 攻击" + killer.Name + " 的" + GetBodyPartCNName(bodypart) + " 使其受到重伤")
	local lastKills = GetSQLColumnData(QuerySQL(Account, "SELECT Kills FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
	QuerySQL(Account, "UPDATE Account SET Kills='"+(lastKills+1)+"' WHERE Name='"+player.Name.tolower()+"'")
	local lastDeaths = GetSQLColumnData(QuerySQL(Account, "SELECT Deaths FROM Account WHERE Name='"+killer.Name.tolower()+"'"), 0);
	QuerySQL(Account, "UPDATE Account SET Deaths='"+(lastDeaths+1)+"' WHERE Name='"+killer.Name.tolower()+"'")
	local Kills = lastKills+1;
	local Deaths = GetSQLColumnData(QuerySQL(Account, "SELECT Deaths FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);;
	Announce("~g~Kills: ~y~"+Kills+" ~g~Deaths "+Deaths, player, 0);
	local Killsp = GetSQLColumnData(QuerySQL(Account, "SELECT Kills FROM Account WHERE Name='"+killer.Name.tolower()+"'"), 0);
	local Deathsp = lastDeaths+1;
	Announce("~g~Kills: "+Killsp+" ~g~Deaths ~y~"+Deathsp, killer, 0);
	IncExp(player.ID, 5);
	PlaySoundForPlayer(player, random(50058, 50060));
	PlaySoundForPlayer(killer, random(50100, 50102));
	Status[killer.ID].Dontstop = true;
	aaaaaa(killer.ID);
	local id = killer.ID;
	NewTimer("stoplease", 3333, 1, id);
	Announce("~g~aaa--ikuikuiku...", killer, 1)
}

function onPlayerTeamKill( player, killer, reason, bodypart )
{
	PlaySound( player.World , 357 , player.Pos );
	killer.Widescreen = true;
	SaveWeapon(player.ID);
	SaveWeapon(killer.ID);
	if (Status[killer.ID].IsRacingAkina == true)
	{
		Status[killer.ID].IsRacingAkina = false;
		SText("~g~Akina Misson Faild!", killer.ID, 6);
		timeprint(killer.Name + " 终止秋名山任务 =w=");
		TimerEnd(killer.ID);
	}
	Announce("~g~Kill! +$500", player, 1);
	player.Cash += 500;
	local wantedLevel = player.WantedLevel.tointeger(), wantedLevelp = killer.WantedLevel.tointeger();
	if ( wantedLevel < 6 ) player.SetWantedLevel(wantedLevel+1);
	if ( wantedLevelp > 0 ) killer.SetWantedLevel(wantedLevelp-1);
	if (reason == 14 || reason == 31 || reason == 39 || reason == 40 || reason == 41 || reason == 44 || reason == 51) Message("[#FFFAFA]   *<" + GetRGBCode( player.ID ) + player.Name + "[#FFFAFA] killed " + GetRGBCode( killer.ID )+killer.Name + " [#FFFAFA]with [#00E3E3] " + GetWeaponName(reason) + "[#FFFAFA]>*"), timeprint(player.Name + " 使用" + GetWeaponName(reason) + " 攻击" + killer.Name + " 使其受到重伤")
	else Message("[#FFFAFA]   *<" + GetRGBCode( player.ID ) + player.Name + "[#FFFAFA] killed " + GetRGBCode( killer.ID ) + killer.Name + "[#FFFAFA] with a [#00E3E3]" + GetWeaponName(reason) + " [#FF4500]" + GetBodyPartName(bodypart) + "[#FFFAFA]>*"), timeprint(player.Name + " 使用" + GetWeaponName(reason) + " 攻击" + killer.Name + " 的" + GetBodyPartCNName(bodypart) + " 使其受到重伤")
	local lastKills = GetSQLColumnData(QuerySQL(Account, "SELECT Kills FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
	QuerySQL(Account, "UPDATE Account SET Kills='"+(lastKills+1)+"' WHERE Name='"+player.Name.tolower()+"'")
	local lastDeaths = GetSQLColumnData(QuerySQL(Account, "SELECT Deaths FROM Account WHERE Name='"+killer.Name.tolower()+"'"), 0);
	QuerySQL(Account, "UPDATE Account SET Deaths='"+(lastDeaths+1)+"' WHERE Name='"+killer.Name.tolower()+"'")
	local Kills = lastKills+1;
	local Deaths = GetSQLColumnData(QuerySQL(Account, "SELECT Deaths FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);;
	Announce("~g~Kills: ~y~"+Kills+" ~g~Deaths "+Deaths, player, 0);
	local Killsp = GetSQLColumnData(QuerySQL(Account, "SELECT Kills FROM Account WHERE Name='"+killer.Name.tolower()+"'"), 0);
	local Deathsp = lastDeaths+1;
	Announce("~g~Kills: "+Killsp+" ~g~Deaths ~y~"+Deathsp, killer, 0);
	IncExp(player.ID, 5);
	PlaySoundForPlayer(player, random(50058, 50060));
	PlaySoundForPlayer(killer, random(50100, 50102));
	Status[killer.ID].Dontstop = true;
	aaaaaa(killer.ID);
	local id = killer.ID;
	NewTimer("stoplease", 3333, 1, id);
	Announce("~g~aaa--ikuikuiku...", killer, 1)
}

function onPlayerMove( player, lastX, lastY, lastZ, newX, newY, newZ )
{
}

function onPlayerHealthChange( player, lastHP, newHP )
{
	if ( lastHP > newHP ) Announce("~r~-" + ( lastHP - newHP ) + "s!", player, 1), PlaySoundForPlayer(player, random(50003, 50005));
	if ( newHP < 20 ) PlaySound(player.World, 50064, player.Pos);
}

function onPlayerArmourChange( player, lastArmour, newArmour )
{
	if ( lastArmour > newArmour ) Announce("~h~-" + ( lastArmour - newArmour ) + "AP!", player, 1), PlaySoundForPlayer(player, random(50003, 50005));
}

function onPlayerWeaponChange( player, oldWep, newWep )
{
}

function onPlayerCrashDump(player, report)
{
	TXTAddLine("crashes/" + GetFullTime().tostring() + "_" + player.Name + ".log", report);
}

function onKeyDown( player, key )
{
	if ( player.Name.find("=") == 0 ) null
	else
	{
		if( key == F2 ) SendPacketToClient( player, "Sprite", "AddHelp" );
		else if( key == Ctrl )
		{
			if(Status[player.ID].NearPlr != null)
			{
				Status[player.ID].IsLookingMenu = true;
				SendPacketToClient( player, "Sprite", "RemoveMenuTip" );
				SendPacketToClient( player, "Sprite", "AddMenu" );
			}
		}
		else if( key == LShift || key == RShift )
		{
			if (Status[player.ID].IsBuyingVehicle == true && player.Vehicle) BuyVehicle( player.ID, player.Vehicle.ID );
			else if (Status[player.ID].IsBuyingWeapon == true) BuyWeapon( player.ID );
			else if (Status[player.ID].IsBuyingClothes == true) BuyClothes( player.ID );
			else if (Status[player.ID].IsBuyingPizza == true) EatPizza( player.ID );
			else if (Status[player.ID].IsBuyingRCGHotelticket == true) null;
			else if (Status[player.ID].IsEnteringVRS1 == true && player.Vehicle)
			{
				if(Status[player.ID].ViewVehicleColor == 2) VehicleFix( player.ID, VehicleFix1.ID );
				else Status[player.ID].ViewVehicleColor = 2, ChoosingVehicleCol2(player.ID)
			}
			else if (Status[player.ID].IsEnteringVRS2 == true && player.Vehicle)
			{
				if(Status[player.ID].ViewVehicleColor == 2) VehicleFix( player.ID, VehicleFix1.ID );
				else Status[player.ID].ViewVehicleColor = 2, ChoosingVehicleCol2(player.ID)
			}
			else if (Status[player.ID].IsStealingHotel == true) StealHotel( player.ID );
			else if (Status[player.ID].IsHealing == true && Status[player.ID].WheretoHeal && Status[player.ID].WheretoHeal != "None")
			{
				if(FindPlayer(Status[player.ID].WheretoHeal))
				{
					Progress(player.ID, 3000);
					NewTimer("HealPlayer", 3000, 1, player.ID, FindPlayer(Status[player.ID].WheretoHeal).ID);
				}
			}
			else if (Status[player.ID].IsBuyingHotelticket == true)
			{
				SText("~y~You bought ~g~Hotelticket~y~!", player.ID, 7);
				SText("", player.ID, 1);
				player.Cash -= 2980;
				Status[player.ID].CanPutup = true;
			}
			//Team
			else if ( Status[player.ID].ViewTeam == 1 )
			{
				player.Cash -= 25000;
				QuerySQL(Account, "UPDATE Account SET Team='1' WHERE Name='"+player.Name.tolower()+"'");
				player.Widescreen = true;
				player.IsFrozen = true;
				SText("Radiances Cage Get", player.ID, 7);
				SText("Welcome to join RCG Team!", player.ID, 1 );
				player.SetCameraPos( Vector( -378.898, -501.84, 29.3649 ), Vector( -378.898, -540.84, 22.3649 ) );
				player.Team = 1;
				TeamColor(player.ID);
				Message("[#FFFAFA]  *<" + GetRGBCode(player.ID) + player.Name + " join the team [#00E3E3]RCG [#00DB00]=w=>*");
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				PlaySound( player.World , 359 , player.Pos );
				IncExp(player.ID, 1);
			}
			else if ( Status[player.ID].ViewTeam == 2 )
			{
				player.Cash -= 30000;
				QuerySQL(Account, "UPDATE Account SET Team='2' WHERE Name='"+player.Name.tolower()+"'");
				player.Widescreen = true;
				player.IsFrozen = true;
				SText("Missile Viper Performance", player.ID, 7 );
				SText("Welcome to join MVPchina Team!", player.ID, 1 );
				player.SetCameraPos( Vector( 601.0229, 933.2081, 100.9907 ), Vector( 946.1308 318.3987 395.1787 ) );
				player.Team = 2;
				TeamColor(player.ID);
				Message("[#FFFAFA]  *<" + player.Name + " join the team [#00E3E3]MVPchina [#FFFAFA]=w=>*");
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				PlaySound( player.World , 359 , player.Pos );
			}
			else if ( Status[player.ID].ViewTeam == 3 )
			{
				player.Cash -= 15000;
				QuerySQL(Account, "UPDATE Account SET Team='3' WHERE Name='"+player.Name.tolower()+"'");
				player.Widescreen = true;
				player.IsFrozen = true;
				SText("- Lighthouse -", player.ID, 7 );
				SText("Welcome to join the team Lighthouse!", player.ID, 1 );
				player.SetCameraPos( Vector( 517.041, -1764.31, 80.0212 ), Vector( 456.879, -1718.1, 25.0212 ) );
				player.Team = 3;
				TeamColor(player.ID);
				Message("[#FFFAFA]  *<" + player.Name + " join the team [#00E3E3]Lighthouse [#FFFAFA]=w=>*");
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				PlaySound( player.World , 359 , player.Pos );
			}
			else if ( Status[player.ID].ViewTeam == 4 )
			{
				player.Cash -= 30000;
				QuerySQL(Account, "UPDATE Account SET Team='4' WHERE Name='"+player.Name.tolower()+"'");
				player.Widescreen = true;
				player.IsFrozen = true;
				SText("- Shipyard -", player.ID, 7 );
				SText("Welcome to join the team Shipyard!", player.ID, 1 );
				player.SetCameraPos( Vector( -753.558, -1226.64, 50.0834 ), Vector( -682.242, -1268.58, 30.4434 ) );
				player.Team = 4;
				TeamColor(player.ID);
				Message("[#FFFAFA]  *<" + player.Name + " join the team [#00E3E3]Shipyard [#FFFAFA]=w=>*");
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				PlaySound( player.World , 359 , player.Pos );
			}
			else if ( Status[player.ID].ViewTeam == 5 )
			{
				player.Cash -= 25000;
				QuerySQL(Account, "UPDATE Account SET Team='5' WHERE Name='"+player.Name.tolower()+"'");
				player.Widescreen = true;
				player.IsFrozen = true;
				SText("- Malibu Club -", player.ID, 7 );
				SText("Welcome to join the team Malibu Club!", player.ID, 1 );
				player.SetCameraPos( Vector( 486.715, -114.824, 13.8407 ), Vector( 490.096, -83.0989, 12.8407 ) );
				player.Team = 5;
				TeamColor(player.ID);
				Message("[#FFFAFA]  *<" + player.Name + " join the team [#00E3E3]Malibu Club [#FFFAFA]=w=>*");
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				PlaySound( player.World , 359 , player.Pos );
			}
			else if ( Status[player.ID].ViewTeam == 6 )
			{
				player.Cash -= 35000;
				QuerySQL(Account, "UPDATE Account SET Team='6' WHERE Name='"+player.Name.tolower()+"'");
				QuerySQL(Account, "UPDATE Account SET Job='police' WHERE Name='"+player.Name.tolower()+"'");
				player.Widescreen = true;
				player.IsFrozen = true;
				SText("- Washington Police Station -", player.ID, 7 );
				SText("Welcome to join the Police!", player.ID, 1 );
				player.SetCameraPos( Vector( 413.14, -449.255, 14.8714 ), Vector( 396.019, -472.771, 12.1956 ) );
				player.Team = 6;
				TeamColor(player.ID);
				Message("[#FFFAFA]  *<" + player.Name + " join the team [#00E3E3]Washington Police [#FFFAFA]=w=>*");
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				PlaySound( player.World , 359 , player.Pos );
			}
			else if ( Status[player.ID].ViewTeam == 7 )
			{
				player.Cash -= 40000;
				QuerySQL(Account, "UPDATE Account SET Team='7' WHERE Name='"+player.Name.tolower()+"'");
				QuerySQL(Account, "UPDATE Account SET Job='police' WHERE Name='"+player.Name.tolower()+"'");
				player.Widescreen = true;
				player.IsFrozen = true;
				SText("- Downtown Police Station -", player.ID, 7 );
				SText("Welcome to join the Police!", player.ID, 1 );
				player.SetCameraPos( Vector(  -693.401, 727.931, 39.9938 ), Vector( -661.861, 757.881, 21.9938 ) );
				player.Team = 7;
				TeamColor(player.ID);
				Message("[#FFFAFA]  *<" + player.Name + " join the team [#00E3E3]Downtown Police [#FFFAFA]=w=>*");
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				PlaySound( player.World , 359 , player.Pos );
			}
			else if ( Status[player.ID].ViewTeam == 8 )
			{
				player.Cash -= 50000;
				QuerySQL(Account, "UPDATE Account SET Team='8' WHERE Name='"+player.Name.tolower()+"'");
				QuerySQL(Account, "UPDATE Account SET Job='army' WHERE Name='"+player.Name.tolower()+"'");
				player.Widescreen = true;
				player.IsFrozen = true;
				SText("- Army -", player.ID, 7 );
				SText("Welcome to join the team Army!", player.ID, 1 );
				player.SetCameraPos( Vector(  -1724.67, -329.174, 36.2785 ), Vector( -1720.94, -260.895, 29.2785 ) );
				player.Team = 8;
				TeamColor(player.ID);
				Message("[#FFFAFA]  *<" + player.Name + " join the team [#00E3E3]Army [#FFFAFA]=w=>*");
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				PlaySound( player.World , 359 , player.Pos );
			}
			else if ( Status[player.ID].ViewTeam == 9 )
			{
				player.Cash -= 20000;
				QuerySQL(Account, "UPDATE Account SET Team='9' WHERE Name='"+player.Name.tolower()+"'");
				player.Widescreen = true;
				player.IsFrozen = true;
				SText("- Hotel -", player.ID, 7 );
				SText("Welcome to join the team Hotelman", player.ID, 1 );
				player.SetCameraPos( Vector( 246.808, -1296.91, 23.8133 ), Vector( 233.72, -1278.25, 16.6947 ) );
				player.Team = 9;
				TeamColor(player.ID);
				Message("[#FFFAFA]  *<" + player.Name + " join the team [#00E3E3]Hotel [#FFFAFA]=w=>*");
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				PlaySound( player.World , 359 , player.Pos );
			}
			else if (Status[player.ID].ViewJob == "doctor")
			{
				player.Cash -= 6000;
				QuerySQL(Account, "UPDATE Account SET Job='doctor' WHERE Name='"+player.Name.tolower()+"'");
				player.SetCameraPos( Vector( -846.092, -470.971, 29.0849 ), player.Pos );
				NewTimer( "RestoreCamera", 3000, 1, player.ID );
				Announce("~r~You are doctor now! Press E in a ambulance to heal other player =w =", player, 1)
				MessagePlayer("[#00DB00]    >You are doctor now! Press [#00CCFF]E[#00DB00] in a ambulance to heal other player~", player)
				PlaySound(player.World, 50005, player.Pos);
			}
		}

		else if ( key == Backspace )
		{
			if (Status[player.ID].IsBuyingVehicle == true && player.Vehicle) ExitVehicleShop( player.ID, player.Vehicle.ID );
			else if (Status[player.ID].IsBuyingWeapon == true) ExitWeaponShop( player.ID );
			else if (Status[player.ID].IsBuyingClothes == true) ExitClothesShop( player.ID ), player.Skin = GetSQLColumnData(QuerySQL(Account, "SELECT Skin FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
			else if (Status[player.ID].IsEnteringVRS1 == true && player.Vehicle) Status[player.ID].IsEnteringVRS1 = false, player.Vehicle.Colour1 = Status[player.ID].VehicleCol1, player.Vehicle.Colour2 = Status[player.ID].VehicleCol2, RestoreCamera(player.ID), DVehicleFix1.MoveTo( Vector(-874.696, -116.696, 15.9875), 3000 );
			else if (Status[player.ID].IsEnteringVRS2 == true && player.Vehicle) Status[player.ID].IsEnteringVRS2 = false, player.Vehicle.Colour1 = Status[player.ID].VehicleCol1, player.Vehicle.Colour2 = Status[player.ID].VehicleCol2, RestoreCamera(player.ID), DVehicleFix2.MoveTo( Vector(-7.80468, -1257.64, 15.8187), 3000 );
			else if (Status[player.ID].IsLookingMenu == true) Status[player.ID].IsLookingMenu = false, SendPacketToClient( player, "Sprite", "RemoveMenu" );
			else if (Status[player.ID].IsReady == true && Status[player.ID].IsReady2 == false) Status[player.ID].IsReady = false, RestoreCamera(player.ID), PlaySound(player.World, 50002, player.Pos);
		}
		else if (key == Space)
		{
			if (Status[player.ID].IsReady == true && Status[player.ID].IsRacingAkina == false && player.Vehicle) Status[player.ID].IsReady2 = true, StartAkinaRacing(player.ID), Announce("~y~Get Ready!", player, 1);
		}
	}
}

function onKeyUp( player, key )
{
	if ( player.Name.find("=") == 0 ) null
	else
	{
		if( key == F2 ) SendPacketToClient( player, "Sprite", "RemoveHelp" );
		else if( key == L )
		{
			if ( !player.Vehicle ) null;
			else
			{
				PlaySound( player.World , 357 , player.Pos );
				PlaySound( player.World , 357 , player.Pos );
				if (player.Vehicle.Lights == true ) SText("~y~Vehicle Lights ~g~OFF", player.ID, 0), player.Vehicle.Lights = false;
				else if ( player.Vehicle.Lights == false ) SText("~g~Vehicle Lights ~y~ON", player.ID, 0), player.Vehicle.Lights = true;
			}
		}
		else if( key == C )
		{
			if ( GetSQLColumnData(QuerySQL(Account, "SELECT Language FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) == "Selecting" )
			{
				PlaySound(player.World, 50005, player.Pos);
				QuerySQL(Account, "UPDATE Account SET Language='Chinese' WHERE Name='"+player.Name.tolower()+"'");
				player.IsFrozen = false;
				SendPacketToClient( player, "Sprite", "RemoveLang" );
				SendPacketToClient( player, "Sprite", "RemoveLangsbg" );
				MessagePlayer("[#00DB00]    >[#00E3E3]Chinese [#FFFAFA]=w=", player);
				SendLanguage(player.ID);
				if (GetSQLColumnData(QuerySQL(Account, "SELECT Level FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) == 0)
				{
					SendPacketToClient( player, "Sprite", "RemoveLang" );
					local data = Stream();
					data.WriteString( "Sprite" );
					data.WriteString( "AddReg" );
					data.WriteString( player.Name );
					data.SendStream( player );
				}
			}
		}
		else if( key == E )
		{
			local job = GetSQLColumnData(QuerySQL(Account, "SELECT Job FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0)
			if ( GetSQLColumnData(QuerySQL(Account, "SELECT Language FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) == "Selecting" )
			{
				PlaySound(player.World, 50005, player.Pos);
				QuerySQL(Account, "UPDATE Account SET Language='English' WHERE Name='"+player.Name.tolower()+"'");
				player.IsFrozen = false;
				SendPacketToClient( player, "Sprite", "RemoveLang" );
				SendPacketToClient( player, "Sprite", "RemoveLangsbg" );
				MessagePlayer("[#00DB00]    >[#00E3E3]English [#FFFAFA]=w=", player);
				SendLanguage(player.ID);
				if (GetSQLColumnData(QuerySQL(Account, "SELECT Level FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) == 0)
				{
					SendPacketToClient( player, "Sprite", "RemoveLang" );
					local data = Stream();
					data.WriteString( "Sprite" );
					data.WriteString( "AddReg" );
					data.WriteString( player.Name );
					data.SendStream( player );
				}
			}
			if(job)
			{
				if(job.tolower() == "doctor" && player.Vehicle && player.Vehicle.Model == 146)
				{
					if(DoctorSphere[player.ID] == null && Status[player.ID].IsWorking == false)
					{
						PlaySound( player.World , 357 , player.Pos );
						DoctorSphere[player.ID] = CreateCheckpoint( null, 0, true, player.Pos, RGB(255, 128, 192), 7);
						player.IsFrozen = true;
						Status[player.ID].IsWorking = true;
						WriteIniString("Data/Sphere.ini", "SphereID", DoctorSphere[player.ID].ID.tostring(), player.Name );
						Announce("~p~Now! You can heal others!", player, 1)
						Announce("Ambulance Misson", player, 7)
					}
					else
					{
						PlaySound( player.World , 357 , player.Pos );
						player.IsFrozen = false;
						Status[player.ID].IsWorking = false;
						WriteIniString("Data/Sphere.ini", "SphereID", DoctorSphere[player.ID].ID.tostring(), "None");
						DoctorSphere[player.ID].Remove();
						DoctorSphere[player.ID] = null;
						Announce("~p~Now, You can't heal others...", player, 1)
					}
				}
			}
		}
		else if( key == A || key == Left || key == Up )
		{
			if (Status[player.ID].IsBuyingWeapon == true) Status[player.ID].ViewWeapon -= 1, ChoosingWeapon(player.ID, null, null ,null);
			else if (Status[player.ID].IsBuyingClothes == true) Status[player.ID].ViewClothes -= 1, ChoosingClothes(player.ID);
			else if (Status[player.ID].IsEnteringVRS1 == true || Status[player.ID].IsEnteringVRS2 == true)
			{
				if(player.Vehicle)
				{
					if(Status[player.ID].ViewVehicleColor == 1) Status[player.ID].ViewVehicleCol1 -= 1, ChoosingVehicleCol1(player.ID);
					else if(Status[player.ID].ViewVehicleColor == 2) Status[player.ID].ViewVehicleCol2 -= 1, ChoosingVehicleCol2(player.ID);
				}
			}
		}
		else if( key == D || key == Right || key == Down )
		{
			if (Status[player.ID].IsBuyingWeapon == true) Status[player.ID].ViewWeapon += 1, ChoosingWeapon(player.ID, null, null ,null);
			else if (Status[player.ID].IsBuyingClothes == true) Status[player.ID].ViewClothes += 1, ChoosingClothes(player.ID);
			else if (Status[player.ID].IsEnteringVRS1 == true || Status[player.ID].IsEnteringVRS2 == true)
			{
				if(player.Vehicle)
				{
					if(Status[player.ID].ViewVehicleColor == 1) Status[player.ID].ViewVehicleCol1 += 1, ChoosingVehicleCol1(player.ID);
					else if(Status[player.ID].ViewVehicleColor == 2) Status[player.ID].ViewVehicleCol2 += 1, ChoosingVehicleCol2(player.ID);
				}
			}
		}
		else if(key == Alt || key == LMB)
		{
			if( player.Alpha == 254 && player.Vehicle && Status[player.ID].IsWorking == false) PlaySound( player.World , 357 , player.Pos ), PlaySound( player.World , 357 , player.Pos ), Announce("~g~Starting Vehicle...", player, 1), NewTimer("SText", 600, 1, "~y~Done!", player.ID, 1), NewTimer("RestoreCamera", 600, 1, player.ID), player.SetAlpha( 255, 1);
		}
	}
}

function onPlayerActionChange( player, oldAction, newAction )
{
}

function onPlayerEnteringVehicle( player, vehicle, door )
{
	if(GetVehicleType( vehicle.Model ) == "Heli" || GetVehicleType( vehicle.Model ) == "Plane") vehicle.Locked = true;
	PlaySoundForPlayer(player, 50007);
	PlaySoundForPlayer(player, 50105);
	Announce("~y~sou de su ne", player, 1);
	return 1;
}

function onPlayerEnterVehicle( player, vehicle, door )
{
	PlaySoundForPlayer(player, 50005);
	if(GetVehicleType( vehicle.Model ) == "Heli" || GetVehicleType( vehicle.Model ) == "Plane") vehicle.Locked = true. player.Pos = player.Pos;
	VehicleSpeed(player.ID)
	Status[player.ID].VehicleCol1 = player.Vehicle.Colour1;
	Status[player.ID].VehicleCol2 = player.Vehicle.Colour2;
	if(vehicle.Driver && vehicle.Driver.ID == player.ID)
	{
		//vehicle.SetHandlingData(14, 0);
		player.IsFrozen = true;
		player.SetAlpha( 254, 1 )
		Announce("~g~Press ~y~LMB or ALT ~g~to start!", player, 1);
		//SendPacketToClient()
		if (GetSQLColumnData(QuerySQL(World, "SELECT Owner FROM WorldVehicle WHERE VehID='"+player.Vehicle.ID+"'"), 0) != player.Name.tolower())
		{
			vehicle.Alarm = true;
			NewTimer("VehicleEndAlarm", 6000, 1, vehicle.ID);
			local emm;
			emm = random(1, 6);
			if (emm == 2) null
			else if (player.WantedLevel < 2) player.SetWantedLevel(player.WantedLevel.tointeger()+1);
		}
	}
	local id = player.Vehicle.Model
	local hp = player.Vehicle.Health
	local hpt = hp.tointeger()/10;
	local hpe = hpt.tointeger();
	//MessagePlayer("[#FFFAFA]  *Vehicle ID: [#00E3E3]" + player.Vehicle.ID +"[#FFFAFA], Name: [#00E3E3]" + GetVehicleNameFromModel(id) + "[#FFFAFA], Price: [#00E3E3]$" + GetSQLColumnData(QuerySQL(World, "SELECT Price FROM VehiclePrice WHERE VehicleModel='"+player.Vehicle.Model+"'"), 0) + "[#FFFAFA], Owner: [#00E3E3]" + GetSQLColumnData(QuerySQL(World, "SELECT User FROM WorldVehicle WHERE VehID='"+player.Vehicle.ID+"'"), 0) + "[#FFFAFA], Health: [#00E3E3]" + hpe + "%[#FFFAFA].",player);
}

function onPlayerExitVehicle( player, vehicle )
{
	player.IsFrozen = false;
	PlaySoundForPlayer(player, 50002);
	local data = Stream();
	data.WriteString( "Sprite" );
	data.WriteString( "removespeed" );
	data.WriteString( "" );
	data.WriteString( "" );
	data.WriteInt( vehicle.ID );
	data.SendStream( player );
	if ( vehicle.Model == 133 && Status[player.ID].IsYSWorking == true )
	{
		Status[player.ID].IsYSWorking = false;
		Announce("~r~MISSION FAILED!",player, 3)
		Announce("~o~You can't exit vehicle now!",player,1);
		DestroyMarker( YSWorkMarker[player.ID] );
	}
	if(Status[player.ID].IsRacingAkina == true)
	{
		MessagePlayer("[#FF8000]    !You can't exit vehicle now!!! =3=", player)
		Announce("~o~You can't exit vehicle now!",player,1);
		Status[player.ID].IsRacingAkina = false;
		SText("~g~AKINA MISSION FAILED!", player.ID, 3);
		timeprint(player.Name + " 因下车而被终止秋名山任务 =w=");
		TimerEnd(player.ID);
	}
	if(vehicle.Model == 146 && Status[player.ID].IsWorking == true && DoctorSphere[player.ID])
	{
		PlaySound( player.World , 357 , player.Pos );
		player.IsFrozen = false;
		Status[player.ID].IsWorking = false;
		WriteIniString("Data/Sphere.ini", "SphereID", DoctorSphere[player.ID].ID.tostring(), "None");
		DoctorSphere[player.ID].Remove();
		DoctorSphere[player.ID] = null;
		Announce("~p~Now, You can't heal others...", player, 1)
	}
	local data = Stream();
	data.WriteString("Sprite");
	data.WriteString("VehDamage");
	data.WriteString("")
	data.WriteString("")
	data.WriteInt(1000)
	data.SendStream(player);
}

function onVehicleExplode( vehicle )
{
}

function onVehicleRespawn( vehicle )
{
}

function onVehicleHealthChange( vehicle, oldHP, newHP )
{
	if(vehicle.Driver && newHP < oldHP)
	{
		PlaySoundForPlayer(vehicle.Driver, random(50003, 50005));
		PlaySoundForPlayer(vehicle.Driver, random(50003, 50005));
		local data = Stream();
		data.WriteString("Sprite");
		data.WriteString("VehDamage");
		data.WriteString("")
		data.WriteString("")
		data.WriteInt(newHP)
		data.SendStream(vehicle.Driver);
		if(Status[vehicle.Driver.ID].VehDamage == 0)
		{
			Status[vehicle.Driver.ID].VehDamage = oldHP-newHP;
			if(Status[vehicle.Driver.ID].VehDamage > 150) Status[vehicle.Driver.ID].VehDamage = 150;
			if(Status[vehicle.Driver.ID].VehDamage < 30) Status[vehicle.Driver.ID].VehDamage = 30;
			VehDamage(vehicle.Driver.ID)
		}
		if(newHP < 350)
		{
			local data = Stream();
			data.WriteString("Sprite");
			data.WriteString("addnotdalao");
			data.SendStream(vehicle.Driver);
			NewTimer("SendIDPacketToClient", 3000, 1, vehicle.Driver.ID, "Sprite", "removenotdalao")
		}
	}
}

function onVehicleMove( vehicle, lastX, lastY, lastZ, newX, newY, newZ )
{
}

function onPickupClaimPicked( player, pickup )
{
	return 1;
}

function onPickupPickedUp( player, pickup )
{
	pickup.RespawnTime = 2000;
	PlaySoundForPlayer(player, 357);
	
	local team = GetSQLColumnData(QuerySQL(Account, "SELECT Team FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0)
	if( pickup.ID == mansion.ID )
	{
		if (team == 1) SText("No need to repeat buy =w=", player.ID, 1), MessagePlayer("[#FF8000]    !No need to repeat buy =w=",player);
		else if (player.Cash < 25000) MessagePlayer("[#FF8000]    !You need [#00E3E3][$25000][#FF8000]to join the team =w=",player)
		else
		{
			Announce("Would you want to join team RCG? ~g~LShift", player, 1)
			Status[player.ID].ViewTeam = 1;
			NewTimer("ResetViewTeam", 2000, 1, player.ID)
		}
	}

	else if( pickup.ID == akina.ID ) 
	{
		if (team == 2) SText("No need to repeat buy =w=", player.ID, 1), MessagePlayer("[#FF8000]    !No need to repeat buy =w=",player);
		else if (player.Cash < 30000) MessagePlayer("[#FF8000]    !You need [#00E3E3][$30000][#FF8000]to join the team =w=",player)
		else
		{
			Announce("Would you want to join team MVPchina? ~g~LShift", player, 1)
			Status[player.ID].ViewTeam = 2;
			NewTimer("ResetViewTeam", 2000, 1, player.ID)
		}
	}

	else if( pickup.ID == lighthouse.ID ) 
	{
		if (team == 3) SText("No need to repeat buy =w=", player.ID, 1), MessagePlayer("[#FF8000]    !No need to repeat buy =w=",player);
		else if (player.Cash < 15000) MessagePlayer("[#FF8000]    !You need [#00E3E3][$15000][#FF8000]to join the team =w=",player)
		else
		{
			Announce("Would you want to join team LightHouse? ~g~LShift", player, 1)
			Status[player.ID].ViewTeam = 3;
			NewTimer("ResetViewTeam", 2000, 1, player.ID)
		}
	}

	else if( pickup.ID == shipyard.ID )
	{
		if (team == 4) SText("No need to repeat buy =w=", player.ID, 1), MessagePlayer("[#FF8000]    !No need to repeat buy =w=",player);
		else if (player.Cash < 30000) MessagePlayer("[#FF8000]    !You need [#00E3E3][$30000][#FF8000]to join the team =w=",player)
		else
		{
			Announce("Would you want to join team Shipyard? ~g~LShift", player, 1)
			Status[player.ID].ViewTeam = 4;
			NewTimer("ResetViewTeam", 2000, 1, player.ID)
		}
	}

	else if( pickup.ID == club.ID ) 
	{
		if (team == 5) SText("No need to repeat buy =w=", player.ID, 1), MessagePlayer("[#FF8000]    !No need to repeat buy =w=",player);
		else if (player.Cash < 25000) MessagePlayer("[#FF8000]    !You need [#00E3E3][$25000][#FF8000]to join the team =w=",player)
		else
		{
			Announce("Would you want to join team Club? ~g~LShift", player, 1)
			Status[player.ID].ViewTeam = 5;
			NewTimer("ResetViewTeam", 2000, 1, player.ID)
		}
	}

	else if( pickup.ID == ps1.ID || pickup.ID == ps11.ID ) 
	{
		if (team == 6) SText("No need to repeat buy =w=", player.ID, 1), MessagePlayer("[#FF8000]    !No need to repeat buy =w=",player);
		else if (player.Cash < 35000) MessagePlayer("[#FF8000]    !You need [#00E3E3][$35000][#FF8000]to join the team =w=",player)
		else
		{
			Announce("Would you want to join team Police? ~g~LShift", player, 1)
			Status[player.ID].ViewTeam = 6;
			NewTimer("ResetViewTeam", 2000, 1, player.ID)
		}
	}

	else if( pickup.ID == ps2.ID ) 
	{
		if (team == 7) SText("No need to repeat buy =w=", player.ID, 1), MessagePlayer("[#FF8000]    !No need to repeat buy =w=",player);
		else if (player.Cash < 40000) MessagePlayer("[#FF8000]    !You need [#00E3E3][$40000][#FF8000]to join the team =w=",player)
		else
		{
			Announce("Would you want to join team Plainclothes Police? ~g~LShift", player, 1)
			Status[player.ID].ViewTeam = 7;
			NewTimer("ResetViewTeam", 2000, 1, player.ID)
		}
	}

	else if( pickup.ID == barback.ID ) 
	{
		if (team == 8) SText("No need to repeat buy =w=", player.ID, 1), MessagePlayer("[#FF8000]    !No need to repeat buy =w=",player);
		else if (player.Cash < 50000) MessagePlayer("[#FF8000]    !You need [#00E3E3][$50000][#FF8000]to join the team =w=",player)
		else
		{
			Announce("Would you want to join team BarBack? ~g~LShift", player, 1)
			Status[player.ID].ViewTeam = 8;
			NewTimer("ResetViewTeam", 2000, 1, player.ID)
		}
	}

	else if( pickup.ID == hotel.ID ) 
	{
		if (team == 9) SText("No need to repeat buy =w=", player.ID, 1), MessagePlayer("[#FF8000]    !No need to repeat buy =w=",player);
		else if (player.Cash < 20000) MessagePlayer("[#FF8000]    !You need [#00E3E3][$20000][#FF8000]to join the team =w=",player)
		else
		{
			Announce("Would you want to join team Hotelman? ~g~LShift", player, 1)
			Status[player.ID].ViewTeam = 9;
			NewTimer("ResetViewTeam", 2000, 1, player.ID)
		}
	}

	else if( pickup.ID == health1.ID || pickup.ID == health2.ID )
	{
		Announce("You have been healed!",player,7)
		player.Health = 100;
	}
	
	else if( pickup.ID == Doctor1.ID )
	{
		if(GetSQLColumnData(QuerySQL(Account, "SELECT Job FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) == "doctor") Announce("~r~Press E in a ambulance to heal other player =w =", player, 1)
		else if(player.Cash < 6000) Announce("~g~You need ~y~$6000 ~g~to be a doctor!", player, 1);
		else
		{
			Announce("Would you want to be a doctor? ~g~LShift", player, 1)
			Status[player.ID].ViewJob = "doctor";
			NewTimer("ResetViewJob", 2000, 1, player.ID)
		}
	}
}

function onPickupRespawn( pickup )
{
}

function onCheckpointEntered( player, checkpoint )
{
	if ( checkpoint.ID == AkinaStart.ID )
	{
		if (Status[player.ID].IsRacingAkina == true) null
		else if (!player.Vehicle) MessagePlayer("[#FF8000]    !You must drive a vehicle =3=", player), PlaySound( player.World , 335 , player.Pos );
		else if (GetVehicleType( player.Vehicle.Model ) != "Car") MessagePlayer("[#FF8000]    !You must drive a car! CAR! =3=", player);
		else
		{
			Status[player.ID].IsReady = true;
			Status[player.ID].IsReady2 = false;
			Status[player.ID].IsRacingAkina = false;
			PlaySound(player.World, 50070, player.Pos);
			Announce("~g~Press ~y~SPACE ~g~to start, ~y~BACKSPACE ~g~to exit.", player, 1)
			//SendPacketToClient(player, "Sprite", "addracemenu");
			player.SetCameraPos(Vector(player.Pos.x+3, player.Pos.y+7, player.Pos.z+4.3), Vector(player.Pos.x, player.Pos.y, player.Pos.z));
			player.Widescreen = true;
			player.IsFrozen = true;
		}
	}
	else if ( checkpoint.ID == AkinaEnd.ID )
	{
		if (Status[player.ID].IsRacingAkina == false) null
		else
		{
			local allm = TimerEnd(player.ID), allmti = allm/60;
			local mtime = allmti.tointeger();
			local stime = allm-mtime*60;
			PlaySoundForPlayer(player, 368);
			PlaySoundForPlayer(player, 369);
			SText( mtime + "'" + stime + "'' ", player.ID, 7 );
			SText( "You got $2000", player.ID, 1 );
			player.Cash += 2000;
			Status[player.ID].IsRacingAkina = false;
			local MScore = mtime, SScore = stime;
			local lastm = GetSQLColumnData(QuerySQL(Akina, "SELECT Minute FROM AkinaScore WHERE Name='"+player.Name.tolower()+"'"), 0);
			local lasts = GetSQLColumnData(QuerySQL(Akina, "SELECT Second FROM AkinaScore WHERE Name='"+player.Name.tolower()+"'"), 0);
			if ((lastm*60 + lasts) > (MScore*60 + SScore))
			{
				QuerySQL( Akina, "UPDATE AkinaScoreScoreScoreScoreScoreScoreScoreScoreScoreScoreScore SET Name='" + player.Name.tolower() + "', User='" + player.Name + "', Minute='" + MScore + "', Second='" + SScore + "' WHERE Name='" + player.Name.tolower() + "'");
			}
			local FstRecordM = GetSQLColumnData(QuerySQL(Akina, "SELECT Minute FROM First WHERE TH='First'"), 0);
			local SndRecordM = GetSQLColumnData(QuerySQL(Akina, "SELECT Minute FROM Second WHERE TH='Second'"), 0);
			local TrdRecordM = GetSQLColumnData(QuerySQL(Akina, "SELECT Minute FROM Third WHERE TH='Third'"), 0);
			local FstRecordS = GetSQLColumnData(QuerySQL(Akina, "SELECT Second FROM First WHERE TH='First'"), 0);
			local SndRecordS = GetSQLColumnData(QuerySQL(Akina, "SELECT Second FROM Second WHERE TH='Second'"), 0);
			local TrdRecordS = GetSQLColumnData(QuerySQL(Akina, "SELECT Second FROM Third WHERE TH='Third'"), 0);
			local FstNRecord = GetSQLColumnData(QuerySQL(Akina, "SELECT User FROM First WHERE TH='First'"), 0);
			local SndNRecord = GetSQLColumnData(QuerySQL(Akina, "SELECT User FROM Second WHERE TH='Second'"), 0);
			local TrdNRecord = GetSQLColumnData(QuerySQL(Akina, "SELECT User FROM Third WHERE TH='Third'"), 0);
			if ( FstRecordM*60+FstRecordS >= MScore*60+SScore || FstNRecord == "None")
			{
				SText("~g~You are the ~t~1st ~g~and you refreshed your record!", player.ID, 8);
				QuerySQL( Akina, "UPDATE First SET Name='" + player.Name.tolower() + "', User='" + player.Name + "', Minute='" + MScore + "', Second='" + SScore + "' WHERE TH='First'");
				QuerySQL( Akina, "UPDATE Second SET Name='" + FstNRecord.tolower() + "', User='" + FstNRecord + "', Minute='" + FstRecordM + "', Second='" + FstRecordS + "' WHERE TH='Second'");
				QuerySQL( Akina, "UPDATE Third SET Name='" + SndNRecord.tolower() + "', User='" + SndNRecord + "', Minute='" + SndRecordM + "', Second='" + SndRecordS + "' WHERE TH='Third'");
			}
			else if ( SndRecordM*60+SndRecordS >= MScore*60+SScore || SndNRecord == "None")
			{
				SText("~g~You are the ~t~2st ~g~and you refreshed your record!", player.ID, 8);
				QuerySQL( Akina, "UPDATE Second SET Name='" + player.Name.tolower() + "', User='" + player.Name + "', Minute='" + MScore + "', Second='" + SScore + "' WHERE TH='Second'");
				QuerySQL( Akina, "UPDATE Third SET Name='" + SndNRecord.tolower() + "', User='" + SndNRecord + "', Minute='" + SndRecordM + "', Second='" + SndRecordS + "' WHERE TH='Third'");
			}
			else if ( TrdRecordM*60+TrdRecordS >= MScore*60+SScore || TrdNRecord == "None")
			{
				SText("~g~You are the ~t~3st ~g~and you refreshed your record!", player.ID, 8);
				QuerySQL( Akina, "UPDATE Third SET Name='" + player.Name.tolower() + "', User='" + player.Name + "', Minute='" + MScore + "', Second='" + SScore + "' WHERE TH='Third'");
			}
			else SText("~g~You refreshed your record!   But you can't more than the top three...", player.ID, 8);
			IncExp(player.ID, 5);
			Message("[#FFFAFA]  *<"+GetRGBCode( player.ID )+player.Name+" [#FFFAFA]has reached the top of [#00E3E3]Akina[#FFFAFA]! Time: [#00E3E3][" + mtime + "'" + stime + "''] [#FFFAFA] +2000$ =w=>*")
			Message("[#FFFAFA]  *<Type [#00E3E3]!akina [#FFFAFA] to see the top three of [#00E3E3]Akina[#FFFAFA] =w=>*")
		}
	}

	else if( checkpoint.ID == ARS1.ID )
	{
		if (player.Vehicle) player.Vehicle.Fix(),PlaySound( player.World , 357 , player.Pos );
		else MessagePlayer("[#FF8000]    !You must drive a car =w=", player),PlaySound( player.World , 335 , player.Pos );
	}

	else if ( checkpoint.ID == Sunshine.ID )
	{
		if (!player.Vehicle) LangText("[#FF8000]    !Ni Bi'xu Kai'yi'liang Che =3=", "[#FF8000]    !You must drive a car =3=", player.ID, false),PlaySound( player.World , 335 , player.Pos );
		else
		{
			local vname = GetSQLColumnData(QuerySQL(World, "SELECT User FROM WorldVehicle WHERE VehID='"+player.Vehicle.ID+"'"), 0);
			if (vname != "None") LangText( "[#FF8000]    !Zhe'liang'che Yi'jing Bei'ren Mai'le =3=", "[#FF8000]    !This vehicle is bought by others =3=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
			else
			{
				if (vname == player.Name) LangText( "[#FF8000]    !Zhe'liang'che Yi'jing Bei Ni Mai'le =3=", "[#FF8000]    !This vehicle is bought by yourself =3=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
				else
				{
					PlaySound( player.World , 357 , player.Pos );
					Status[player.ID].IsBuyingVehicle = true;
					ChoosingVehicle( player.ID, "Sunshine", player.Vehicle.ID );
				}
			}
		}
	}
	else if ( checkpoint.ID == WeaponShop1.ID ) SaveWeapon(player.ID), Status[player.ID].IsBuyingWeapon = true, ChoosingWeapon(player.ID, player.Pos.x, player.Pos.y-2, player.Pos.z+1.5), PlaySound(player.World, 50069, player.Pos);
	else if ( checkpoint.ID == WeaponShop2.ID ) SaveWeapon(player.ID), Status[player.ID].IsBuyingWeapon = true, ChoosingWeapon(player.ID, player.Pos.x, player.Pos.y-2, player.Pos.z+1.5), PlaySound(player.World, 50069, player.Pos);
	else if ( checkpoint.ID == WeaponShop3.ID ) SaveWeapon(player.ID), Status[player.ID].IsBuyingWeapon = true, ChoosingWeapon(player.ID, player.Pos.x, player.Pos.y-2, player.Pos.z+1.5), PlaySound(player.World, 50069, player.Pos);

	else if ( checkpoint.ID == ToolShop1.ID ) Status[player.ID].IsBuyingWeapon = true, ChoosingWeapon(player.ID, player.Pos.x, player.Pos.y-2, player.Pos.z+2);

	else if ( checkpoint.ID == ClothesShop.ID ) Status[player.ID].IsBuyingClothes = true, ChoosingClothes(player.ID);

	else if ( checkpoint.ID == PizzaShop1.ID ) SText("~g~Press ~y~LShift ~g~to eat pizza", player.ID, 1),Status[player.ID].IsBuyingPizza = true;
	else if ( checkpoint.ID == PizzaShop2.ID ) SText("~g~Press ~y~LShift ~g~to eat pizza", player.ID, 1),Status[player.ID].IsBuyingPizza = true;
	else if ( checkpoint.ID == PizzaShop3.ID ) SText("~g~Press ~y~LShift ~g~to eat pizza", player.ID, 1),Status[player.ID].IsBuyingPizza = true;
	else if ( checkpoint.ID == PizzaShop4.ID ) SText("~g~Press ~y~LShift ~g~to eat pizza", player.ID, 1),Status[player.ID].IsBuyingPizza = true;
	else if ( checkpoint.ID == PizzaShop5.ID ) SText("~g~Press ~y~LShift ~g~to eat pizza", player.ID, 1),Status[player.ID].IsBuyingPizza = true;
	else if ( checkpoint.ID == PizzaShop6.ID ) SText("~g~Press ~y~LShift ~g~to eat pizza", player.ID, 1),Status[player.ID].IsBuyingPizza = true;

	else if ( checkpoint.ID == RCGHotel.ID ) SText("~g~Press ~y~LShift ~g~to put up here(Zhu'su) $5000", player.ID, 1),Status[player.ID].IsBuyingRCGHotelticket = true;
	else if ( checkpoint.ID == LVehicleFix1.ID ) DVehicleFix1.MoveTo( Vector(-874.696, -116.696, 15.9875), 3000 );
	else if ( checkpoint.ID == LVehicleFix2.ID ) DVehicleFix2.MoveTo( Vector(-7.80468, -1257.64, 15.8187), 3000 );
	else if ( checkpoint.ID == VehicleFix1.ID || checkpoint.ID == VehicleFix2.ID )
	{
		if(player.Vehicle && player.ID == player.Vehicle.Driver.ID)
		{
			if (!player.Vehicle) SText("~g~You must drive a vehicle!", player.ID, 1),PlaySound( player.World , 335 , player.Pos );
			else
			{
				player.IsFrozen = true;
				SText("~y~Vehicle ~b~Repair ~g~Shop", player.ID, 0);
				SText("~g~Select Color1 - "+player.Vehicle.Colour1.tostring(), player.ID, 1);
				SText("~y~A ~g~LShift($233) ~y~D", player.ID, 7);
				Status[player.ID].ViewVehicleColor = 1;
				Status[player.ID].ViewVehicleCol1 = player.Vehicle.Colour1;
				Status[player.ID].ViewVehicleCol2 = player.Vehicle.Colour2;
				Status[player.ID].VehicleCol1 = player.Vehicle.Colour1;
				Status[player.ID].VehicleCol2 = player.Vehicle.Colour2;
				ChoosingVehicleCol1(player.ID);
				if ( checkpoint.ID == VehicleFix1.ID ) Status[player.ID].IsEnteringVRS1 = true, player.SetCameraPos( Vector( -882.0836, -112.9204, 11.1034 ), Vector( player.Pos.x, player.Pos.y, player.Pos.z ) );
				if ( checkpoint.ID == VehicleFix2.ID ) Status[player.ID].IsEnteringVRS2 = true, player.SetCameraPos( Vector( 2.0476, -1255.1051, 10.9633 ), Vector( player.Pos.x, player.Pos.y, player.Pos.z ) );
			}
		}
	}

	else if ( checkpoint.ID == HotelHost.ID ) SText("~g~Press ~y~LShift ~g~to steal here", player.ID, 1),Status[player.ID].IsStealingHotel = true;
	else if ( checkpoint.ID == HotelGuest.ID ) SText("~g~Press ~y~LShift ~g~to put up here(Zhu'su) $2980", player.ID, 1),Status[player.ID].IsBuyingHotelticket = true;
	else if ( checkpoint.ID == HotelEnter.ID )
	{
		if (Status[player.ID].CanPutup == false) SText("~g~Please buy a ticket(Mai'piao) first...", player.ID, 1);
		else PutUpHotel(player.ID), IncExp(player.ID, 1);
	}
	else if ( checkpoint.ID == HotelExitdoor.ID ) player.Pos = Vector(213.1059, -1285.5896, 12.0919);
	else if ( checkpoint.ID == AirportExit1.ID || checkpoint.ID == AirportExit2.ID	)
	{
		if (Status[player.ID].IsNew == false) null
		else
		{
			PlaySound( player.World , 335 , player.Pos );
			Status[player.ID].IsNew = false;
			Status[player.ID].CanTeleport = false;
			player.SetCameraPos( Vector( -1446.0383, -826.6631, 17.6401 ), Vector( player.Pos.x, player.Pos.y, player.Pos.z ) );
			SText("-Welcome to here-", player.ID, 7);
			SText("-Come and Enjoy the Fresh Air-", player.ID, 1);
			player.IsFrozen = true;
			player.Widescreen = true;
			MessagePlayer("[#FFFAFA]  *Scripts by [#00E3E3]Ctone [#FFFAFA]& [#00E3E3]All members of the RCG [#FFFAFA]=w=", player);
			MessagePlayer("[#FFFAFA]  *Thank [#00E3E3]bdc([Mks]Rest) [#FFFAFA]for giving me help~", player);
			NewTimer("RestoreCamera", 3000, 1, player.ID);
			NewTimer("SText", 3000, 1, "~g~Drive ~y~Taxi ~g~to leave here", player.ID, 1);
			NewTimer("PlayMusicForPlayer", 6001, 1, player.ID, 50066);
			NewTimer("SText", 6001, 1, "Here is not safe.", player.ID, 1);
		}
	}
	else if ( checkpoint.ID == StuntCheckpoint1.ID || checkpoint.ID == StuntCheckpoint2.ID || checkpoint.ID == StuntCheckpoint3.ID || checkpoint.ID == StuntCheckpoint4.ID || checkpoint.ID == StuntCheckpoint5.ID || checkpoint.ID == StuntCheckpoint6.ID || checkpoint.ID == StuntCheckpoint7.ID || checkpoint.ID == StuntCheckpoint8.ID || checkpoint.ID == StuntCheckpoint9.ID )
	{
		if(player.Vehicle)
		{
			if(GetVehicleType( player.Vehicle.Model ) != "Heli" && GetVehicleType( player.Vehicle.Model ) != "Plane") Stunting(player.ID);
		}
	}
	else if ( checkpoint.ID == FightEnterdoor.ID )
	{
		if(!player.Vehicle)
		{
			player.Pos = Vector(-1727.0184, -156.2967, 14.8683);
			MessagePlayer("[#FFFAFA]  *Welcome to [#66CCFF]FIGHT![#00CCFF] [#FFFAFA]=W=", player);
			SText("~r~Fighting!", player.ID, 7)
			Status[player.ID].IsFighting = true;
		}
		else MessagePlayer("[#FF8000]    !You can't get into FIGHT with a vehicle >w<"), SText("Exit Vehicle First", player.ID, 7);
	}
	else if ( checkpoint.ID == FightExitdoor.ID )
	{
		Progress(player.ID, 4321);
		NewTimer("ExitFight", 4321, 1, player.ID);
	}
	else if ( checkpoint.ID == YSWork.ID )
	{
		if ( player.Vehicle && player.Vehicle.Model == 133 && Status[player.ID].IsYSWorking == false && player.Vehicle.Driver.ID == player.ID )
		{
			Status[player.ID].IsYSWorking = true;
			YSWorkMarker[player.ID] = CreateMarker( player.UniqueWorld, Vector(-17.9337, 942.547, 10.9402), 10, RGB(255, 51, 51), 0 )
			player.Widescreen = true;
			player.IsFrozen = true;
			Announce("Transport", player, 4)
			NewTimer("SText", 3000, 1, "", player.ID, 4)
			Announce("Mr.QAQ needs help now,", player, 1)
			player.SetCameraPos( Vector(-915.304, -1410.38, 15.7892), player.Pos );
			NewTimer("SText", 1599, 1, "He wants to transport these goods to the cinema.", player.ID, 1)
			NewTimer("SetCamera", 1599, 1, player.ID, -24.9337, 955.547, 19.9402, -17.9337, 942.547, 10.9402)
			NewTimer("SText", 3389, 1, "You got a truck, you need to help him.", player.ID, 1)
			NewTimer("SText", 4956, 1, "After the mission passed, you will be awarded different rewards according to the damage level of the vehicle.", player.ID, 1)
			NewTimer("SetCamera", 4956, 1, player.ID, -14.9337, 945.547, 15.9402, player.Pos.x, player.Pos.y, player.Pos.z)
			NewTimer("SText", 7000, 1, "~g~Transport To Cinema.", player.ID, 1)
			NewTimer("RestoreCamera", 7000, 1, player.ID)
		}
		else if ( player.Vehicle && player.Vehicle.Model != 133 )
		{
			Announce("~o~You need a truck to work.", player, 1)
		}
		else Announce("", player, 1)
	}
	else if ( checkpoint.ID == YSWorkEnd.ID )
	{
		if ( player.Vehicle && player.Vehicle.Model == 133 && player.Vehicle.Driver )
		{
			if ( Status[player.ID].IsYSWorking == true && player.Vehicle.Health >= 800 )
			{
				Status[player.ID].IsYSWorking = false;
				player.Cash += 1500;
				Announce("~r~MISSION PASSED! +1500$",player, 3)
				DestroyMarker( YSWorkMarker[player.ID] );
				PlaySound(player.UniqueWorld, 366, player.Pos);
				IncExp(player.ID, 8);
			}
			else if ( Status[player.ID].IsYSWorking == true && player.Vehicle.Health >= 500 )
			{
				Status[player.ID].IsYSWorking = false;
				player.Cash += 1000;
				Announce("~r~MISSION PASSED! +1000$",player, 3)
				DestroyMarker( YSWorkMarker[player.ID] );
				PlaySound(player.UniqueWorld, 366, player.Pos);
				IncExp(player.ID, 6);
			}
			else if ( Status[player.ID].IsYSWorking == true && player.Vehicle.Health >= 1 )
			{
				Status[player.ID].IsYSWorking = false;
				player.Cash += 700;
				Announce("~r~MISSION PASSED! +700$",player, 3)
				DestroyMarker( YSWorkMarker[player.ID] );
				PlaySound(player.UniqueWorld, 366, player.Pos);
				IncExp(player.ID, 4);
			}
		}
	else Announce("~g~You have to go to the shipyard to accept the work!",player,1)
	}
	else if (checkpoint.ID == BankDoor.ID)
	{
		if(Status[player.ID].IsInBank == false)
		{
			PlaySound( player.World , 335 , player.Pos );
			player.Pos = Vector(-901.036, -341.049, 13.3802);
			MessagePlayer("[#FFFAFA]  *Welcome to [#00CCFF]Bank[#FFFAFA]~", player);
			Announce("~y~Welcome to Bank =w =", player, 1)
			Status[player.ID].IsInBank = true;
		}
		else 
		{
			PlaySound( player.World , 335 , player.Pos );
			player.Pos = Vector(-893.463, -341.071, 13.5069);
			MessagePlayer("[#FFFAFA]  *Welcome to bank [#00CCFF]Next time[#FFFAFA]~", player);
			Announce("~y~Welcome to bank Next time =w =", player, 1)
			Status[player.ID].IsInBank = false;
		}
	}
	else if (checkpoint.ID == BankAccount.ID)
	{
		local bank = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
		Announce("~g~Your Account: ~y~[$"+bank+"]", player, 7)
		Announce("~y~!b+ ~g~to deposit, ~y~!b- ~g~to withdraw", player, 1)
		if ( !bank && bank == 0 ) LangText( "[#FFFAFA]  *MEI QIAN 233 =w=","[#FFFAFA]  *No money in your bank account =w=",player.ID,false ),PlaySound( player.World , 335 , player.Pos );
		else MessagePlayer( "[#FFFAFA]  *There are [#00E3E3]$" + bank.tostring() + " [#FFFAFA]in your bank account =w=",player ),PlaySound( player.World , 357 , player.Pos );
	}
	else if (checkpoint.ID == NKenOffice.ID) Announce("~y~Ken Robert isn't here...", player, 1)
	else if (checkpoint.ID == NClothesShop.ID) Announce("~y~The Clothes Shop is Closed...", player, 1)
	else if (checkpoint.ID == NShop1.ID || checkpoint.ID == NShop2.ID || checkpoint.ID == NShop3.ID) Announce("~y~It's Closed...", player, 1)
	else if (checkpoint.ID == NHotel1.ID || checkpoint.ID == NHotel2.ID || checkpoint.ID == NHotel3.ID || checkpoint.ID == NHotel4.ID) Announce("~y~The Hotel is Closed...", player, 1)
	else if ( IsHealSphere(checkpoint.ID) == true )
	{
		local plrname = ReadIniString("Data/Sphere.ini", "SphereID", checkpoint.ID.tostring())
		local plr = FindPlayer(plrname)
		if(plr)
		{
			if(player.ID != plr.ID)
			{
				if(player.Health.tointeger() >= 100 && plr.Name) SText("~r~You are healthy!", player.ID, 1)
				else
				{
					SText("~g~Press ~y~LShift ~g~to heal ($" + (5*(100-player.Health.tointeger())).tostring() + ")", player.ID, 1);
					Status[player.ID].IsHealing = true;
					Status[player.ID].WheretoHeal = plr.Name;
				}
			}
		}
	}
}

function onCheckpointExited( player, checkpoint )
{
	if ( checkpoint.ID == LVehicleFix1.ID ) DVehicleFix1.MoveTo( Vector(-874.696, -116.696, 11.9875), 3000 );
	else if ( checkpoint.ID == LVehicleFix2.ID ) DVehicleFix2.MoveTo( Vector(-7.80468, -1257.64, 10.8187), 3000 );
	else if ( checkpoint.ID == PizzaShop1.ID || checkpoint.ID == PizzaShop2.ID || checkpoint.ID == PizzaShop3.ID || checkpoint.ID == PizzaShop4.ID || checkpoint.ID == PizzaShop5.ID || checkpoint.ID == PizzaShop6.ID ) SText("", player.ID, 1),Status[player.ID].IsBuyingPizza = false;
	else if ( checkpoint.ID == RCGHotel.ID ) SText("", player.ID, 1),Status[player.ID].IsBuyingRCGHotelticket = false;
	else if ( checkpoint.ID == HotelHost.ID ) SText("", player.ID, 1),Status[player.ID].IsStealingHotel = false;
	else if ( checkpoint.ID == HotelGuest.ID ) SText("", player.ID, 1),Status[player.ID].IsBuyingHotelticket = false;
	else if ( checkpoint.ID == HotelEnter.ID ) SText("", player.ID, 1);
	else if ( checkpoint.ID == FightExitdoor.ID ) Announce("~r~You can't exit sphere now!", player, 1), Status[player.ID].StopProgress = true;
	else if ( IsHealSphere(checkpoint.ID) == true && Status[player.ID].IsHealing == true ) Announce("~r~You can't exit sphere now!", player, 1), Status[player.ID].StopProgress = true, Status[player.ID].WheretoHeal = "None", Status[player.ID].IsHealing = false;
	else if ( IsHealSphere(checkpoint.ID) == true ) Status[player.ID].WheretoHeal = "None", Status[player.ID].IsHealing = false;
}
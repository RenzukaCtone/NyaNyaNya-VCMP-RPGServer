soundwords <- ["lai le", "lu shang", "shuo ju hua", "shuo hua", "kuai shuo", "bai bai", "bye", "88", "xia le", "zai jian", "you ren ma", "mei you kai g", "mei g", "mei kai g", "nihao", "ni hao", "hello", "halo", "hi", "wo you", "nb", "niu bi", "niu p", "li hai", "lihai", "ke yi", "keyi", "mai qiang", "bie dong"];
badwords <- ["cao ni ma", "caonima", "sb", "s b", "shabi", "sha bi", "cnm", "bitch", "er zi", "behenchod", "noobish", "lame", "rinima", "rnm", "ri ni ma"];
function onPlayerChat( player, message )
{
	if ( player.Name.find("=") != null ) null
	else
	{
		local Level = "[Lv." + GetSQLColumnData(QuerySQL(Account, "SELECT Level FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0) + "]";
		PlaySoundForWorld( player.World, 50001 );
		PlaySoundForWorld( player.World, 50001 );
		PlaySoundForWorld( player.World, 50001 );
		PlaySoundForWorld( player.World, 50001 );
		if ( message )
		{
			if ( message.slice( 0, 1 ) == "!" )
			{
				local i = NumTok( message, " " ), xp = null;
				if ( i == 1 ) onPlayerCommand2( player, GetTok( message.slice( 1 ), " ", 1 ), xp ),PrintCmdMessges(player.ID, null, message), Message("[#FFD700]"+Level+GetRGBCode( player.ID )+player.Name+"[#FFFFFF]: "+message);
				else onPlayerCommand2( player, GetTok( message.slice( 1 ), " ", 1 ), GetTok( message.slice( 1 ), " ", 2, i ) ), PrintCmdMessges(player.ID, null, message), Message("[#FFD700]"+Level+GetRGBCode( player.ID )+player.Name + "[#FFFFFF]: "+message);
			}
			else
			{
				PlaySound( player.World , 375 , player.Pos );
				timeprint( "交谈 - " + player.Name + ":" + message + "" );
				Message("[#FFD700]"+Level+GetRGBCode(player.ID)+player.Name+": [#FFFFFF]"+message);
				foreach( str in soundwords )
				{
					if(message.tolower().find(str) != null) Voice(player.ID, str);
				}
				foreach( bad in badwords )
				{
					if(message.tolower().find(bad) != null)
					{
						PlaySoundForPlayer(player, 50091);
						Status[player.ID].BadTime++;
						MessagePlayer("[#FF8000]    !Warn: Bad words ["+Status[player.ID].BadTime+"/3]", player);
						if(Status[player.ID].BadTime >= 3) Message( "[#FFFAFA]  *<Auto-Kick: "+GetRGBCode(player.ID) + player.Name + "[#FFFAFA], Reason:[#00CCFF] Use bad words[#FFFAFA].>*"), KickPlayer(player);
					}
				}
				if(message.tolower().find("hhh") != null || message.tolower().find("233") != null || message.tolower().find("haha") != null) FunPic("hhhhh", 2333);
				else if(message.tolower().find("cao") != null || message.tolower().find("wtf") != null || message.tolower().find("tm") != null || message.tolower().find("shit") != null || message.tolower().find("rang wo k") != null) FunPic("Attacking", 2333);
				else if(message.tolower().find("ke le") != null || message.tolower().find("he dian shui") != null || message.tolower().find("he shui") != null || message.tolower().find("he dian s") != null ) FunPic("Drinking", 2333);
				else if(message.tolower().find("e le") != null || message.tolower().find("chi fan") != null || message.tolower().find("chi dong x") != null || message.tolower().find("chi dian dong x") != null ) FunPic("Eating", 2333);
				else if(message.tolower().find("you qu") != null || message.tolower().find("interesting") != null || message.tolower().find("exciting") != null ) FunPic("exciting", 2333);
				else if(message.tolower().find("kuai le shui") != null || message.tolower().find("fei zhai") != null) FunPic("excitingwater", 2333);
				else if(message.tolower().find("hiahia") != null) FunPic("Foundsth", 2333);
				else if(message.tolower().find("nan shou") != null || message.tolower().find("xiang ku") != null || message.tolower().find("wo si le") != null || message.tolower().find("zi sha") != null) FunPic("godie", 2333);
				else if(message.tolower().find("xixi") != null || message.tolower().find("heihei") != null || message.tolower().find("xi xi") != null || message.tolower().find("hei hei") != null) FunPic("miaowHH", 2333);
				else if(message.tolower() == "zao" || message.tolower().find("miao") != null || message.tolower().find("nya") != null) FunPic("miaowmorning", 2333);
				else if(message.tolower().find("ni ma de") != null && message.tolower().find("wei shen me") != null) FunPic("nmdwhy", 2333);
				else if(message.tolower().find("no money") != null || message.tolower().find("mei qian") != null) FunPic("nomoney", 2333);
				else if(message.tolower().find("qaq") != null || message.tolower().find("qwq") != null || message.tolower().find("ke pa") != null || message.tolower().find("hai pa") != null || message.tolower().find("bu yao") != null) FunPic("QQAQ", 2333);
				else if(message.tolower().find("la ji") != null || message.tolower().find("cai ji") != null || message.tolower().find("ruo") != null || message.tolower().find("bi ni li hai") != null || message.tolower().find("bi ni nb") != null) FunPic("Rubbish", 2333);
				else if(message.tolower().find("shui le") != null || message.tolower().find("shui jiao") != null || message.tolower().find("shui la") != null) FunPic("wannasleep", 2333);
				return 0;
			}
		}
	}
}

function onPlayerCommand( player, cmd, text )
{
	if ( player.Name.find("=") != null ) null
	else
	{
		try
		{
			cmd = cmd.tolower();
			if ( cmd == "register" || cmd == "reg" || cmd == "zhuce" || cmd == "r") Register( player.ID, text )
			else if ( cmd == "changepw" || cmd == "newpassword" || cmd == "newpass" || cmd == "changepassword" || cmd == "changepass" ) ChangePassword( player.ID, text )
			else if ( cmd == "login" || cmd == "log" || cmd == "denglu" || cmd == "l") Login( player.ID, text )
			else if ( cmd == "wepslot" ) // Command for calling the function. // test
			{
				SlotWeapons(player);
			}
			else if ( cmd == "aaaaaa" )
			{
				PlaySound( player.World , 50108 , player.Pos );
				Announce("............", player, 1)
				MessagePlayer("............", player)
				Status[player.ID].Dontstop = true;
				aaaaaa(player.ID);
				local id = player.ID;
				NewTimer("stoplease", 23000, 1, id);
			}
			else if ( Status[player.ID].Admin == true && Status[player.ID].IsLogin == true )
			{
//Admin Commands
				if (cmd == "text" || cmd == "announceall" || cmd == "ann")
				{
					if(!text) MessagePlayer("[#FF8000]    !Use /" + cmd + " <Message>",player),PlaySound( player.World , 335 , player.Pos );
					else AnnounceAll ( text + "", 7),MessagePlayer("[#00DB00]    >You have announced: " + text,player ),PlaySound(player.World, 50005, player.Pos);
				}

				else if (cmd == "weather" || cmd == "setweather" || cmd == "tianqi")
				{
					if(!text) MessagePlayer("[#FF8000]    !Use /" + cmd + " <WeatherID>",player),PlaySound( player.World , 335 , player.Pos );
					else SetWeather( text.tointeger() ),MessagePlayer("[#00DB00]    >Weather ID: " + text,player ),PlaySound(player.World, 50005, player.Pos);
				}
				
				else if (cmd == "time" || cmd == "settime" || cmd == "shijian")
				{
					if(!text) MessagePlayer("[#FF8000]    !Use /" + cmd + " <Hour> <Minute>",player),PlaySound( player.World , 335 , player.Pos );
					else
					{
						local params = split( text, " " );
						SetTime( params[0].tointeger(), params[1].tointeger() );
						MessagePlayer("[#00DB00]    >Set time to "+params[0]+":"+params[1], player );
						PlaySound(player.World, 50005, player.Pos);
					}
				}

				else if ( cmd == "ban" || cmd == "b" )
				{
					if ( text )
					{
						local params = split( text, " " );
						local plr = FindPlayer( params[0].tointeger() );
						if ( plr ) BanPlayer(plr.ID, params[1], params[2].tointeger()),PlaySound( player.World , 357 , player.Pos );
						else MessagePlayer( "[#FF8000]    !Invalid Player" , player ),PlaySound( player.World , 335 , player.Pos );
					}
					else MessagePlayer( "[#FF8000]    !Use /ban <Nick Name/ID> <Reason> <Time>" , player ),PlaySound( player.World , 335 , player.Pos );
				}

				else if ( cmd == "kick" || cmd == "t" || cmd == "k" )
				{
					if ( text )
					{
						local params = split( text, " " );
						local plr = FindPlayer( params[0].tointeger() );
						if ( plr ) KickPlayer( plr ),PlaySound( player.World , 357 , player.Pos ),Message( "[#FFFAFA]  *<Kick Player: " + GetRGBCode(player.ID) + player.Name + "[#FFFAFA] , Reason: [#00CCFF]"+params[1]+"[#FFFAFA]>*" );
						else MessagePlayer( "[#FF8000]    !Invalid Player" , player ),PlaySound( player.World , 335 , player.Pos );
					}
					else MessagePlayer( "[#FF8000]    !Use /"+cmd+" <Nick Name/ID> <Reason>" , player ),PlaySound( player.World , 335 , player.Pos );
				}

				else if ( cmd == "give" )
				{
					if(!text || !split( text, " " )[0]) MessagePlayer( "[#FF8000]Syntax - /givemoney <Nick Name/ID> <Ammount>", player ),PlaySound( player.World , 335 , player.Pos );
					else
					{
						local params = split( text, " " ), plr = FindPlayer( params[0].tointeger() ), ammount = params[1];
						if(!plr) MessagePlayer( "[#FF8000]    !Error - invalid player", player ),PlaySound( player.World , 335 , player.Pos );
						else if(!ammount || !IsNum( ammount )) MessagePlayer( "[#FF8000]Error - The Ammount must be integer", player ),PlaySound( player.World , 335 , player.Pos );
						else
						{
							PlaySound( player.World , 357 , player.Pos );
							PlaySound( plr.World , 357 , plr.Pos );
							plr.GiveMoney(ammount.tointeger());
							MessagePlayer( "[#8CEA00]>Admin has given [#FF8000]$"+ammount.tostring()+" to you =w=",plr);
							MessagePlayer( "[#8CEA00]>You have given $"+ammount.tostring()+" to "+plr.Name,player);
						}
					}
				}
				else if ( cmd == "getcar" )
				{
					
					/*
					if(!text) MessagePlayer( "[#FF8000]Use /" + cmd + " <CarID> <ColorID>", player );
					else
					{
						local a = split(text, " ")
						if ( !IsNum( a[0] ))MessagePlayer("[#FF8000]Use /" + cmd + " <CarID> <ColorID>", player);
						else if ( !IsNum( a[1] ))MessagePlayer( "[#FF8000]Use /" + cmd + " <CarID> <ColorID>", player );
						else
						{
							local params = split( text, " " )
							local car = params[0];
							local color = params[1];
							local carpos = player.Pos;
							carpos.y += 1;
							player.Vehicle = CreateVehicle( car.tointeger(), carpos, 90, color.tointeger(), color.tointeger() );
							MessagePlayer("[#FFFAFA]>CarSpawn! ModelID: [" + car + "],Name:[" + GetVehicleNameFromModel(car.tointeger()) + "],ColorID: [" + color + "].",player )
						}
					}
					*/
				}
				else if( cmd == "pass" || cmd == "seepass" || cmd == "password" || cmd == "seepassword")
				{
					if(!text) MessagePlayer( "[#FF8000]    !Use /" +cmd+" <Nick Name>", player ),PlaySound( player.World , 335 , player.Pos );
					else
					{
						PlaySound( player.World , 357 , player.Pos );
						local lalala = GetSQLColumnData(QuerySQL(Account, "SELECT Password FROM Account WHERE Name='"+text.tolower()+"'"), 0)
						MessagePlayer( "[#FFFAFA]  *"+text+" 's password: ["+lalala.tostring()+"].",player);
					}
				}
				else if ( cmd == "setpos" )
				{
					if(!player.Vehicle) player.Pos = Vector(split( text, " " )[0].tofloat(), split( text, " " )[1].tofloat(), split( text, " " )[2].tofloat())
					else player.Vehicle.Pos = Vector(split( text, " " )[0].tofloat(), split( text, " " )[1].tofloat(), split( text, " " )[2].tofloat())
				}
				else if (cmd == "update")
				{
					SendPacketToClient(player, "Sprite", "AddUpdate")
					NewTimer("SendIDPacketToClient", 15000, 1, player.ID, "Sprite", "RemoveUpdate");
				}
				else if (cmd == "sql" || cmd == "updatesql" || cmd == "db" || cmd == "updatedb")
				{
					if(!text) MessagePlayer( "[#FF8000]    !Use /" +cmd+" <Command>, cmd usage: UPDATE DB SET Mode='value', Mode2='value2' WHERE uwant='value'", player ),PlaySound( player.World , 335 , player.Pos );
					else
					{
						PlaySound(player.World, 50005, player.Pos);
						QuerySQL(split( compilestring(text), " " )[0], split( text, " " )[1]);
						MessagePlayer( "[#00DB00]    >SQL [#00CCFF]"+split( text, " " )[0]+".db[#00DB00] - [#66CCFF]"+split( text, " " )[1],player);
					}
				}
				else if (cmd == "getsql" || cmd == "getdb")
				{
					if(!text) MessagePlayer( "[#FF8000]    !Use /" +cmd+" <Command>, cmd usage: SELECT DB FROM uknow WHERE uwant='value'", player ),PlaySound( player.World , 335 , player.Pos );
					else
					{
						PlaySound(player.World, 50005, player.Pos);
						local result = GetSQLColumnData(QuerySQL(split( compilestring(text), " " )[0], split( text, " " )[1]));
						if(!result) MessagePlayer( "[#FF8000]    !Can't find that value..., cmd usage: SELECT DB FROM uknow WHERE uwant='value'", player )
						else MessagePlayer( "[#FFFAFA]>GET SQL [#00CCFF]"+split( text, " " )[0]+".db[#00DB00] - [#66CCFF]"+split( text, " " )[1]+" [#00DB00]value: [#66CCFF]"+result,player);
					}
				}
				else if (cmd == "huaji")
				{
					QAQInteresting();
					NewTimer("QAQInteresting", 801, 1)
					NewTimer("QAQInteresting", 1602, 1)
				}
				else if (cmd == "seepos") MessagePlayer( "[#FFFAFA]  *"+FindPlayer(text.tointeger()).Name+" 's Pos: ["+FindPlayer(text.tointeger()).Pos+"].",player);
				else if (cmd == "giveexp") IncExp(FindPlayer(text.tointeger()).player.ID, 8);
				else if ( cmd == "admin" || cmd == "adm" || cmd == "administor" || cmd == "fuzhu" || cmd == "info" )
				{
					LangText("[#FFFAFA]  *Zhi you wo! [#66CCFF][RCG]Ctone [#00CCFF](ServerHost)", "[#FFFAFA]  *Only I! [#66CCFF][RCG]Ctone [#00CCFF](ServerHost)", player.ID ,false)
				}
				else MessagePlayer("[#FF8000]    !We don't have this command QAQ", player)
			}
			else LangText("[#FF8000]    !Ni yao yong ''!'' kai tou de CMD! Ke yi an [#00E3E3]F2 [#FF8000]=w=","[#FF8000]    !Use the command starting with ''!'', Try pressing [#00E3E3]F2 [#FFFAFA]to know how to play [#FF8000]=w=", player.ID,false ),PlaySound( player.World , 335 , player.Pos );
		}
		catch(e) timeprint( "脚本发现错误啦QAQ - 玩家指令那儿出现了" + e + "的错误, 这个时候是[" + GetFullTime() + "].");
	}
}

//! cmds

function onPlayerCommand2( player, cmd, text )
{
	if ( player.Name.find("=") != null ) null
	else
	{
		try
		{
			if (cmd)
			{
				if(Status[player.ID].IsLogin == true)
				{
					cmd = cmd.tolower();
					if ( cmd == "cd" || cmd == "count" || cmd == "jishi" || cmd == "321" || cmd == "321go" || cmd == "daojishi")
					{
						NewTimer( "STextAll", 1, 1, "- 3 -", 7 );
						NewTimer( "STextAll", 1000, 1, "- 2 -", 7 );
						NewTimer( "STextAll", 2000, 1, "- 1 -", 7 );
						NewTimer( "STextAll", 3000, 1, "- GO -", 7 );
					}
					else if( cmd == "buycar" || cmd == "buyveh" || cmd == "maiche" ) LangText( "[#FF8000]    !Ba Ni'xiang'yao De Che Kai'dao [#00DB00]Yang'guang'che'zhan(shang'cheng)[#FF8000]Jiu'ke'yi Mai'le =w=", "[#FF8000]    !Just drive a car you want to [#00DB00]Sunshine Show(Shop~) [#FF8000]=w=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
					else if( cmd == "buyprop" ) LangText( "[#FF8000]    ![#00DB00]emmm Sui'ran Shi RPG Dan'shi......[#FF8000] Wo Lan Suo'yi Mei'zuo =3=", "[#FF8000]Although this is [#00DB00]Role Play Game (RPG)[#FF8000], but......I'm so lazy =3=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
					else if( cmd == "gotoprop" ) LangText( "[#FF8000]    ![#00DB00]emmm Sui'ran Shi RPG Dan'shi......[#FF8000] Wo Lan Suo'yi Mei'zuo =3=", "[#FF8000]Although this is [#00DB00]Role Play Game (RPG)[#FF8000], but......I'm so lazy =3=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
					else if( cmd == "goto" || cmd == "bring" || cmd == "fix") LangText( "[#FF8000]    ![#00DB00]RPG[#FF8000] Hai'xiang'zen'yang =3=", "[#FF8000]    !This is a [#00DB00]Role Play Game (RPG)[#FF8000], so you can't use the command =3=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
					else if( cmd == "heal" || cmd == "hp" || cmd == "armour" || cmd == "ap" || cmd == "health" ) LangText( "[#FF8000]    ![#00DB00]RPG[#FF8000] Hai'xiang'zen'yang =3=", "[#FF8000]    !This is a [#00DB00]Role Play Game (RPG)[#FF8000], so you can't use the command =3=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
					else if( cmd == "hz" || cmd == "cc" || cmd == "jy" || cmd == "jcj1" || cmd == "jcj2" || cmd == "f" || cmd == "fight" || cmd == "gd" || cmd == "pizza" || cmd == "dyy" || cmd == "jd" || cmd == "shop" || cmd == "malibu" || cmd == "hotel" || cmd == "park" || cmd == "club" || cmd == "apq" ) LangText( "[#FF8000]    ![#00DB00]RPG[#FF8000] Hai'xiang'zen'yang =3=", "[#FF8000]    !This is a [#00DB00]Role Play Game (RPG)[#FF8000], so you can't use the command =3=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
					else if( cmd == "shit" || cmd == "fuck" || cmd == "noob" || cmd == "cao" || cmd == "sb" || cmd == "mb" || cmd == "gun" || cmd == "tm" || cmd == "nb" || cmd == "tmd") LangText( "[#FFFAFA]  *Ni Hen'bu'shuang Ma? Shi'shi [#00DB00]/report[#FF8000] Kan'kan Wo Neng'bu'neng Bang'zhu Ni =w=", "[#FFFAFA]  *Are you OK? Try [#00DB00]/report[#FF8000] and let me try helping you =w=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
					else if( cmd == "pos" || cmd == "position" || cmd == "postion" || cmd == "zuobiao" || cmd == "where" || cmd == "xyz" || cmd == "mypos" ) MessagePlayer("[#FFFAFA]  *Your Position: [#00CCFF]X: " + player.Pos.x.tostring() + " Y: " + player.Pos.y.tostring() + " Z: " + player.Pos.z.tostring(), player),TXTAddLine("Save/Position.txt","Vector( "+player.Pos+ " );"),PlaySound( player.World , 357 , player.Pos );
					else if( cmd == "car" || cmd == "veh" || cmd == "vehicle" || cmd == "carinfo" || cmd == "vehinfo" || cmd == "vehicleinfo" || cmd == "che")
					{
						if (!player.Vehicle) LangText( "[#FF8000]    !Ni Xian'zai zai Kai'che Miaow? =3=", "[#FF8000]    !Emm..you are not in any car...so what do I do you want...=3=", player.ID, false );
						else
						{
							PlaySound( player.World , 357 , player.Pos );
							local id = player.Vehicle.Model
							local hp = player.Vehicle.Health
							local hpt = hp.tointeger()/10;
							local hpe = hpt.tointeger();
							MessagePlayer("[#FFFAFA]  *Vehicle ID: [#00E3E3]" + player.Vehicle.ID +"[#FFFAFA], Name: [#00E3E3]" + GetVehicleNameFromModel(id) + "[#FFFAFA], Price: [#00E3E3]$" + GetSQLColumnData(QuerySQL(World, "SELECT Price FROM VehiclePrice WHERE VehicleModel='"+player.Vehicle.Model+"'"), 0) + "[#FFFAFA], Owner: [#00E3E3]" + GetSQLColumnData(QuerySQL(World, "SELECT User FROM WorldVehicle WHERE VehID='"+player.Vehicle.ID+"'"), 0) + "[#FFFAFA], Health: [#00E3E3]" + hpe + "%[#FFFAFA].",player);
						}
					}
					else if( cmd == "getcar" || cmd == "getveh" || cmd == "getvehicle" || cmd == "getmycar" || cmd == "getmyveh" || cmd == "getmyvehicle" || cmd == "whereismyveh" || cmd == "wodeche" )
					{
						if (!text) MessagePlayer( "[#FF8000]    !Use !" + cmd + " <Vehicle ID>", player ),PlaySound( player.World , 335 , player.Pos );
						else if (FindVehicle(text.tointeger()))
						{
							if (GetSQLColumnData(QuerySQL(World, "SELECT User FROM WorldVehicle WHERE VehID='"+text.tointeger()+"'"), 0) != player.Name) LangText( "[#FF8000]    !Ni Mei Mai Zhe'liang Che =3=", "[#FF8000]    !You haven't bought this vehicle yet =3=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
							else
							{
								if (Status[player.ID].CanGetVehicle == false) LangText("[#FF8000]    !Zhe me kuai Gan ma---30s Hou Cai'neng Zai'ci Getcar =3=", "[#FF8000]    !Too fast---You should wait 30 seconds~ =3=", player.ID, false),PlaySound( player.World , 335 , player.Pos );
								else
								{
									local vehicle = FindVehicle( text.tointeger() );
									if (!vehicle) LangText("[#FF8000]    !Chu Cuo Le...Zai Shi Yi Bian? =w=", "[#FF8000]    !Error...Try again?? =w=", player.ID, false ),PlaySound( player.World , 335 , player.Pos );
									else
									{
										Progress( player.ID, 2333 )
										NewTimer("Getcar", 2333, 1, player.ID, vehicle.ID)
									}
								}
							}
						}
					}
					else if( cmd == "sellcar" || cmd == "sellveh" || cmd == "sellvehicle" || cmd == "sellmycar" || cmd == "sellmyveh" || cmd == "sellmyvehicle" || cmd == "maiche" || cmd == "maiwodeche" || cmd == "mai")
					{
						if (!text) MessagePlayer( "[#FF8000]    !Use !" + cmd + " <Vehicle ID>", player ),PlaySound( player.World , 335 , player.Pos );
						else if (FindVehicle(text.tointeger()))
						{
							if (GetSQLColumnData(QuerySQL(World, "SELECT User FROM WorldVehicle WHERE VehID='"+text.tointeger()+"'"), 0) != player.Name) LangText( "[#FF8000]    !Ni Mei Mai Zhe'liang Che =3=", "[#FF8000]    !You don't have this vehicle =3=", player.ID, false),PlaySound( player.World , 335 , player.Pos );
							else
							{
								PlaySound(player.World, 50005, player.Pos);
								QuerySQL(World, "UPDATE WorldVehicle SET Owner='None', User='None' WHERE VehID='"+text.tointeger()+"'")
								LangText("[#00DB00]    >Che Mai Le...... =A= Mai le [#00CCFF][$" + (GetSQLColumnData(QuerySQL(World, "SELECT Price FROM VehiclePrice WHERE VehicleModel='"+FindVehicle(text.tointeger()).Model+"'"), 0)-10000).tostring() + "][#FF8000].", "[#00DB00]    >You sold your Car =A= And you Get [#00CCFF][$" + (GetSQLColumnData(QuerySQL(World, "SELECT Price FROM VehiclePrice WHERE VehicleModel='"+FindVehicle(text.tointeger()).Model+"'"), 0)-10000).tostring() + "][#FF8000].", player.ID, false)
								player.Cash += GetSQLColumnData(QuerySQL(World, "SELECT Price FROM VehiclePrice WHERE VehicleModel='"+FindVehicle(text.tointeger()).Model+"'"), 0)-10000;
							}
						}
					}
					else if( cmd == "myveh" || cmd == "myvehicle" || cmd == "ownveh" || cmd == "ownvehicle" || cmd == "mycar" || cmd == "owncar" || cmd == "wodeche" || cmd == "myallveh" || cmd == "myallcar" ) OwnVehicle(player.ID)
					else if(cmd == "exit")
					{
						/*
						player.IsFrozen = true;
						NewTimer( "TeleportCountOn", 1, 1, -378.279,-553.995,18.7649, player.ID );
						LangText("[#00DB00]    >Yi'jing Tui'chu [#00DB00]=w=","[#00DB00]    >Exited [#00DB00]=w=",player.ID,false);
						*/
					}
					else if ( cmd == "givemoney" || cmd == "givecash" || cmd == "give" || cmd == "geiqian" || cmd == "gei")
					{
						if(!text) MessagePlayer( "[#FF8000]    !Use !" + cmd + " <Nick Name/ID> <Ammount>", player ),PlaySound( player.World , 335 , player.Pos );
						else
						{
							local params = split( text, " " ), ammount = params[1], plr;
							if(IsNum(split( text, " " )[0])) plr = FindPlayer(text.tointeger());
							else plr = FindPlayer(text);
							if (!plr) MessagePlayer( "[#FF8000]    !Invalid Player", player ),PlaySound( player.World , 335 , player.Pos );
							else if(!ammount || !IsNum( ammount ) || 0 > ammount.tointeger() ) MessagePlayer( "[#FF8000]    !The Ammount must be integer =3=", player ),PlaySound( player.World , 335 , player.Pos );
							else if ( player.Cash < ammount.tointeger() ) LangText( "[#FFFAFA]  *Ni Mei'dai Zu'gou De Xian'jin =w=","[#FFFAFA]  *You don't have enough cash =w=",player.ID,false ),PlaySound( player.World , 335 , player.Pos );
							else
							{
								PlaySound(player.World, 50005, player.Pos);
								PlaySound(plr.World, 50005, plr.Pos);
								plr.Cash += ammount.tointeger();
								player.Cash -= ammount.tointeger();
								MessagePlayer( "[#00DB00]    >"+GetRGBCode( player.ID )+player.Name+" has given [#FF8000]$"+ammount.tostring()+" [#00DB00]to you.",plr);
								MessagePlayer( "[#00DB00]    >You have given [#FF8000]$"+ammount.tostring()+" [#00DB00]to "+GetRGBCode( plr.ID )+plr.Name+".",player);
							}
						}
					}
					else if( cmd == "bank" || cmd == "mybank" || cmd == "b" || cmd == "acc" || cmd == "account" || cmd == "yinhang" || cmd == "yinghang" || cmd == "yh" )
					{
						if(Status[player.ID].IsInBank == false) LangText("[#FF8000]    !Ni bu zai yinhang li...", "[#FF8000]    !You are not in Bank..", player.ID, false);
						else
						{
							local bank = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
							if ( !bank && bank == 0 ) LangText( "[#FFFAFA]  *CHI'TU LE NI 233 =w=","[#FFFAFA]  *No money in your bank account =w=",player.ID,false ),PlaySound( player.World , 335 , player.Pos );
							else MessagePlayer( "[#FFFAFA]  *There are [#00E3E3]$" + bank.tostring() + " [#FFFAFA]in your bank account =w=",player ),PlaySound( player.World , 357 , player.Pos );
						}
					}

					else if( cmd == "b+" || cmd == "bank+" || cmd == "deposit" || cmd == "d" || cmd == "cun" || cmd == "cunqian")
					{
						if(Status[player.ID].IsInBank == false) LangText("[#FF8000]    !Ni bu zai yinhang li...", "[#FF8000]    !You are not in Bank..", player.ID, false);
						else
						{
							if (!text)
							{
								PlaySound(player.World, 50005, player.Pos);
								local cash = player.Cash;
								local bank = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
								player.Cash = 0;
								QuerySQL(Account, "UPDATE Account SET Bank='"+(bank+cash)+"' WHERE Name='"+player.Name.tolower()+"'");
								local bankb = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
								LangText( "[#00DB00]    >Ni Cun Le [#00E3E3]$" + cash.tostring() + " [#00DB00]Dao Yin'hang Li! Xian'zai Yin'hang Li You [#00E3E3]$" + bankb.tostring() + " [#00DB00]=w=","[#00DB00]    >You deposited [#00E3E3]" + cash.tostring() + " [#00DB00] in the bank! Now there are [#00E3E3]$" + bankb.tostring() + " [#00DB00]in your bank account =w=",player.ID,false );
							}
							else
							{
								local cash = player.Cash;
								local bank = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
								if ( text.tointeger() > cash.tointeger() || 0 > text.tointeger() ) LangText( "[#FFFAFA]  *Ni Mei'dai Zu'gou De Xian'jin =w=","[#FFFAFA]  *You don't have enough cash =w=",player.ID,false ),PlaySound( player.World , 335 , player.Pos );
								else
								{
									PlaySound(player.World, 50005, player.Pos);
									player.Cash -= text.tointeger();
									QuerySQL(Account, "UPDATE Account SET Bank='"+(bank+text.tointeger())+"' WHERE Name='"+player.Name.tolower()+"'");
									local bankb = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
									LangText( "[#00DB00]    >Ni Cun Le [#00E3E3]$" + text.tostring() + " [#00DB00]Dao Yin'hang Li! Xian'zai Yin'hang Li You [#00E3E3]$" + bankb.tostring() + " [#00DB00]=w=","[#00DB00]    >You deposited [#00E3E3]" + text.tostring() + " [#00DB00] in the bank! Now there are [#00E3E3]$" + bankb.tostring() + " [#00DB00]in your bank account =w=",player.ID,false );
								}
							}
						}
					}
					else if( cmd == "b-" || cmd == "bank-" || cmd == "withdraw" || cmd == "w" || cmd == "qu" || cmd == "quqian" )
					{
						if(Status[player.ID].IsInBank == false) LangText("[#FF8000]    !Ni bu zai yinhang li...", "[#FF8000]    !You are not in Bank..", player.ID, false);
						else
						{
							if (!text)
							{
								PlaySound(player.World, 50005, player.Pos);
								local cash = player.Cash;
								local bank = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
								player.Cash = cash + bank.tointeger();
								QuerySQL(Account, "UPDATE Account SET Bank='0' WHERE Name='"+player.Name.tolower()+"'");
								local bankb = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
								LangText( "[#00DB00]    >Ni Qu Le [#00E3E3]$" + cash + " [#00DB00]Cong Ying'hang Li! Xian'zai Ying'hang Li You [#00E3E3]$" + bankb + " [#00DB00]=w=","[#00DB00]    >You withdrew [#00E3E3][" + cash + "] [#00DB00]in the bank! Now there are [#00E3E3]$" + bankb + " [#00DB00]in your bank account =w=",player.ID,false );
							}
							else
							{
								local cash = player.Cash;
								local bank = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
								if ( text.tointeger() > bank.tointeger() || 0 > bank.tointeger()) LangText( "[#FFFAFA]  *Ni'de Ying'hang Li Mei'you Yu'e Le =w=","[#FFFAFA]  *There is not enough balance in your bank account =w=",player.ID,false ),PlaySound( player.World , 335 , player.Pos );
								else
								{
									PlaySound(player.World, 50005, player.Pos);
									player.Cash = cash + text.tointeger();
									QuerySQL(Account, "UPDATE Account SET Bank='"+(bank-text.tointeger())+"' WHERE Name='"+player.Name.tolower()+"'");
									local bankb = GetSQLColumnData(QuerySQL(Account, "SELECT Bank FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
									LangText( "[#00DB00]    >Ni Qu Le [#00E3E3]$" + text + " [#00DB00]Cong Ying'hang Li! Xian'zai Ying'hang Li You [#00E3E3]$" + bankb + " [#00DB00]=w=","[#00DB00]    >You withdrew [#00E3E3]" + text + " [#00DB00]in the bank! Now there are [#00E3E3]$" + bankb + " [#00DB00]in your bank account =w=",player.ID,false );
								}
							}
						}
					}
					else if ( cmd == "score" || cmd == "mykills" || cmd == "mykill" || cmd == "kills" || cmd == "kill" || cmd == "fenshu" || cmd == "sha" || cmd == "stat" || cmd == "stats" || cmd == "status" || cmd == "states" || cmd == "state" )
					{
						PlaySound( player.World , 335 , player.Pos );
						local Kills = GetSQLColumnData(QuerySQL(Account, "SELECT Kills FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
						local Deaths = GetSQLColumnData(QuerySQL(Account, "SELECT Deaths FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0);
						Message("[#FFFAFA]  *<" + GetRGBCode(player.ID) + player.Name + " [#FFFAFA]'s stats: Kills: [#00CCFF]" + Kills + "[#FFFAFA], Deaths: [#00CCFF]" + Deaths + "[#FFFAFA]>*")
					}
					else if ( cmd == "ping" || cmd == "yanchi" || cmd == "p" || cmd == "yc")
					{
						if(!text) MessagePlayer("[#FFFAFA]  *Ping: [#00E3E3]" + player.Ping,player);
						else
						{
							PlaySound( player.World , 335 , player.Pos );
							local plr;
							if(IsNum(text)) plr = FindPlayer(text.tointeger())
							else plr = FindPlayer(text.tostring())
							if (plr) MessagePlayer("[#FFFAFA]  *" + plr.Name + " 's Ping: [#00E3E3]" + plr.Ping,player);
						}
					}
					else if ( cmd == "myping" || cmd == "showping" || cmd == "showmyping")
					{
						Message("[#FFFAFA]  *<" + GetRGBCode( player.ID ) + player.Name + " [#FFFAFA]'s Ping is [#00E3E3]" + player.Ping + "[#FFFAFA]>*");
					}
					else if ( cmd == "fps" || cmd == "currentfps" || cmd == "zhenshu")
					{
						if(!text) MessagePlayer("[#FFFAFA]  *FPS: [#00E3E3]" + player.FPS,player);
						else
						{
							PlaySound( player.World , 335 , player.Pos );
							local plr;
							if(IsNum(text)) plr = FindPlayer(text.tointeger())
							else plr = FindPlayer(text.tostring())
							if (plr) MessagePlayer("[#FFFAFA]  *" + plr.Name + " 's FPS: [#00E3E3]" + plr.FPS,player);
						}
					}
					else if ( cmd == "myfps" || cmd == "showfps" || cmd == "showmyfps")
					{
						PlaySound( player.World , 335 , player.Pos );
						Message("[#FFFAFA]  *<" + GetRGBCode( player.ID ) + player.Name + " [#FFFAFA]'s FPS is [#00E3E3]" + player.FPS + "[#FFFAFA]>*");
					}
					else if ( cmd == "anim" || cmd == "do" || cmd == "dongzuo" || cmd == "zuo" || cmd == "zuodongzuo")
					{
						if(!text || !IsNum(text)) MessagePlayer( "[#FF8000]    !Use !" + cmd + " <AnimID>!", player );
						else
						{
							if(player.Health < 80) MessagePlayer("[#FF8000]    !You are not healthy so you can't do it!", player);
							else
							{
								PlaySound( player.World , 357 , player.Pos );
								player.SetAnim( text.tofloat() );
							}
						}
					}

					else if ( cmd == "sound" || cmd == "wav" || cmd == "playsound" || cmd == "yinyue" || cmd == "bofang")
					{
						if ( !text || !IsNum(text) ) MessagePlayer("[#FF8000]    !Use !" + cmd + " <SoundID>!", player);
						else PlaySoundForPlayer(player, text.tointeger());
					}

					else if ( cmd == "lang" || cmd == "language" || cmd == "changelang" || cmd == "changelanguage" || cmd == "changemylang" || cmd == "yuyan")
					{
						if (text == "cn" || text == "ch" || text == "chn" || text == "pinyin" || text == "py" || text == "chinese" || text == "c" || text == "zhongwen") QuerySQL(Account, "UPDATE Account SET Language='Chinese' WHERE Name='"+player.Name.tolower()+"'"), MessagePlayer("[#00DB00]    >[#00E3E3]Chinese [#FFFAFA]=w=", player);
						else if (text == "en" || text == "eng" || text == "english" || text == "e" || text == "yingwen") QuerySQL(Account, "UPDATE Account SET Language='English' WHERE Name='"+player.Name.tolower()+"'"), MessagePlayer("[#00DB00]    >[#00E3E3]English [#FFFAFA]=w=", player);
						else
						{
							PlaySound( player.World , 357 , player.Pos );
							SendPacketToClient( player, "Sprite", "addlang" );
							QuerySQL(Account, "UPDATE Account SET Language='Selecting' WHERE Name='"+player.Name.tolower()+"'")
							player.IsFrozen = true;
						}
					}

					else if ( cmd == "check" || cmd == "jiancha" || cmd == "hacker" || cmd == "report" || cmd == "report2" || cmd == "findhacker" || cmd == "gb" || cmd == "guabi" || cmd == "g" || cmd == "gua" || cmd == "ifindahacker" || cmd == "takaigua")
					{
						if (Status[player.ID].CanCheck == false) MessagePlayer( "[#FF8000]    !Please try again after 2 minutes" , player ),PlaySound( player.World , 335 , player.Pos );
						else if ( text )
						{
							local plr;
							if(IsNum(text)) plr = FindPlayer(text.tointeger())
							else plr = FindPlayer(text.tostring());
							if(!plr) MessagePlayer( "[#FF8000]    !Invalid Player" , player );
							else
							{
								plr.Pos = plr.Pos;
								CheckPlayer( plr.ID, player.ID);
							}
						}
						else MessagePlayer( "[#FF8000]    !Use !"+cmd+" <Nick Name/ID>" , player ),PlaySound( player.World , 335 , player.Pos );
					}

					else if ( cmd == "class" || cmd == "duiwu" || cmd == "myclass" ) MessagePlayer( "[#FFFAFA]  *Class: [#00E3E3]" + player.Class , player ),PlaySound( player.World , 357 , player.Pos );
					else if ( cmd == "team" || cmd == "myteam") MessagePlayer( "[#FFFAFA]  *Team: [#00E3E3]" + player.Team , player ),PlaySound( player.World , 357 , player.Pos );
					else if ( cmd == "ammo" || cmd == "zidan") MessagePlayer( "[#FFFAFA]  *Ammo: [#00E3E3]" + player.Ammo , player ),PlaySound( player.World , 357 , player.Pos );
					else if ( cmd == "date" || cmd == "riqi" || cmd == "day") MessagePlayer( "[#FFFAFA]  *Time: [#00E3E3]" + GetFullTime(),player),PlaySound( player.World , 357 , player.Pos );
					else if ( cmd == "akina" || cmd == "akinarecord" || cmd == "qiumingshan" || cmd == "qms" || cmd == "laosiji")
					{
						PlaySound( player.World , 335 , player.Pos );
						MessagePlayer("[#FFFAFA]  *Akina 1st: [#00E3E3]" + GetSQLColumnData(QuerySQL(Akina, "SELECT User FROM First"), 0) + "[#FFFAFA], Time: [#00E3E3][" + GetSQLColumnData(QuerySQL(Akina, "SELECT Minute FROM First"), 0) + "'" + GetSQLColumnData(QuerySQL(Akina, "SELECT Second FROM First"), 0) + "''][#FFFAFA]", player)
						MessagePlayer("[#FFFAFA]  *Akina 2nd: [#00E3E3]" + GetSQLColumnData(QuerySQL(Akina, "SELECT User FROM Second"), 0) + "[#FFFAFA], Time: [#00E3E3][" + GetSQLColumnData(QuerySQL(Akina, "SELECT Minute FROM Second"), 0) + "'" + GetSQLColumnData(QuerySQL(Akina, "SELECT Second FROM Second"), 0) + "''][#FFFAFA]", player)
						MessagePlayer("[#FFFAFA]  *Akina 3rd: [#00E3E3]" + GetSQLColumnData(QuerySQL(Akina, "SELECT User FROM Third"), 0) + "[#FFFAFA], Time: [#00E3E3][" + GetSQLColumnData(QuerySQL(Akina, "SELECT Minute FROM Third"), 0) + "'" + GetSQLColumnData(QuerySQL(Akina, "SELECT Second FROM Third"), 0) + "''][#FFFAFA]", player)
					}
					else if ( cmd == "myakina" || cmd == "myrecord" || cmd == "record" || cmd == "myakinarecord" || cmd == "qmschengji" ) MessagePlayer("[#FFFAFA]  *<Your Akina Record (Best): [#00E3E3][" + GetSQLColumnData(QuerySQL(Akina, "SELECT Minute FROM AkinaScore"), 0).tostring() + "'" + GetSQLColumnData(QuerySQL(Akina, "SELECT Second FROM AkinaScore"), 0).tostring() + "''][#FFFAFA]>*", player),PlaySound( player.World , 357 , player.Pos );
					else if ( cmd == "sit" || cmd == "sitdown" || cmd == "zuo" || cmd == "zuoxia") player.SetAnim( 169 );
					else if ( cmd == "admin" || cmd == "adm" || cmd == "administor" || cmd == "fuzhu" || cmd == "info" )
					{
						LangText("[#FFFAFA]  *Zhi you wo! [#66CCFF][RCG]Ctone [#00CCFF](ServerHost)", "[#FFFAFA]  *Only I! [#66CCFF][RCG]Ctone [#00CCFF](ServerHost)", player.ID ,false)
					}
					else if ( cmd == "level" || cmd == "lvl" || cmd == "mylevel" || cmd == "dengji" )
					{
						if(!text)
						{
							local lvll = (GetSQLColumnData(QuerySQL(Account, "SELECT Level FROM Account WHERE Name='"+player.Name.tolower()+"'"), 0)+1)
							MessagePlayer("[#FFFAFA]  *Your are [#00E3E3]Lv." + GetLevel(player.ID) + "[#FFFAFA] and your Exp: [#00E3E3]"+GetExp(player.ID)+"[#FFFAFA], to next level you should get [#00CCFF]" + (LevelExp(lvll).tointeger()-GetExp(player.ID).tointeger()).tostring() + " [#FFFAFA]exp~", player);
						}
						else
						{
							PlaySound( player.World , 335 , player.Pos );
							local plr = FindPlayer(text)
							if (plr) MessagePlayer("[#FFFAFA]  *" + plr.Name + " 's Level: [#00E3E3]" + GetLevel(plr.ID), player);
						}
					}
					else if ( cmd == "cam" || cmd == "camera")
					{
						if(!text || text.find(" ") == 0) MessagePlayer("[#FF8000]    !Use !"+cmd+" <PosX> <PosY> <PosZ>")
						else
						{
							PlaySound(player.World, 50005, player.Pos);
							local pr = split( text, " " )
							player.SetCameraPos( Vector(pr[0].tointeger(),pr[1].tointeger(),pr[2].tointeger()), player.Pos );
							MessagePlayer("[#00DB00]    >Set camera to [#00CCFF]X:"+pr[0].tointeger().tostring()+" Y:"+pr[1].tointeger().tostring()+" Z:"+pr[2].tointeger().tostring()+" [#00DB00]and look at you~ Use [#00CCFF]!restore [#00DB00]to restore camera~",player);
						}
					}
					else if ( cmd == "rest" || cmd == "restore" || cmd == "restorecamera") player.RestoreCamera(), MessagePlayer("[#00DB00]    >Restored camera~",player);
					else if (cmd == "hide")
					{
						if(text)
						{
							if(text.tolower() == "on") player.IsOnRadar = false, MessagePlayer( "[#00DB00]    >You are invisible on radar!", player ), PlaySound(player.World, 50002, player.Pos);
							else if(text.tolower() == "off") player.IsOnRadar = true, MessagePlayer( "[#00DB00]    >You are visible on radar!", player ), PlaySound(player.World, 50005, player.Pos);
						}
						else
						{
							player.IsOnRadar = !player.IsOnRadar;
							if( player.IsOnRadar ) MessagePlayer( "[#00DB00]    >You are visible on radar!", player ), PlaySound(player.World, 50002, player.Pos);
							else if( !player.IsOnRadar ) MessagePlayer( "[#00DB00]    >You are invisible on radar!", player ), PlaySound(player.World, 50005, player.Pos);
						}
					}
					else if (cmd == "model") MessagePlayer("Model ID: "+player.Vehicle.Model, player)
					else LangText("[#FF8000]    !Shenmegui >_< [#00E3E3]F2 [#FF8000]=w=","[#FF8000]    !I don't know that command, please press [#00E3E3]F2 [#FF8000]=w=", player.ID,false ),PlaySound( player.World , 335 , player.Pos );
				}
				else LangText("[#FF8000]    !Ni Hai'mei'you [#FF8000]Deng'lu!","[#FF8000]    !You haven't [#FF8000]Logged yet!",player.ID,false),PlaySound( player.World , 335 , player.Pos );
			}
		}
		catch(e) timeprint( "脚本发现错误啦QAQ - 玩家指令!版那儿出现了" + e + "的错误, 这个时候是[" + GetFullTime() + "].");
	}
}

function onPlayerPM( player, playerTo, message )
{
	if (!player.Vehicle && player.Health != 0 && player.IsFrozen == false)
	{
		PlaySoundForPlayer(player, 50001);
		PlaySoundForPlayer(player, 50001);
	}
	return 1;
}

function onPlayerBeginTyping( player )
{
	if (!player.Vehicle && player.Health != 0 && player.IsFrozen == false)
	{
		PlaySoundForPlayer(player, 50001);
		PlaySoundForPlayer(player, 50001);
	}
}

function onPlayerEndTyping( player )
{
	if (!player.Vehicle && player.Health != 0 && player.IsFrozen == false)
	{
		PlaySoundForPlayer(player, 50001);
		PlaySoundForPlayer(player, 50001);
	}
}
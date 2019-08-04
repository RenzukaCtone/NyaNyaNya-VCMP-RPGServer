class PlayerClass
{
	IsLogin = false;
	CanCheck = true;
	CanTeleport = true;
	CanPutup = false;
	CheckingStep = 0;
	IsReady = false;
	IsReady2 = false;
	IsRacingAkina = false;
	IsBuyingSth = false;
	IsBuyingVehicle = false;
	IsBuyingWeapon = false;
	IsBuyingClothes = false;
	IsBuyingHotelticket = false;
	IsBuyingRCGHotelticket = false;
	IsBuyingPizza = false;
	IsStealingHotel = false;
	CanGetVehicle = true;
	VehicleCol1 = 0;
	VehicleCol2 = 0;
	ViewVehicleCol1 = 0;
	ViewVehicleCol2 = 0;
	ViewVehicleColor = 1
	ViewWeapon = 0;
	ViewClothes = 0;
	ViewJob = "";
	ViewTeam = null;
	IsEnteringVRS1 = false;
	IsEnteringVRS2 = false;
	IsStunting = false;
	StuntHigh = 0.0;
	StuntFHigh = 0.0;
	IsLoaded = false;
	ActiveDay = "";
	IsYSWorking = false;
	IsFighting = false;
	StopProgress = false;
	IsWorking = false;
	IsHealing = false;
	WheretoHeal = null;
	IsInBank = false;
	IsNew = true;
	TimerValue = 0;
	TimerState = false;
	Admin = false;
	DistrictName = null;
	IsLookingMenu = false;
	NearPlr = null;
	Language = null;
	VehDamage = 0;
	DamageEffectLoop = 0;
	SpeedEffectLoop = 0;
	AAAAAAEffectLoop = 0;
	Dontstop = false;
	wocOK = false;
	BadTime = 0;
	cpid = 0;
}

function onServerStart()
{
	timeprint("\r\r\rNyaNyaNyaのReal Life 服务器已成功运行 =w=");
	NewTimer("onScriptLoadInfo", 300, 1);
}

function onServerStop()
{
	timeprint("\r\r\rNyaNyaNyaのReal Life 服务器已停止运行 =a=");
	SetGameModeName("Unknown");
	SetServerName("The server is not running...");
}

function onScriptLoad()
{
	timeprint("\r\r\r	")
	local c = GetTickCount();
	dofile("Player.nut");
	dofile("Chat.nut");
	dofile("Vehicle.nut");
	dofile("Map.nut")
	dofile("Function.nut");
	timeprint("\r\r\r成功加载脚本 =w=")
	LoadVehicles();
	timeprint("\r\r\r成功加载车辆 =w=")
	
	//SQLite
	Account <- ConnectSQL( "Data/Account.db" );
	World <- ConnectSQL( "Data/World.db" );
	Akina <- ConnectSQL( "Data/Akina.db" )
	IpToCountryDB <- ConnectSQL( "Data/IpToCountry.db" )

	Status <- array(GetMaxPlayers(), null);
	
	YSWorkMarker <- array(GetMaxPlayers(), null);
	DoctorSphere <- array(GetMaxPlayers(), null);
	
	InterestingNow <- 0;

	//Settings
	SetServerName("喵喵喵にゃんにゃんにゃんNyaNyaNyaのRealLife Server! V2.0.123 [15MB]");
	SetGameModeName( "刚刚开,里边请" );
	SetWastedSettings( 4096, 2048, 2.0, 3.0, RGB(1 , 1, 1), 4000, 2000 );
	SetMaxPlayers( 50 );
	SetFriendlyFire( false );
	SetShowOnRadar( true );
	SetShowNametags( true );
	SetWeather( 4 );
	SetHour( date().hour );
	SetMinute( date().min );
	SetTimeRate( 60000 );
	SetSpawnPlayerPos( -1513.53, -926.914, 19.862 );
	SetSpawnCameraPos( -1515.36, -942.921, 23.222 );
	SetSpawnCameraLook( -1511.53, -935.914, 20.362 );
	SetWorldBounds( 5000.0, -5000.0, 5000.0, -5000.0 );
	SetSyncFrameLimiter( true );
	SetFrameLimiter( false );
	SetTaxiBoostJump( true );
	SetDriveOnWater( false );
	SetDrivebyEnabled( true );
	SetPerfectHandling( false );
	SetFlyingCars( false );
	SetStuntBike( true );
	SetFastSwitch( false );
	SetJumpSwitch( true );
	SetShootInAir( false );
	SetGravity( 0.008 );
	SetGamespeed( 1.0 );
	SetWaterLevel( 6.0 );
	SetMaxHeight( 999999999.0 );
	SetJoinMessages( false );
	SetDeathMessages( false );
	SetVehiclesForcedRespawnHeight( 999999999.0 );
	SetPassword( "" );
	SetWallglitch( false );

	//BindKey
	LMB <- BindKey(true, 0x01, 0, 0);
	A <- BindKey(true, 0x41, 0, 0);
	D <- BindKey(true, 0x44, 0, 0);
	Left <- BindKey(true, 0x25, 0, 0);
	Up <- BindKey(true, 0x26, 0, 0);
    Right <- BindKey(true, 0x27, 0, 0);
	Down <- BindKey(true, 0x28, 0, 0);
	L <- BindKey(true, 0x4C, 0, 0);
	B <- BindKey(true, 0x42, 0, 0);
	C <- BindKey(true, 0x43, 0, 0);
	E <- BindKey(true, 0x45, 0, 0);
	F <- BindKey(true, 0x46, 0, 0);
	F2 <- BindKey(true, 0x71, 0, 0);
	LShift <- BindKey(true, 0x10, 0, 0);
	RShift <- BindKey(true, 0xA1, 0, 0);
	Space <- BindKey(true, 0x20, 0, 0);
	Backspace <- BindKey(true, 0x08, 0, 0);
	Alt <- BindKey(true, 0x12, 0, 0);
	TAB <- BindKey(true, 0x09, 0, 0);
	Ctrl <- BindKey(true, 0x11, 0, 0);

	//Checkpoint
	AkinaStart <- CreateCheckpoint( null, 0, false, Vector(631.1151, 928.0783, 14.4474), RGB(255, 128, 192), 10);
	AkinaEnd <- CreateCheckpoint( null, 0, false, Vector(946.1308, 318.3987, 395.1787), RGB(255, 128, 192), 10);
	ARS1 <- CreateCheckpoint( null, 0, false, Vector(940.1308, 324.3987, 394.3955), RGB(255, 255, 255), 5);

	WeaponShop1 <- CreateCheckpoint( null, 0, true, Vector(-677.1649, 1203.3855, 11.1095), RGB(255, 192, 168), 2);
	WeaponShop2 <- CreateCheckpoint( null, 0, true, Vector(364.4051, 1055.9058, 19.209), RGB(255, 192, 168), 2);
	WeaponShop3 <- CreateCheckpoint( null, 0, true, Vector(-63.5889, -1481.49, 10.4862), RGB(255, 192, 168), 2);

	ToolShop1 <- CreateCheckpoint( null, 0, true, Vector(364.4089, 1078.1033, 19.0685), RGB(255, 255, 255), 2);

	ClothesShop <- CreateCheckpoint( null, 0, true, Vector(413.9041, 1038.61, 25.2998), RGB(255, 255, 255), 2);

	PizzaShop1 <- CreateCheckpoint( null, 0, true, Vector(450.5424, 1145.5632, 19.2365), RGB(255, 255, 255), 2);
	PizzaShop2 <- CreateCheckpoint( null, 0, true, Vector(435.9095, 1139.2555, 19.1922), RGB(255, 255, 255), 2);
	PizzaShop3 <- CreateCheckpoint( null, 0, true, Vector(435.5623, 1107.5864, 19.1935), RGB(255, 255, 255), 2);
	PizzaShop4 <- CreateCheckpoint( null, 0, true, Vector(451.4671, 1101.062, 19.2198), RGB(255, 255, 255), 2);
	PizzaShop5 <- CreateCheckpoint( null, 0, true, Vector(421.497, 87.8682, 11.2623), RGB(255, 255, 255), 2);
	PizzaShop6 <- CreateCheckpoint( null, 0, true, Vector(-851.771, -634.596, 11.3733), RGB(255, 255, 255), 2);

	RCGHotel <- CreateCheckpoint( null, 0, true, Vector(-773.7563, 132.6905, 10.9544), RGB(255, 255, 255), 2);

	LVehicleFix1 <- CreateCheckpoint( null, 0, true, Vector(-871.4412, -118.4327, 11.0942), RGB(255, 255, 255), 3);
	LVehicleFix2 <- CreateCheckpoint( null, 0, true, Vector(-10.6165, -1257.7351, 10.4633), RGB(255, 255, 255), 3);

	VehicleFix1 <- CreateCheckpoint( null, 0, true, Vector(-881.895, -112.902, 11.1034), RGB(255, 255, 255), 3);
	VehicleFix2 <- CreateCheckpoint( null, 0, true, Vector(-2.811, -1257.8042, 10.4633), RGB(255, 255, 255), 3);

	StuntCheckpoint1 <- CreateCheckpoint( null, 0, false, Vector(437.3277, -325.7116, 10.5844), RGB(255, 255, 255), 3);
	StuntCheckpoint2 <- CreateCheckpoint( null, 0, false, Vector(455.352, -118.488, 10.6076), RGB(255, 255, 255), 3);
	StuntCheckpoint3 <- CreateCheckpoint( null, 0, false, Vector(-844.049, -925.48, 11.1084), RGB(255, 255, 255), 3);
	//Little Checkpoint
	StuntCheckpoint4 <- CreateCheckpoint( null, 0, false, Vector(456.168, -493.936, 11.0443), RGB(255, 255, 255), 2);
	StuntCheckpoint5 <- CreateCheckpoint( null, 0, false, Vector(465.071, -506.549, 11.0101), RGB(255, 255, 255), 2);
	StuntCheckpoint6 <- CreateCheckpoint( null, 0, false, Vector(375.67, -699.151, 10.9476), RGB(255, 255, 255), 2);
	StuntCheckpoint7 <- CreateCheckpoint( null, 0, false, Vector(260.048, -941.364, 10.4564), RGB(255, 255, 255), 2);
	StuntCheckpoint8 <- CreateCheckpoint( null, 0, false, Vector(217.695, -1155.72, 10.9385), RGB(255, 255, 255), 2);
	StuntCheckpoint9 <- CreateCheckpoint( null, 0, false, Vector(472.559, -522.221, 11.1369), RGB(255, 255, 255), 2);

	HotelHost <- CreateCheckpoint( null, 0, true, Vector(216.1397, -1272.3018, 12.0923), RGB(255, 255, 255), 2);
	HotelGuest <- CreateCheckpoint( null, 0, true, Vector(216.5506, -1275.1959, 12.0905), RGB(255, 255, 255), 2);
	HotelEnter <- CreateCheckpoint( null, 0, true, Vector(208.9558, -1288.7457, 12.3885), RGB(255, 255, 255), 2);
	HotelExitdoor <- CreateCheckpoint( null, 0, true, Vector(226.1971, -1276.2518, 19.2712), RGB(255, 255, 255), 2);

	FightEnterdoor <- CreateCheckpoint( null, 0, true, Vector(-1720.6895, -156.2967, 14.8683), RGB(255, 255, 255), 2);
	FightExitdoor <- CreateCheckpoint( null, 0, true, Vector(-1723.683, -156.2967, 14.8683), RGB(255, 255, 255), 2);

	AirportExit1 <- CreateCheckpoint( null, 0, false, Vector(-1464.2178, -830.5505, 14.8714), RGB(255, 255, 255), 2);
	AirportExit2 <- CreateCheckpoint( null, 0, false, Vector(-1407.28, -832.263, 14.8715), RGB(255, 255, 255), 2);

	YSWork <- CreateCheckpoint(null, 0, true, Vector(-905.304, -1404.38, 11.7892), RGB(6, 255, 56), 5);
	YSWorkEnd <- CreateCheckpoint(null, 0, true, Vector(-17.9337, 942.547, 10.9402), RGB(255, 51, 51), 5);

	Sunshine <- CreateCheckpoint( null, 0, true, Vector(-1011.6929, -882.9532, 12.8868), RGB(255, 255, 255), 3);
	
	BankDoor <- CreateCheckpoint( null, 0, true, Vector(-897.42, -340.982, 13.3802), RGB(255, 255, 255), 3);
	BankAccount <- CreateCheckpoint( null, 0, true, Vector(-909.711, -347.026, 13.3802), RGB(255, 255, 255), 3);
	
	PoliceStationDoor <- CreateCheckpoint( null, 0, true, Vector(480.061, -508.797, 11.1041), RGB(255, 255, 255), 2);

	NKenOffice <- CreateCheckpoint( null, 0, true, Vector(118.105, -825.992, 10.4633), RGB(255, 255, 255), 2);
	NClothesShop <- CreateCheckpoint( null, 0, true, Vector(95.4908, -1135.47, 10.4621), RGB(255, 255, 255), 2);
	NShop1 <- CreateCheckpoint( null, 0, true, Vector(79.7496, -880.668, 10.4453), RGB(255, 255, 255), 2);
	NShop2 <- CreateCheckpoint( null, 0, true, Vector(103.969, -897.691, 10.4319), RGB(255, 255, 255), 2);
	NShop3 <- CreateCheckpoint( null, 0, true, Vector(142.122, -843.108, 10.4318), RGB(255, 255, 255), 2);
	NHotel1 <- CreateCheckpoint( null, 0, true, Vector(422.736, -662.768, 11.0712), RGB(255, 255, 255), 2);
	NHotel2 <- CreateCheckpoint( null, 0, true, Vector(440.027, -622.894, 11.0712), RGB(255, 255, 255), 2);
	NHotel3 <- CreateCheckpoint( null, 0, true, Vector(484.086, -479.899, 12.0508), RGB(255, 255, 255), 2);
	NHotel4 <- CreateCheckpoint( null, 0, true, Vector(480.061, -508.797, 11.1041), RGB(255, 255, 255), 2);
	
	//props
	DowntownProp1 <- CreatePickup( 407, Vector(-730.379, 356.114, 11.1007) );
	DowntownProp2 <- CreatePickup( 407, Vector(-728.857, 365.77, 11.1007) );
	DowntownProp3 <- CreatePickup( 407, Vector(-727.427, 375.344, 11.1007) );
	//nice props
	NiceProp1 <- CreatePickup( 407, Vector(-872.905, -266.711, 11.0713) );
	//yiban props
	DowntownProp4 <- CreatePickup( 407, Vector(-889.413, -406.329, 13.382) );
	DowntownProp5 <- CreatePickup( 407, Vector(-889.602, -399.333, 13.382) );
	//yibanban
	DowntownProp6 <- CreatePickup( 407, Vector(-845.389, -1034.89, 12.4458) );
	DowntownProp7 <- CreatePickup( 407, Vector(-846.968, -1018.03, 12.4467) );
	DowntownProp8 <- CreatePickup( 407, Vector(-847.794, -1001.72, 12.4661) );
	//beach props
	OceanProp1 <- CreatePickup( 407, Vector(276.725, -987.746, 11.9754) );
	OceanProp2 <- CreatePickup( 407, Vector(292.069, -943.243, 11.9914) );
	OceanProp3 <- CreatePickup( 407, Vector(377.964, -750.544, 11.9914) );
	OceanProp4 <- CreatePickup( 407, Vector(367.245, -777.543, 11.0713) );
	OceanProp5 <- CreatePickup( 407, Vector(400.179, -706.675, 11.0661) );
	OceanProp6 <- CreatePickup( 407, Vector(467.171, -558.131, 11.9914) );
	OceanProp7 <- CreatePickup( 407, Vector(485.116, -432.656, 10.9316) );

	
	
	//Marker
	AkinaStartM <- CreateMarker(0, Vector(631.1151, 928.0783, 14.4474), 3, RGB(255, 255, 255), 101 );
	AkinaEndM <- CreateMarker(0, Vector(946.1308, 318.3987, 395.1787), 3, RGB(255, 255, 255), 102 );

	WeaponShop1M <- CreateMarker(0, Vector(-677.1649, 1203.3855, 11.1095), 2, RGB(255, 255, 255), 16);
	WeaponShop2M <- CreateMarker(0, Vector(364.4051, 1055.9058, 19.209), 2, RGB(255, 255, 255), 16);
	WeaponShop3M <- CreateMarker(0, Vector(-45.6347, -1489.0942, 10.5402), 2, RGB(255, 255, 255), 16);

	ToolShop1M <- CreateMarker(0, Vector(364.4089, 1078.1033, 19.0685), 2, RGB(255, 255, 255), 16);

	ClothesShopM <- CreateMarker(0, Vector(413.9041, 1038.61, 25.2998), 2, RGB(255, 255, 255), 28);

	RCGHotelM <- CreateMarker(0, Vector(-773.7563, 132.6905, 10.9544), 2, RGB(255, 255, 255), 19);

	VehicleFix1M <- CreateMarker(0, Vector(-877.4412, -118.4327, 11.0942), 2, RGB(255, 255, 255), 27);
	VehicleFix2M <- CreateMarker(0, Vector(-2.811, -1257.8042, 10.4633), 2, RGB(255, 255, 255), 27);

	HotelGuestM <- CreateMarker(0, Vector(216.5506, -1275.1959, 12.0905), 2, RGB(255, 255, 255), 19);

	AirportExitM <- CreateMarker(0, Vector(-1464.2178, -830.5505, 14.8714), 2, RGB(255, 255, 255), 17);

	mansionM <- CreateMarker(0, Vector(-378.1037, -539.3962, 17.2836), 2, RGB(255, 255, 255), 29);
	shipyardM <- CreateMarker(0, Vector(-715.9627,-1269.9739,10.6145), 2, RGB(255, 255, 255), 12);
	clubM <- CreateMarker(0, Vector(-715.9627,-1269.9739,10.6145), 2, RGB(255, 255, 255), 13);
	
	//Weapon
	
	//Team Pickup
	mansion <- CreatePickup( 382, Vector(-378.1037, -539.3962, 17.2836) );
	akina <- CreatePickup( 382, Vector(601.0229, 933.2081, 14.9907) );
	lighthouse <- CreatePickup( 382, Vector(468.728,-1728.5,11.2713) );
	shipyard <- CreatePickup( 382, Vector(-715.9627,-1269.9739,10.6145) );
	club <- CreatePickup( 382, Vector(495.6708,-84.0617,10.0301) );
	ps1 <- CreatePickup( 382, Vector(398.8927,-470.0166,11.7342) );
	ps11 <- CreatePickup( 382, Vector(-872.235, -682.8079, 11.2292) );
	ps2 <- CreatePickup( 382, Vector(-660.9728, 758.5878, 11.0848) );
	barback <- CreatePickup( 382, Vector(-1717.35, -286.97, 14.8683) );
	hotel <- CreatePickup( 382, Vector(237.8748,-1279.4635,11.0712) );
	
	//Job Pickup
	Doctor1 <- CreatePickup( 508, Vector(-887.587, -470.309, 13.1114) );
	
	//Function Pickup
	SunshinePickup <- CreatePickup( 408, Vector(-1011.6929, -882.9532, 15.8868) );
	
	//Health Pickup
	health1 <- CreatePickup( 366, Vector(-887.559, -474.379, 12.5355) );
	health2 <- CreatePickup( 366, Vector(-887.559, -466.379, 12.5355) );
	
	HideMapObject( 1573, -874.696, -116.696, 11.9875 );
	HideMapObject( 3013, -7.80468, -1257.64, 10.8187 );
	
	DVehicleFix1 <- CreateObject( 3013, 0, Vector(-874.696, -116.696, 11.9875), 255 );
	DVehicleFix2 <- CreateObject( 3013, 0, Vector(-7.80468, -1257.64, 10.8187), 255 );
	
	//豪宅前 去除杂草与杂树
	HideMapObject( 2492, -415.957, -512.32, 16.4688 );
	HideMapObject( 2540, -381.827, -504.757, 15.4651 );
	HideMapObject( 449, -294.215, -502.572, 10.0196 );
	HideMapObject( 449, -312.05, -502.572, 10.0196 );
	HideMapObject( 449, -337.536, -503.151, 10.0196 );
	HideMapObject( 449, -369.135, -503.151, 10.0196 );
	
	//移除原版Fight
	//HideMapObject( 1083, -1754.6, -198.627, 13.8146 );
	//HideMapObject( 1155, -1718.54, -160.154, -4.28964 );

	//Radio
	/*Not available
	CreateRadioStream( 15, "Tong Hua Zhen - Chen Yi Fa er", "http://zy.tt6.cn/m/zy/%E9%99%88%E4%B8%80%E5%8F%91%E5%84%BF%20-%20%E7%AB%A5%E8%AF%9D%E9%95%87.mp3", true );
	CreateRadioStream( 16, "Dong Jing Bu Tai Re (Tokyo isn't so hot) - [#66CCFF]Luo Tian Yi", "http://zy.tt6.cn/m/zy/%E6%B4%9B%E5%A4%A9%E4%BE%9D%20-%20%E4%B8%9C%E4%BA%AC%E4%B8%8D%E5%A4%AA%E7%83%AD.mp3", true );
	CreateRadioStream( 17, "Su Yan - Vae", "http://zy.tt6.cn/m/zy/%E8%AE%B8%E5%B5%A9%20-%20%E7%B4%A0%E9%A2%9C.mp3", true );
	CreateRadioStream( 18, "Racing Car - Unknown", "http://zy.tt6.cn/m/zy/%E9%A3%9E%E8%BD%A6%E5%85%9A%E4%B8%93%E7%94%A8%E8%83%8C%E6%99%AF%E9%9F%B3%E4%B9%90.mp3", true );
	CreateRadioStream( 19, "Shuang Ren Wu - WhiteMouse", "http://zy.tt6.cn/m/zy/%E4%BC%8A%E4%B8%BD%E8%8E%8E%E7%99%BD%E9%BC%A0%20-%20%E5%8F%8C%E4%BA%BA%E8%88%9E.mp3", true );
	CreateRadioStream( 20, "[ZheXue]Seve - MiaowmiaowPapaSi", "http://zy.tt6.cn/m/zy/%E5%96%B5%E5%96%B5%E5%B8%95%E5%B8%95%E6%96%AF%20-%20%E3%80%90%E5%93%B2%E5%AD%A6%E3%80%91seve%E2%99%82.mp3", true );
	CreateRadioStream( 21, "Are you OK? (Angelina) - Lei Jun (XiaomiCEO)", "http://zy.tt6.cn/m/zy/AreYouOK.mp3", true );
	CreateRadioStream( 22, "~Secret Base~ - Kayano Ai&Tomatsu Haruka&Hayami Saori", "http://zy.tt6.cn/m/zy/WEIWENHUAMIN.mp3", true );
	CreateRadioStream( 23, "Hop - Azis", "http://zy.tt6.cn/m/zy/Azis%20-%20Hop.mp3", true );
	CreateRadioStream( 24, "aLIEz - Mizuki", "http://zy.tt6.cn/m/zy/Aliez(mZkver.).mp3", true );
	CreateRadioStream( 25, "Fade - Alan Walker", "http://zy.tt6.cn/m/zy/Alan%20Walker%20-%20Fade.mp3", true );
	CreateRadioStream( 26, "Unity - TheFatRat", "http://zy.tt6.cn/m/zy/TheFatRat%20-%20Unity.mp3", true );
	*/

	//棕椰岛 by 老俗 (已授权)
	//LoadZYIsland();
	
	//Restore Akina
	local namea = GetSQLColumnData(QuerySQL(Akina, "SELECT Name FROM First WHERE TH='First'"), 0);
	local nameb = GetSQLColumnData(QuerySQL(Akina, "SELECT Name FROM Second WHERE TH='Second'"), 0);
	local namec = GetSQLColumnData(QuerySQL(Akina, "SELECT Name FROM Third WHERE TH='Third'"), 0);

	if ( !namea ) QuerySQL(Akina, "UPDATE First SET Name='None', User='None'");
	if ( !nameb ) QuerySQL(Akina, "UPDATE Second SET Name='None', User='None'");
	if ( !namec ) QuerySQL(Akina, "UPDATE Third SET Name='None', User='None'");

	timeprint("\r\r\r服务器加载完毕, 耗时" + (GetTickCount()-c).tostring() + "ms =w=");
}

function onScriptUnload()
{
	SaveData();
	timeprint("\r\r\rNyaNyaNyaのReal Life 数据已保存.");
}

function onConsoleInput( cmd, text )
{
	timeprint( "\r\r\r重新加载脚本..." );
	ReloadScripts();
}

function onClientScriptData(player)
{
	local mode = Stream.ReadString().tolower();
	if(mode == "register") Register(player.ID, Stream.ReadString())
	else if(mode == "login") Login(player.ID, Stream.ReadString())
	else if(mode == "vehspeedpos") VehicleDamage(player.ID, Stream.ReadInt(), Stream.ReadInt())
}

function timeprint(printstring)
{
	print("\r\r\r["+GetFullTimeWithoutSec()+"] "+printstring)
}

function GetFullTimeWithoutSec()
{
	local time = date(), sec = FixTime(time.sec), min = FixTime(time.min), hr = FixTime(time.hour), day = FixTime(time.day), mon = FixTime(time.month += 1), year = time.year;
	return year+"/"+mon+"/"+day+" "+hr+":"+min;
}

function GetFullTime()
{
	local time = date(), sec = FixTime(time.sec), min = FixTime(time.min), hr = FixTime(time.hour), day = FixTime(time.day), mon = FixTime(time.month += 1), year = time.year;
	return year+"/"+mon+"/"+day+" - "+hr+":"+min+":"+sec;
}

function GetYear() return FixTime(date().year)
function GetMonth() return FixTime(date().month+1)
function GetDay() return FixTime(date().day)
function GetHour() return FixTime(date().hour)
function GetMin() return FixTime(date().min)
function GetSec() return FixTime(date().sec)
function FixTime(value)
{
	if (value < 10) return "0" + value;
	else return value;
}

function onScriptLoadInfo()
{
	timeprint("\r\r\r	");
	timeprint("\r\r\r----------NyaNyaNyaのReal Life 服务器 已启动 | 游戏模式: 角色扮演:模拟人生(RPG) | 插件版本: 04rel006 | 服务器版本: V2.0.629----------");
	timeprint("这个时候是:" + GetFullTime());
	timeprint("加载信息:");
	timeprint("已加载9个脚本 / " + GetObjectCount() + "个物品 / " + GetVehicleCount() + "辆车。");
	//CheckPing();
	timeprint("服务器循环监视Ping值系统已被禁用。");
	RandomWeather();
	timeprint("服务器循环更新天气系统启用。");
	SetRandomGameModeName( true );
	timeprint("服务器循环更新游戏模式名系统启用。");
	SetRandomMessages( true );
	timeprint("服务器循环发送信息系统启用。");
	CheckWanted();
	//CheckDistrict();
	timeprint("服务器显示地名系统已被禁用。");
}
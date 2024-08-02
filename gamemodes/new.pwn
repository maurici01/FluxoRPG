#include <a_samp>
#include <dini>
#include <zcmd>
#include <sscanf2>

main()
{
	print("\n___ == ____ == ___ == ___ ==");
	print(" Gamemode: FLUXO RPG");
	print("___ == ____ == ___ == ___ ==\n");
}

#define ConvertDays(%0) (gettime() + (86400 * (%0)))

#define Dialog_InserirSenha 44
#define Dialog_InserirSenhaRegistro 55

new PlayerText:PText_Login[MAX_PLAYERS][8]; // variaveis da textdraw para login

new Text:Text_Login[20];
new SenhaLogin[MAX_PLAYERS][16];
new SenhaRegistro[MAX_PLAYERS][16];

new bool:DigitouSenhaLogin[MAX_PLAYERS];
new bool:DigitouSenhaRegistro[MAX_PLAYERS];


enum Player
{
	pFome,
	pSede,
	pSono,
	pGenero,
	pGrana,
	pSkin,
	pAdmin,
	pPresoAdmin,
	pMinutosAdmin,
	pSegundosAdmin
};

new pInfo[MAX_PLAYERS][Player];
new PlayerText:Text_Hud[MAX_PLAYERS][9];
new Text:Text_Dormindo[1];
new bool:Dormindo[MAX_PLAYERS];
new DiasBan[MAX_PLAYERS];
new bool:Assistindo[MAX_PLAYERS];
new bool:TrabalhandoAdmin[MAX_PLAYERS];
new SkinStaff[MAX_PLAYERS];
new TimerCadeia[MAX_PLAYERS];
new PlayerText:Text_Timer[MAX_PLAYERS][1];

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("FLUXO RPG!");

	Text_Dormindo[0] = TextDrawCreate(-1.333347, -3.303695, "box");
	TextDrawLetterSize(Text_Dormindo[0], 0.000000, 51.599990);
	TextDrawTextSize(Text_Dormindo[0], 727.000000, 0.000000);
	TextDrawAlignment(Text_Dormindo[0], 1);
	TextDrawColor(Text_Dormindo[0], -1);
	TextDrawUseBox(Text_Dormindo[0], 1);
	TextDrawBoxColor(Text_Dormindo[0], 255);
	TextDrawSetShadow(Text_Dormindo[0], 0);
	TextDrawBackgroundColor(Text_Dormindo[0], 255);
	TextDrawFont(Text_Dormindo[0], 1);
	TextDrawSetProportional(Text_Dormindo[0], 1);

	//Sistema de login [TextDraw-TDE]
	Text_Login[0] = TextDrawCreate(116.875000, 126.416648, "box");
	TextDrawLetterSize(Text_Login[0], 0.000000, 27.687500);
	TextDrawTextSize(Text_Login[0], 290.000000, 0.000000);
	TextDrawAlignment(Text_Login[0], 1);
	TextDrawColor(Text_Login[0], -1);
	TextDrawUseBox(Text_Login[0], 1);
	TextDrawBoxColor(Text_Login[0], 184);
	TextDrawSetShadow(Text_Login[0], 0);
	TextDrawBackgroundColor(Text_Login[0], 255);
	TextDrawFont(Text_Login[0], 1);
	TextDrawSetProportional(Text_Login[0], 1);

	Text_Login[1] = TextDrawCreate(298.125000, 126.416687, "box");
	TextDrawLetterSize(Text_Login[1], 0.000000, 27.687500);
	TextDrawTextSize(Text_Login[1], 563.000000, 0.000000);
	TextDrawAlignment(Text_Login[1], 1);
	TextDrawColor(Text_Login[1], -1);
	TextDrawUseBox(Text_Login[1], 1);
	TextDrawBoxColor(Text_Login[1], 184);
	TextDrawSetShadow(Text_Login[1], 0);
	TextDrawBackgroundColor(Text_Login[1], 137);
	TextDrawFont(Text_Login[1], 1);
	TextDrawSetProportional(Text_Login[1], 1);

	Text_Login[2] = TextDrawCreate(158.058502, 129.916671, "FLUXO_RPG");
	TextDrawLetterSize(Text_Login[2], 0.520455, 1.940412);
	TextDrawTextSize(Text_Login[2], 351.000000, 0.000000);
	TextDrawAlignment(Text_Login[2], 1);
	TextDrawColor(Text_Login[2], -16711824);
	TextDrawSetShadow(Text_Login[2], -1);
	TextDrawBackgroundColor(Text_Login[2], 255);
	TextDrawFont(Text_Login[2], 3);
	TextDrawSetProportional(Text_Login[2], 0);

	Text_Login[3] = TextDrawCreate(126.875000, 190.000030, "login");
	TextDrawLetterSize(Text_Login[3], 0.264997, 1.109997);
	TextDrawTextSize(Text_Login[3], -218.000000, 0.000000);
	TextDrawAlignment(Text_Login[3], 1);
	TextDrawColor(Text_Login[3], -1);
	TextDrawSetShadow(Text_Login[3], 0);
	TextDrawBackgroundColor(Text_Login[3], 255);
	TextDrawFont(Text_Login[3], 2);
	TextDrawSetProportional(Text_Login[3], 1);

	Text_Login[4] = TextDrawCreate(128.750000, 204.584304, "box");
	TextDrawLetterSize(Text_Login[4], 0.000000, 1.812500);
	TextDrawTextSize(Text_Login[4], 274.000000, 0.000000);
	TextDrawAlignment(Text_Login[4], 1);
	TextDrawColor(Text_Login[4], -1);
	TextDrawUseBox(Text_Login[4], 1);
	TextDrawBoxColor(Text_Login[4], 207);
	TextDrawSetShadow(Text_Login[4], 0);
	TextDrawBackgroundColor(Text_Login[4], 196);
	TextDrawFont(Text_Login[4], 1);
	TextDrawSetProportional(Text_Login[4], 1);

	Text_Login[5] = TextDrawCreate(126.250000, 251.249969, "Senha");
	TextDrawLetterSize(Text_Login[5], 0.264997, 1.109997);
	TextDrawTextSize(Text_Login[5], -218.000000, 0.000000);
	TextDrawAlignment(Text_Login[5], 1);
	TextDrawColor(Text_Login[5], -1);
	TextDrawSetShadow(Text_Login[5], 0);
	TextDrawBackgroundColor(Text_Login[5], 255);
	TextDrawFont(Text_Login[5], 2);
	TextDrawSetProportional(Text_Login[5], 1);

	Text_Login[6] = TextDrawCreate(128.750000, 267.583221, "box");
	TextDrawLetterSize(Text_Login[6], 0.000000, 1.750000);
	TextDrawTextSize(Text_Login[6], 276.000000, 0.000000);
	TextDrawAlignment(Text_Login[6], 1);
	TextDrawColor(Text_Login[6], -1);
	TextDrawUseBox(Text_Login[6], 1);
	TextDrawBoxColor(Text_Login[6], 236);
	TextDrawSetShadow(Text_Login[6], 0);
	TextDrawBackgroundColor(Text_Login[6], 255);
	TextDrawFont(Text_Login[6], 1);
	TextDrawSetProportional(Text_Login[6], 1);

	Text_Login[7] = TextDrawCreate(159.760635, 131.329940, "FLUXO_RPG");
	TextDrawLetterSize(Text_Login[7], 0.520455, 1.940412);
	TextDrawTextSize(Text_Login[7], 351.000000, 0.000000);
	TextDrawAlignment(Text_Login[7], 1);
	TextDrawColor(Text_Login[7], -16711681);
	TextDrawSetShadow(Text_Login[7], -1);
	TextDrawBackgroundColor(Text_Login[7], 255);
	TextDrawFont(Text_Login[7], 3);
	TextDrawSetProportional(Text_Login[7], 0);

	Text_Login[8] = TextDrawCreate(162.340332, 151.842285, "rEDE_FLUXO_RPG");
	TextDrawLetterSize(Text_Login[8], 0.251913, 1.232555);
	TextDrawTextSize(Text_Login[8], 166.000000, 0.000000);
	TextDrawAlignment(Text_Login[8], 1);
	TextDrawColor(Text_Login[8], -1);
	TextDrawSetShadow(Text_Login[8], 0);
	TextDrawBackgroundColor(Text_Login[8], 255);
	TextDrawFont(Text_Login[8], 2);
	TextDrawSetProportional(Text_Login[8], 1);

	Text_Login[9] = TextDrawCreate(197.330276, 242.450607, "-");
	TextDrawLetterSize(Text_Login[9], 6.563395, 12.559722);
	TextDrawTextSize(Text_Login[9], 110.000000, 0.000000);
	TextDrawAlignment(Text_Login[9], 1);
	TextDrawColor(Text_Login[9], 65535);
	TextDrawSetShadow(Text_Login[9], 0);
	TextDrawBackgroundColor(Text_Login[9], 255);
	TextDrawFont(Text_Login[9], 1);
	TextDrawSetProportional(Text_Login[9], 1);

	Text_Login[10] = TextDrawCreate(476.348663, 267.888977, "-");
	TextDrawLetterSize(Text_Login[10], 6.743374, 15.032884);
	TextDrawTextSize(Text_Login[10], -389.000000, 0.000000);
	TextDrawAlignment(Text_Login[10], 1);
	TextDrawColor(Text_Login[10], 8388863);
	TextDrawSetShadow(Text_Login[10], 0);
	TextDrawBackgroundColor(Text_Login[10], 255);
	TextDrawFont(Text_Login[10], 1);
	TextDrawSetProportional(Text_Login[10], 1);

	Text_Login[11] = TextDrawCreate(192.891281, 288.172454, "-");
	TextDrawLetterSize(Text_Login[11], 7.067787, 12.439584);
	TextDrawTextSize(Text_Login[11], 66.000000, 0.000000);
	TextDrawAlignment(Text_Login[11], 1);
	TextDrawColor(Text_Login[11], -16776961);
	TextDrawSetShadow(Text_Login[11], 0);
	TextDrawBackgroundColor(Text_Login[11], 255);
	TextDrawFont(Text_Login[11], 1);
	TextDrawSetProportional(Text_Login[11], 1);

	Text_Login[12] = TextDrawCreate(377.943145, 130.643661, "Registrar_conta");
	TextDrawLetterSize(Text_Login[12], 0.400000, 1.600000);
	TextDrawTextSize(Text_Login[12], 442.000000, 0.000000);
	TextDrawAlignment(Text_Login[12], 1);
	TextDrawColor(Text_Login[12], -1);
	TextDrawSetShadow(Text_Login[12], -1);
	TextDrawBackgroundColor(Text_Login[12], 255);
	TextDrawFont(Text_Login[12], 3);
	TextDrawSetProportional(Text_Login[12], 1);

	Text_Login[13] = TextDrawCreate(344.432037, 202.851608, "");
	TextDrawTextSize(Text_Login[13], 90.000000, 90.000000);
	TextDrawAlignment(Text_Login[13], 1);
	TextDrawColor(Text_Login[13], -1);
	TextDrawSetShadow(Text_Login[13], 0);
	TextDrawBackgroundColor(Text_Login[13], 1);
	TextDrawFont(Text_Login[13], 5);
	TextDrawSetProportional(Text_Login[13], 0);
	TextDrawSetPreviewModel(Text_Login[13], 23);
	TextDrawSetPreviewRot(Text_Login[13], 0.000000, 0.000000, 0.000000, 1.000000);

	Text_Login[14] = TextDrawCreate(418.817474, 194.359161, "");
	TextDrawTextSize(Text_Login[14], 108.000000, 106.000000);
	TextDrawAlignment(Text_Login[14], 1);
	TextDrawColor(Text_Login[14], -1);
	TextDrawSetShadow(Text_Login[14], 0);
	TextDrawBackgroundColor(Text_Login[14], 1);
	TextDrawFont(Text_Login[14], 5);
	TextDrawSetProportional(Text_Login[14], 0);
	TextDrawSetPreviewModel(Text_Login[14], 56);
	TextDrawSetPreviewRot(Text_Login[14], 0.000000, 0.000000, 0.000000, 1.000000);

	Text_Login[15] = TextDrawCreate(345.415222, 121.926521, "-");
	TextDrawLetterSize(Text_Login[15], 6.201979, 12.623315);
	TextDrawTextSize(Text_Login[15], 110.000000, 0.000000);
	TextDrawAlignment(Text_Login[15], 1);
	TextDrawColor(Text_Login[15], 16777215);
	TextDrawSetShadow(Text_Login[15], 0);
	TextDrawBackgroundColor(Text_Login[15], 255);
	TextDrawFont(Text_Login[15], 1);
	TextDrawSetProportional(Text_Login[15], 1);

	Text_Login[16] = TextDrawCreate(425.982452, 122.719932, "-");
	TextDrawLetterSize(Text_Login[16], 6.563395, 12.559722);
	TextDrawTextSize(Text_Login[16], 110.000000, 0.000000);
	TextDrawAlignment(Text_Login[16], 1);
	TextDrawColor(Text_Login[16], -16711681);
	TextDrawSetShadow(Text_Login[16], 0);
	TextDrawBackgroundColor(Text_Login[16], 255);
	TextDrawFont(Text_Login[16], 1);
	TextDrawSetProportional(Text_Login[16], 1);

	Text_Login[17] = TextDrawCreate(305.595550, 349.438476, "box");
	TextDrawLetterSize(Text_Login[17], 0.000000, 1.863474);
	TextDrawTextSize(Text_Login[17], 440.000000, 0.000000);
	TextDrawAlignment(Text_Login[17], 1);
	TextDrawColor(Text_Login[17], -1);
	TextDrawUseBox(Text_Login[17], 1);
	TextDrawBoxColor(Text_Login[17], 236);
	TextDrawSetShadow(Text_Login[17], 0);
	TextDrawBackgroundColor(Text_Login[17], 255);
	TextDrawFont(Text_Login[17], 1);
	TextDrawSetProportional(Text_Login[17], 1);

	Text_Login[18] = TextDrawCreate(317.347229, 332.511840, "Crie_uma_senha");
	TextDrawLetterSize(Text_Login[18], 0.264997, 1.109997);
	TextDrawTextSize(Text_Login[18], -235.000000, 0.000000);
	TextDrawAlignment(Text_Login[18], 1);
	TextDrawColor(Text_Login[18], -1);
	TextDrawSetShadow(Text_Login[18], 0);
	TextDrawBackgroundColor(Text_Login[18], 255);
	TextDrawFont(Text_Login[18], 2);
	TextDrawSetProportional(Text_Login[18], 1);

	Text_Login[19] = TextDrawCreate(408.803070, 168.253890, "Genero");
	TextDrawLetterSize(Text_Login[19], 0.264997, 1.109997);
	TextDrawTextSize(Text_Login[19], -218.000000, 0.000000);
	TextDrawAlignment(Text_Login[19], 1);
	TextDrawColor(Text_Login[19], -1);
	TextDrawSetShadow(Text_Login[19], 0);
	TextDrawSetOutline(Text_Login[19], 1);
	TextDrawBackgroundColor(Text_Login[19], 255);
	TextDrawFont(Text_Login[19], 2);
	TextDrawSetProportional(Text_Login[19], 1);

	//Termino do Sistema de login [TextDraw-TDE]

	CreateObject(994, 1162.40491, -1756.37720, 13.37163,   0.00000, 0.00000, 90.06279);
	CreateObject(994, 1146.91956, -1756.16199, 13.37163,   0.00000, 0.00000, 90.06279);
	CreateObject(997, 1145.91370, -1751.30139, 13.19210,   0.00000, 0.00000, 269.73889);
	CreateObject(997, 1161.44250, -1751.53186, 13.19210,   0.00000, 0.00000, 269.73889);
	CreateObject(1288, 1164.35425, -1746.93799, 13.47197,   0.00000, 0.00000, 0.00000);
	CreateObject(1288, 1163.91138, -1746.93640, 13.47197,   0.00000, 0.00000, 0.00000);
	CreateObject(14467, 1145.76843, -1748.38379, 15.69569,   0.00000, 0.00000, 211.02023);
	CreateObject(14467, 1162.50256, -1748.29993, 15.29469,   0.00000, 0.00000, 148.58438);
	CreateObject(1340, 1159.12390, -1726.40198, 13.88100,   0.00000, 0.00000, 223.19901);
	CreateObject(1775, 1145.28271, -1765.81982, 13.63617,   0.00000, 0.00000, 180.21658);
	CreateObject(1775, 1143.42749, -1765.81616, 13.63617,   0.00000, 0.00000, 180.21658);
	CreateObject(1597, 1163.08313, -1755.35767, 15.32036,   0.00000, 0.00000, 0.35128);
	CreateObject(1597, 1144.93176, -1755.31091, 15.32036,   0.00000, 0.00000, 0.35128);
	CreateObject(2754, 1147.51001, -1772.74988, 16.48820,   0.00000, 0.00000, 267.38721);
	CreateVehicle(462, 1147.5692, -1757.9052, 13.1388, 273.7103, -1, -1, 100);
	CreateVehicle(462, 1147.6130, -1756.3984, 13.1388, 273.7103, -1, -1, 100);
	CreateVehicle(462, 1147.6569, -1755.0382, 13.1388, 273.7103, -1, -1, 100);
	CreateVehicle(462, 1147.6395, -1753.5250, 13.1388, 273.7103, -1, -1, 100);
	CreateVehicle(462, 1147.6437, -1752.0287, 13.1388, 273.7103, -1, -1, 100);
	CreateVehicle(462, 1147.6646, -1759.4021, 13.1388, 273.7103, -1, -1, 100);
	CreateVehicle(462, 1160.4768, -1759.4326, 13.1538, 87.7339, -1, -1, 100);
	CreateVehicle(462, 1160.4761, -1757.9725, 13.1538, 87.7339, -1, -1, 100);
	CreateVehicle(462, 1160.4618, -1756.4872, 13.1538, 87.7339, -1, -1, 100);
	CreateVehicle(462, 1160.5360, -1755.0948, 13.1538, 87.7339, -1, -1, 100);
	CreateVehicle(462, 1160.4962, -1753.5524, 13.1538, 87.7339, -1, -1, 100);
	CreateVehicle(462, 1160.5446, -1752.1005, 13.1538, 87.7339, -1, -1, 100);



	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	new str[50];
	format(str, 50, "%s", pName(playerid));
	PlayerTextDrawSetString(playerid, PText_Login[playerid][3], str);
	for(new i=0 ; i < 20; i++) TextDrawShowForPlayer(playerid, Text_Login[i]);
	for(new i=0 ; i < 8; i++) PlayerTextDrawShow(playerid, PText_Login[playerid][i]);
	SelectTextDraw(playerid, 0x64B1FFFF);
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectatePlayer(playerid, playerid);
	pInfo[playerid][pGenero] = 1;
	pInfo[playerid][pSkin] = 23;
	return 1;
}

public OnPlayerConnect(playerid)
{
	LimparVariaveis(playerid);

	Text_Timer[playerid][0] = CreatePlayerTextDraw(playerid, 458.000000, 334.355590, "00:00");	
	PlayerTextDrawLetterSize(playerid, Text_Timer[playerid][0], 0.442333, 1.824000);
	PlayerTextDrawAlignment(playerid, Text_Timer[playerid][0], 1);
	PlayerTextDrawColor(playerid, Text_Timer[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, Text_Timer[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, Text_Timer[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, Text_Timer[playerid][0], 255);
	PlayerTextDrawFont(playerid, Text_Timer[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, Text_Timer[playerid][0], 1);

	Text_Hud[playerid][0] = CreatePlayerTextDraw(playerid, 246.000000, 424.214843, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, Text_Hud[playerid][0], 19.000000, 22.000000);
	PlayerTextDrawAlignment(playerid, Text_Hud[playerid][0], 1);
	PlayerTextDrawColor(playerid, Text_Hud[playerid][0], -5963521);
	PlayerTextDrawSetShadow(playerid, Text_Hud[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Hud[playerid][0], 255);
	PlayerTextDrawFont(playerid, Text_Hud[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, Text_Hud[playerid][0], 0);

	Text_Hud[playerid][1] = CreatePlayerTextDraw(playerid, 251.666656, 430.851837, "hud:radar_burgerShot");
	PlayerTextDrawTextSize(playerid, Text_Hud[playerid][1], 8.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, Text_Hud[playerid][1], 1);
	PlayerTextDrawColor(playerid, Text_Hud[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, Text_Hud[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Hud[playerid][1], 255);
	PlayerTextDrawFont(playerid, Text_Hud[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, Text_Hud[playerid][1], 0);

	Text_Hud[playerid][2] = CreatePlayerTextDraw(playerid, 265.333251, 428.933349, "100%");
	PlayerTextDrawLetterSize(playerid, Text_Hud[playerid][2], 0.282333, 1.247407);
	PlayerTextDrawAlignment(playerid, Text_Hud[playerid][2], 1);
	PlayerTextDrawColor(playerid, Text_Hud[playerid][2], -5963521);
	PlayerTextDrawSetShadow(playerid, Text_Hud[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, Text_Hud[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, Text_Hud[playerid][2], 255);
	PlayerTextDrawFont(playerid, Text_Hud[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, Text_Hud[playerid][2], 1);

	Text_Hud[playerid][3] = CreatePlayerTextDraw(playerid, 298.333374, 424.629638, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, Text_Hud[playerid][3], 19.000000, 22.000000);
	PlayerTextDrawAlignment(playerid, Text_Hud[playerid][3], 1);
	PlayerTextDrawColor(playerid, Text_Hud[playerid][3], 11075583);
	PlayerTextDrawSetShadow(playerid, Text_Hud[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Hud[playerid][3], 255);
	PlayerTextDrawFont(playerid, Text_Hud[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, Text_Hud[playerid][3], 0);

	Text_Hud[playerid][4] = CreatePlayerTextDraw(playerid, 318.999908, 430.177764, "100%");
	PlayerTextDrawLetterSize(playerid, Text_Hud[playerid][4], 0.282333, 1.247407);
	PlayerTextDrawAlignment(playerid, Text_Hud[playerid][4], 1);
	PlayerTextDrawColor(playerid, Text_Hud[playerid][4], 11468799);
	PlayerTextDrawSetShadow(playerid, Text_Hud[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, Text_Hud[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, Text_Hud[playerid][4], 255);
	PlayerTextDrawFont(playerid, Text_Hud[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, Text_Hud[playerid][4], 1);

	Text_Hud[playerid][5] = CreatePlayerTextDraw(playerid, 304.333251, 431.681457, "hud:radar_dateDrink");
	PlayerTextDrawTextSize(playerid, Text_Hud[playerid][5], 8.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, Text_Hud[playerid][5], 1);
	PlayerTextDrawColor(playerid, Text_Hud[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, Text_Hud[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Hud[playerid][5], 255);
	PlayerTextDrawFont(playerid, Text_Hud[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, Text_Hud[playerid][5], 0);

	Text_Hud[playerid][6] = CreatePlayerTextDraw(playerid, 350.333343, 425.044403, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, Text_Hud[playerid][6], 19.000000, 22.000000);
	PlayerTextDrawAlignment(playerid, Text_Hud[playerid][6], 1);
	PlayerTextDrawColor(playerid, Text_Hud[playerid][6], -1061109505);
	PlayerTextDrawSetShadow(playerid, Text_Hud[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Hud[playerid][6], 255);
	PlayerTextDrawFont(playerid, Text_Hud[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, Text_Hud[playerid][6], 0);

	Text_Hud[playerid][7] = CreatePlayerTextDraw(playerid, 355.666595, 432.096282, "hud:radar_ZERO");
	PlayerTextDrawTextSize(playerid, Text_Hud[playerid][7], 8.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, Text_Hud[playerid][7], 1);
	PlayerTextDrawColor(playerid, Text_Hud[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, Text_Hud[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Hud[playerid][7], 255);
	PlayerTextDrawFont(playerid, Text_Hud[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, Text_Hud[playerid][7], 0);

	Text_Hud[playerid][8] = CreatePlayerTextDraw(playerid, 370.333190, 431.007354, "100%");
	PlayerTextDrawLetterSize(playerid, Text_Hud[playerid][8], 0.282333, 1.247407);
	PlayerTextDrawAlignment(playerid, Text_Hud[playerid][8], 1);
	PlayerTextDrawColor(playerid, Text_Hud[playerid][8], -1061109505);
	PlayerTextDrawSetShadow(playerid, Text_Hud[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, Text_Hud[playerid][8], 1);
	PlayerTextDrawBackgroundColor(playerid, Text_Hud[playerid][8], 255);
	PlayerTextDrawFont(playerid, Text_Hud[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, Text_Hud[playerid][8], 1);

	////Sistema de login [TextDraw-TDE]
	PText_Login[playerid][0] = CreatePlayerTextDraw(playerid, 221.180053, 305.886474, "Entrar");
	PlayerTextDrawLetterSize(playerid, PText_Login[playerid][0], 0.388651, 1.713057);
	PlayerTextDrawTextSize(playerid, PText_Login[playerid][0], 275.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, PText_Login[playerid][0], 1);
	PlayerTextDrawColor(playerid, PText_Login[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, PText_Login[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, PText_Login[playerid][0], -256);
	PlayerTextDrawSetShadow(playerid, PText_Login[playerid][0], 2);
	PlayerTextDrawBackgroundColor(playerid, PText_Login[playerid][0], 255);
	PlayerTextDrawFont(playerid, PText_Login[playerid][0], 3);
	PlayerTextDrawSetProportional(playerid, PText_Login[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PText_Login[playerid][0], true);

	PText_Login[playerid][1] = CreatePlayerTextDraw(playerid, 227.588592, 349.697235, "Sair");
	PlayerTextDrawLetterSize(playerid, PText_Login[playerid][1], 0.466383, 1.642397);
	PlayerTextDrawTextSize(playerid, PText_Login[playerid][1], 281.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, PText_Login[playerid][1], 1);
	PlayerTextDrawColor(playerid, PText_Login[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, PText_Login[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, PText_Login[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, PText_Login[playerid][1], 2);
	PlayerTextDrawBackgroundColor(playerid, PText_Login[playerid][1], 171);
	PlayerTextDrawFont(playerid, PText_Login[playerid][1], 3);
	PlayerTextDrawSetProportional(playerid, PText_Login[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, PText_Login[playerid][1], true);

	PText_Login[playerid][2] = CreatePlayerTextDraw(playerid, 504.817230, 347.577331, "Criar");
	PlayerTextDrawLetterSize(playerid, PText_Login[playerid][2], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, PText_Login[playerid][2], 557.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, PText_Login[playerid][2], 1);
	PlayerTextDrawColor(playerid, PText_Login[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, PText_Login[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, PText_Login[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, PText_Login[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, PText_Login[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, PText_Login[playerid][2], 255);
	PlayerTextDrawFont(playerid, PText_Login[playerid][2], 3);
	PlayerTextDrawSetProportional(playerid, PText_Login[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, PText_Login[playerid][2], true);

	PText_Login[playerid][3] = CreatePlayerTextDraw(playerid, 132.535934, 204.018478, "MAURICIO");
	PlayerTextDrawLetterSize(playerid, PText_Login[playerid][3], 0.388651, 1.713057);
	PlayerTextDrawTextSize(playerid, PText_Login[playerid][3], 188.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, PText_Login[playerid][3], 1);
	PlayerTextDrawColor(playerid, PText_Login[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, PText_Login[playerid][3], 2);
	PlayerTextDrawBackgroundColor(playerid, PText_Login[playerid][3], 255);
	PlayerTextDrawFont(playerid, PText_Login[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, PText_Login[playerid][3], 1);

	PText_Login[playerid][4] = CreatePlayerTextDraw(playerid, 131.534606, 267.728790, "Senha");
	PlayerTextDrawLetterSize(playerid, PText_Login[playerid][4], 0.388651, 1.713057);
	PlayerTextDrawTextSize(playerid, PText_Login[playerid][4], 275.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, PText_Login[playerid][4], 1);
	PlayerTextDrawColor(playerid, PText_Login[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, PText_Login[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, PText_Login[playerid][4], -65536);
	PlayerTextDrawSetShadow(playerid, PText_Login[playerid][4], 2);
	PlayerTextDrawBackgroundColor(playerid, PText_Login[playerid][4], 255);
	PlayerTextDrawFont(playerid, PText_Login[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, PText_Login[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, PText_Login[playerid][4], true);

	PText_Login[playerid][5] = CreatePlayerTextDraw(playerid, 362.624114, 188.881896, "Masculino");
	PlayerTextDrawLetterSize(playerid, PText_Login[playerid][5], 0.228475, 1.246687);
	PlayerTextDrawTextSize(playerid, PText_Login[playerid][5], 419.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, PText_Login[playerid][5], 1);
	PlayerTextDrawColor(playerid, PText_Login[playerid][5], -1);
	PlayerTextDrawUseBox(playerid, PText_Login[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid, PText_Login[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, PText_Login[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, PText_Login[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, PText_Login[playerid][5], 255);
	PlayerTextDrawFont(playerid, PText_Login[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, PText_Login[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, PText_Login[playerid][5], true);

	PText_Login[playerid][6] = CreatePlayerTextDraw(playerid, 450.167114, 188.481842, "Feminino");
	PlayerTextDrawLetterSize(playerid, PText_Login[playerid][6], 0.228475, 1.246687);
	PlayerTextDrawTextSize(playerid, PText_Login[playerid][6], 506.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, PText_Login[playerid][6], 1);
	PlayerTextDrawColor(playerid, PText_Login[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, PText_Login[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid, PText_Login[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, PText_Login[playerid][6], 1);
	PlayerTextDrawSetOutline(playerid, PText_Login[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, PText_Login[playerid][6], 255);
	PlayerTextDrawFont(playerid, PText_Login[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, PText_Login[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, PText_Login[playerid][6], true);

	PText_Login[playerid][7] = CreatePlayerTextDraw(playerid, 307.417022, 349.563964, "Senha");
	PlayerTextDrawLetterSize(playerid, PText_Login[playerid][7], 0.388651, 1.713057);
	PlayerTextDrawTextSize(playerid, PText_Login[playerid][7], 452.198608, 15.000000);
	PlayerTextDrawAlignment(playerid, PText_Login[playerid][7], 1);
	PlayerTextDrawColor(playerid, PText_Login[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, PText_Login[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, PText_Login[playerid][7], -65536);
	PlayerTextDrawSetShadow(playerid, PText_Login[playerid][7], 2);
	PlayerTextDrawBackgroundColor(playerid, PText_Login[playerid][7], 255);
	PlayerTextDrawFont(playerid, PText_Login[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, PText_Login[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, PText_Login[playerid][7], true);

	//Termino do Sistema de login [TextDraw-TDE]

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	SalvarConta(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	pInfo[playerid][pFome] = 100;
	pInfo[playerid][pSede] = 100;
	pInfo[playerid][pSono] = 100;
	new string[30];
	format(string, 30, "%d%", pInfo[playerid][pFome]);
	PlayerTextDrawSetString(playerid, Text_Hud[playerid][2], string);

	format(string, 30, "%d%", pInfo[playerid][pSede]);
	PlayerTextDrawSetString(playerid, Text_Hud[playerid][4], string);

	format(string, 30, "%d%", pInfo[playerid][pSono]);
	PlayerTextDrawSetString(playerid, Text_Hud[playerid][8], string);
	for(new i; i < 9; i++) PlayerTextDrawShow(playerid, Text_Hud[playerid][i]);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(pInfo[playerid][pAdmin] > 0 && TrabalhandoAdmin[playerid] == true)
	{
		new str[125];
		format(str, 125, "{F6CEF5}[%s] %s {10F8DD}disse: {FFFFFF}%s", CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid), text);
		ProxDetector(playerid, 13.0, -1, str, 1.6); //13.0 de distancia
		return 0;
	}
	new str[125];
	format(str, 125, "{81DAF5}[ID %d] %s {10F8DD}disse: {FFFFFF}%s", playerid, pName(playerid), text);
	ProxDetector(playerid, 13.0, -1, str, 1.6); //13.0 de distancia
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == Dialog_InserirSenha)
	{
		if(strlen(inputtext) < 6 || strlen(inputtext) > 11) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF} Insira entra 6 e 11 caracteres.");
		format(SenhaLogin[playerid], 11, "%s", inputtext);
		for(new i = 0; i < strlen(inputtext); i++)
		{
			inputtext[i] = ']';
		}
		PlayerTextDrawSetString(playerid, PText_Login[playerid][4], inputtext);
		PlayerTextDrawShow(playerid, PText_Login[playerid][4]);
		DigitouSenhaLogin[playerid] = true;
	}
	if(dialogid == Dialog_InserirSenhaRegistro)
	{
		if(strlen(inputtext) < 6 || strlen(inputtext) > 11) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF} Insira entra 6 e 11 caracteres.");
		format(SenhaRegistro[playerid], 11, "%s", inputtext);
		for(new i = 0; i < strlen(inputtext); i++)
		{
			inputtext[i] = ']';
		}
		PlayerTextDrawSetString(playerid, PText_Login[playerid][7], inputtext);
		PlayerTextDrawShow(playerid, PText_Login[playerid][7]);
		DigitouSenhaRegistro[playerid] = true;
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == PText_Login[playerid][2]) //registro do player
	{
		if(DigitouSenhaRegistro[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao terminou o registro.");
		if(dini_Exists(Arquivo(playerid))) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce ja tem uma conta.");

		dini_Create(Arquivo(playerid));
		dini_Set(Arquivo(playerid), "Senha", SenhaRegistro[playerid]);
		pInfo[playerid][pFome] = 100;
		pInfo[playerid][pSede] = 100;
		TogglePlayerSpectating(playerid, 0);
		pInfo[playerid][pAdmin] = 0;
		pInfo[playerid][pSono] = 100;
		for(new i=0 ; i < 20; i++) TextDrawHideForPlayer(playerid, Text_Login[i]);
		for(new i=0 ; i < 8; i++) PlayerTextDrawHide(playerid, PText_Login[playerid][i]);
		SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
		CancelSelectTextDraw(playerid);

		//teste
		new string[30];
		format(string, 30, "%d%", pInfo[playerid][pFome]);
		PlayerTextDrawSetString(playerid, Text_Hud[playerid][2], string);

		format(string, 30, "%d%", pInfo[playerid][pSede]);
		PlayerTextDrawSetString(playerid, Text_Hud[playerid][4], string);

		format(string, 30, "%d%", pInfo[playerid][pSono]);
		PlayerTextDrawSetString(playerid, Text_Hud[playerid][8], string);
		for(new i; i < 9; i++) PlayerTextDrawShow(playerid, Text_Hud[playerid][i]);

		SetTimerEx("TimerFome", 400000, true, "d", playerid);
		SetTimerEx("TimerSede", 550000, true, "d", playerid);
		SetTimerEx("TimerSono", 700000, true, "d", playerid);
		// teste
		//SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 1408.4352,-964.8619,46.9375,356.3838, 0, 0, 0, 0, 0, 0); // spawner do jogador
		SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 1147.6646, -1759.4021, 13.1388, 273.7103, 0, 0, 0, 0, 0, 0);
			
		SpawnPlayer(playerid);




		SalvarConta(playerid);
		return 1;
	}

	if(playertextid == PText_Login[playerid][5]) //masc
	{
		pInfo[playerid][pGenero] = 1;
		pInfo[playerid][pSkin] = 23;
	}
	if(playertextid == PText_Login[playerid][6]) //fem
	{
		pInfo[playerid][pGenero] = 2;
		pInfo[playerid][pSkin] = 56;
	}
	
	if(playertextid == PText_Login[playerid][1])
	{
		Kick(playerid);
	}
	if(playertextid == PText_Login[playerid][4])
	{
		ShowPlayerDialog(playerid, Dialog_InserirSenha, DIALOG_STYLE_INPUT, "Senha", "{FFFFFF}Digite sua senha.", "Confirmar", "Fechar");
	}
	if(playertextid == PText_Login[playerid][7])
	{
		ShowPlayerDialog(playerid, Dialog_InserirSenhaRegistro, DIALOG_STYLE_INPUT, "Senha", "{FFFFFF}Digite a senha de registro.", "Confirmar", "Fechar");
	}

	
	if(playertextid == PText_Login[playerid][0])  //login do player
	{
		if(DigitouSenhaLogin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Digite uma senha para logar-se.");
		if(!dini_Exists(Arquivo(playerid))) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem uma conta.");

		if(strcmp(SenhaLogin[playerid], dini_Get(Arquivo(playerid), "Senha")) == 0)
		{
			CarregarConta(playerid);
			VerificarBan(playerid);

			//SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 1408.4352,-964.8619,46.9375,356.3838, 0, 0, 0, 0, 0, 0); // spawner do jogador
			SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 1147.6646, -1759.4021, 13.1388, 273.7103, 0, 0, 0, 0, 0, 0);
			SpawnPlayer(playerid);
			
			if(pInfo[playerid][pPresoAdmin] == 1)
			{
				new str[50];
				new pasta[50];
				format(pasta, 50, "Cadeia/%s.ini", pName(playerid));
				format(str, 50, "%02d:%02d", pInfo[playerid][pMinutosAdmin], pInfo[playerid][pSegundosAdmin]);
				PlayerTextDrawSetString(playerid, Text_Timer[playerid][0], str);
				PlayerTextDrawShow(playerid, Text_Timer[playerid][0]);
				TimerCadeia[playerid] = SetTimerEx("SairCadeia", 1000, true, "d", playerid);
				SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 322.197998,302.497985,999.148437,0,  0, 0, 0, 0, 0, 0); // Posição do jogador
				SpawnPlayer(playerid);
				SetPlayerPos(playerid, 322.197998,302.497985,999.148437);
				SetPlayerInterior(playerid, 5);
				format(str, 210, "{FF0000}=-=- Voce esta preso =-=-\n\n{FFFFFF}Informacoes do banimento\n\n{58D3F7}Admin Responsavel: {FFFFFF}%s\n{58D3F7}Dia da Punicao: {FFFFFF}%s\n{58D3F7}Motivo: %s", dini_Get(pasta, "Admin"), dini_Get(pasta, "Data"), dini_Get(pasta, "Motivo"));
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Banido", str, "Sair", "Fechar");
			}

			TogglePlayerSpectating(playerid, 0);
			GivePlayerMoney(playerid,pInfo[playerid][pGrana]);
			GetPlayerSkin(playerid);
			//SetPlayerSkin(playerid, pInfo[playerid][pSkin]);

			SetTimerEx("TimerSalvarConta", 4000, true, "d", playerid);
			new string[30];
			format(string, 30, "%d%", pInfo[playerid][pFome]);
			PlayerTextDrawSetString(playerid, Text_Hud[playerid][2], string);

			format(string, 30, "%d%", pInfo[playerid][pSede]);
			PlayerTextDrawSetString(playerid, Text_Hud[playerid][4], string);

			format(string, 30, "%d%", pInfo[playerid][pSono]);
			PlayerTextDrawSetString(playerid, Text_Hud[playerid][8], string);
			for(new i; i < 9; i++) PlayerTextDrawShow(playerid, Text_Hud[playerid][i]);

			SetTimerEx("TimerFome", 400000, true, "d", playerid);
			SetTimerEx("TimerSede", 550000, true, "d", playerid);
			SetTimerEx("TimerSono", 700000, true, "d", playerid);
			TogglePlayerControllable(playerid, 1);
			GetPlayerSkin(playerid);
			for(new i=0 ; i < 20; i++) TextDrawHideForPlayer(playerid, Text_Login[i]);
			for(new i=0 ; i < 8; i++) PlayerTextDrawHide(playerid, PText_Login[playerid][i]);
			CancelSelectTextDraw(playerid);
		} else return SendClientMessage(playerid, -1, "{FF0000}Info: {FFFFFF}Senha Incorreta");
	}
	
	return 1;
}
//__| Timers |__

forward TimerFome(playerid);
public TimerFome(playerid)
{
	pInfo[playerid][pFome] --;
	new string[30];
	format(string, 30, "%d%", pInfo[playerid][pFome]);
	PlayerTextDrawSetString(playerid, Text_Hud[playerid][2], string);
	PlayerTextDrawShow(playerid, Text_Hud[playerid][2]);
	new Float:Vida;
	GetPlayerHealth(playerid, Vida);
	SalvarConta(playerid);
	if(pInfo[playerid][pFome] == 30) return SendClientMessage(playerid, -1, "Voce esta ficando com fome."), SetPlayerHealth(playerid, Vida - 10);
	if(pInfo[playerid][pFome] == 10) return SendClientMessage(playerid, -1, "Voce esta ficando com muita fome."), SetPlayerHealth(playerid, Vida - 15);
	if(pInfo[playerid][pFome] <= 0) return SendClientMessage(playerid, -1, "Voce morreu de fome."), SetPlayerHealth(playerid, 0);
	return 1;
}

forward TimerSede(playerid);
public TimerSede(playerid)
{
	pInfo[playerid][pSede] --;
	new string[30];
	format(string, 30, "%d%", pInfo[playerid][pSede]);
	PlayerTextDrawSetString(playerid, Text_Hud[playerid][4], string);
	PlayerTextDrawShow(playerid, Text_Hud[playerid][4]);
	new Float:Vida;
	SalvarConta(playerid);
	GetPlayerHealth(playerid, Vida);
	if(pInfo[playerid][pSede] == 30) return SendClientMessage(playerid, -1, "Voce esta ficando com sede."), SetPlayerHealth(playerid, Vida - 10);
	if(pInfo[playerid][pSede] == 10) return SendClientMessage(playerid, -1, "Voce esta ficando com muita sede."), SetPlayerHealth(playerid, Vida - 15);
	if(pInfo[playerid][pSede] <= 0) return SendClientMessage(playerid, -1, "Voce morreu de sede."), SetPlayerHealth(playerid, 0);
	return 1;
}

forward TimerSono(playerid);
public TimerSono(playerid)
{
	pInfo[playerid][pSono] --;
	new string[30];
	format(string, 30, "%d%", pInfo[playerid][pSono]);
	PlayerTextDrawSetString(playerid, Text_Hud[playerid][8], string);
	PlayerTextDrawShow(playerid, Text_Hud[playerid][8]);
	new Float:Vida;
	GetPlayerHealth(playerid, Vida);
	SalvarConta(playerid);
	if(pInfo[playerid][pSono] == 30) return SendClientMessage(playerid, -1, "Voce esta ficando com sono."), SetPlayerHealth(playerid, Vida - 10);
	if(pInfo[playerid][pSono] == 10) return SendClientMessage(playerid, -1, "Voce esta ficando com muito sono."), SetPlayerHealth(playerid, Vida - 15);
	if(pInfo[playerid][pSono] <= 0) return cmd_dormir(playerid);
	return 1;
}

//___| Stocks do Servidor |___
stock pName(playerid)
{
	new nome[24];
	GetPlayerName(playerid, nome, 24);
	return nome;
}

stock Arquivo(playerid)
{
	new File[40];
	format(File, sizeof(File), "Contas/%s.ini", pName(playerid));
	return File;
}

stock SalvarConta(playerid)
{
	if(TrabalhandoAdmin[playerid] == false) pInfo[playerid][pSkin] = GetPlayerSkin(playerid);
	else pInfo[playerid][pSkin] = SkinStaff[playerid];
	pInfo[playerid][pGrana] = GetPlayerMoney(playerid);
	dini_IntSet(Arquivo(playerid), "Fome", pInfo[playerid][pFome]);
	dini_IntSet(Arquivo(playerid), "Sede", pInfo[playerid][pSede]);
	dini_IntSet(Arquivo(playerid), "Sono", pInfo[playerid][pSono]);
	dini_IntSet(Arquivo(playerid), "Skin", pInfo[playerid][pSkin]);
	dini_IntSet(Arquivo(playerid), "Grana", pInfo[playerid][pGrana]);
	dini_IntSet(Arquivo(playerid), "Admin", pInfo[playerid][pAdmin]);

	dini_IntSet(Arquivo(playerid), "Preso", pInfo[playerid][pPresoAdmin]);
	dini_IntSet(Arquivo(playerid), "MinutosPreso", pInfo[playerid][pMinutosAdmin]);
	dini_IntSet(Arquivo(playerid), "SegundosPreso", pInfo[playerid][pSegundosAdmin]);

	dini_IntSet(Arquivo(playerid), "Genero", pInfo[playerid][pGenero]);
	return 1;
}

stock CarregarConta(playerid)
{
	pInfo[playerid][pFome] = dini_Int(Arquivo(playerid), "Fome");
	pInfo[playerid][pSede] = dini_Int(Arquivo(playerid), "Sede");
	pInfo[playerid][pSono] = dini_Int(Arquivo(playerid), "Sono");
	pInfo[playerid][pSkin] = dini_Int(Arquivo(playerid), "Skin");
	pInfo[playerid][pGrana] = dini_Int(Arquivo(playerid), "Grana");
	pInfo[playerid][pAdmin] = dini_Int(Arquivo(playerid), "Admin");

	pInfo[playerid][pPresoAdmin] = dini_Int(Arquivo(playerid), "Preso");
	pInfo[playerid][pMinutosAdmin] = dini_Int(Arquivo(playerid), "MinutosPreso");
	pInfo[playerid][pSegundosAdmin] = dini_Int(Arquivo(playerid), "SegundosPreso");

	pInfo[playerid][pGenero] = dini_Int(Arquivo(playerid), "Genero");
	return 1;
}

stock LimparVariaveis(playerid)
{
	KillTimer(TimerCadeia[playerid]);
	pInfo[playerid][pFome] = 0;
	pInfo[playerid][pSede] = 0;
	pInfo[playerid][pSono] = 0;
	pInfo[playerid][pSkin] = 0;
	pInfo[playerid][pGrana] = 0;
	TrabalhandoAdmin[playerid] = false;
	return 1;
}

stock CargoPlayer(nivel)
{
	new str[50];
	if(nivel == 1)
	{
		str = "Ajudante";
	}
	if(nivel == 2)
	{
		str = "Moderador";
	}
	if(nivel == 3)
	{
		str = "Administrador";
	}
	if(nivel == 4)
	{
		str = "Gerente";
	}
	if(nivel == 5)
	{
		str = "Dono";
	}
	if(nivel == 6)
	{
		str = "Fundador";
	}
	return str;
}

//Comandos

CMD:tra(playerid)
{
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == true)
	{
		//Desativar (Sair do modo trabalho dos adm)
		SetPlayerSkin(playerid, SkinStaff[playerid]);
		TrabalhandoAdmin[playerid] = false;
		SetPlayerHealth(playerid, 100);
		new str[120];
		format(str, 120, "{FA58F4}Admin: {FFFFFF}O {FA58F4}%s %s{FFFFFF} saiu do modo trabalho.", CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid));
		SendClientMessageToAll(-1, str);
		//Avisa na tela que o adm saiu do modo de trabalho (talvez não seja um bom comando)
		format(str, 120, "~p~Admin: ~w~O ~p~%s %s~w~ saiu do modo trabalho.", CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid));
		GameTextForAll(str, 5000, 4);
	}
	else
	{
		//Ativar  (Entrar no modo trabalho dos adm)
		TrabalhandoAdmin[playerid] = true;
		SetPlayerHealth(playerid, 999999);
		SkinStaff[playerid] = GetPlayerSkin(playerid);
		SetPlayerSkin(playerid, 217);
		new str[120];
		format(str, 120, "{FA58F4}Admin: {FFFFFF}O {FA58F4}%s %s{FFFFFF} entrou do modo trabalho.", CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid));
		SendClientMessageToAll(-1, str);

		//Avisa na tela que o adm entrou em modo de trabalho (talvez não seja um bom comando)
		format(str, 120, "~p~Admin: ~w~O ~p~%s %s~w~ entrou do modo trabalho.", CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid));
		GameTextForAll(str, 5000, 4);
	}

	return 1;
}

CMD:cadeia(playerid, params[])
{
	new id, minutos, str[350], motivo[50];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(sscanf(params, "uds[50]", id, minutos, motivo)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /cadeia [ID] [Minutos] [Motivo]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Jogador Offline");
	if(pInfo[playerid][pPresoAdmin] == 1) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Este jogador ja esta preso");
	pInfo[playerid][pMinutosAdmin] = minutos -1;
	pInfo[playerid][pSegundosAdmin] = 59;
	pInfo[playerid][pPresoAdmin] = 1;
	new pasta[50];
	format(pasta, 50, "Cadeia/%s.ini", pName(id));
	dini_Create(pasta);
	dini_IntSet(pasta, "Minutos", pInfo[playerid][pMinutosAdmin]);
	dini_IntSet(pasta, "Segundos", pInfo[playerid][pSegundosAdmin]);
	dini_Set(pasta, "Motivo", motivo);
	dini_Set(pasta, "Admin", pName(playerid));
	format(str, 50, "%02d:%02d", pInfo[playerid][pMinutosAdmin], pInfo[playerid][pSegundosAdmin]);
	PlayerTextDrawSetString(playerid, Text_Timer[playerid][0], str);
	PlayerTextDrawShow(playerid, Text_Timer[playerid][0]);
	TimerCadeia[playerid] = SetTimerEx("SairCadeia", 1000, true, "d", playerid);
	SetPlayerPos(playerid, 322.197998, 302.497985, 999.148437);// Posição da cadeia 
	SetPlayerInterior(playerid, 5);
	new Ano, Mes, Dia;
	getdate(Ano, Mes, Dia);
	format(str, 50, "%02d/%02d/%d", Dia, Mes, Ano);
	dini_Set(pasta, "Data", str);
	format(str, 350, "{82FA58}Cadeia: {FFFFFF}O{82FA58} %s %s{FFFFFF} prendeu o jogador {82FA58}%s{FFFFFF} por {82FA58}%d {FFFFFF}minutos. Motivo:{FFFFFF} {82FA58}%s",  CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid), pName(id), minutos, motivo);
	SendClientMessageToAll(-1, str);
	return 1;
}

CMD:soltar(playerid, params[])
{
	new id;
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /soltar [Id]");
	new pasta[60], str[210];
	format(pasta, 60, "Cadeia/%s.ini", pName(id));
	if(dini_Exists(pasta)) dini_Remove(pasta);
	else return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Este player nao esta preso.");
	format(str, 210, "{82FA58}Cadeia: {FFFFFF}O{82FA58} %s %s{FFFFFF} soltou o jogador {82FA58}%s",  CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid), pName(id));
	SendClientMessageToAll(-1, str);
	SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 1408.4352,-964.8619,46.9375,356.3838, 0, 0, 0, 0, 0, 0);//Mapeamento da cadeia
	SpawnPlayer(playerid);
	SendClientMessage(id, -1, "Voce foi solto");
	KillTimer(TimerCadeia[playerid]);
	pInfo[playerid][pPresoAdmin] = 0;
	SetPlayerInterior(playerid, 0);
	PlayerTextDrawHide(playerid, Text_Timer[playerid][0]);
	SalvarConta(playerid);
	return 1;
}

CMD:dargrana(playerid, params[])
{
	new id, quantia, str[150];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "ud", id, quantia)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /dargrana [Id] [Quantidade]");
	GivePlayerMoney(id, quantia);
	format(str, 150, "{82FA58}Info: {FFFFFF}Voce recebeu R$%d", quantia);
	SendClientMessage(id, -1, str);
	format(str, 150, "{82FA58}Info: {FFFFFF}Voce deu R$%d para o jogador %s", quantia, pName(id));
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:daradmin(playerid, params[])
{
	new id, nivel;
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(sscanf(params, "dd", id, nivel)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /daradmin [ID] [NIVEL]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Jogador Offline");
	if(nivel < 1 || nivel > 6) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Niveis disponiveis: 1 a 6");
	pInfo[id][pAdmin] = nivel;
	new str[150];
	format(str, 150, "{82FA58}Info: {FFFFFF}Voce deu cargo de {82FA58}%s{FFFFFF} para o jogador{82FA58} %s", CargoPlayer(nivel), pName(id));
	SendClientMessage(playerid, -1, str);
	format(str, 150, "{82FA58}Info: {FFFFFF}Voce recebeu cargo de {82FA58}%s{FFFFFF} do {82FA58}%s %s", CargoPlayer(nivel), CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid));
	SendClientMessage(id, -1, str);
	SetPlayerColor(id, 0xFF80FFFF);
	SalvarConta(id);
	return 1;
}

CMD:retiraradmin(playerid, params[])
{
	new id;
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /retiraradmin [ID]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Jogador Offline");
	pInfo[id][pAdmin] = 0;
	new str[150];
	format(str, 150, "{82FA58}Info: {FFFFFF}Voce retirou o admin do jogador{82FA58} %s", pName(id));
	SendClientMessage(playerid, -1, str);
	SendClientMessage(id, -1, "{82FA58}Info: {FFFFFF}Voce foi retirado da staff");
	SalvarConta(id);
	return 1;
}

CMD:ir(playerid, params[])
{
	new id, Float:Pos[3];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /ir [ID]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Jogador Offline");
	GetPlayerPos(id, Pos[0], Pos[1], Pos[2]);
	SetPlayerPos(playerid, Pos[0]+1, Pos[1], Pos[2]);
	SetPlayerInterior(playerid, GetPlayerInterior(id));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
	new str[130];
	format(str, 130, "{82FA58}Info: {FFFFFF}O %s %s veio ate voce.", CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid));
	SendClientMessage(id, -1, str);
	format(str, 130, "{82FA58}Info: {FFFFFF}Voce foi ate o jogador %s.", pName(id));
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:tv(playerid, params[])
{
	new id;
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /tv [ID]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Jogador Offline");
	TogglePlayerSpectating(playerid, 1);
	if(!IsPlayerInAnyVehicle(id)) PlayerSpectatePlayer(playerid, id);
	else PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id));
	SetPlayerInterior(playerid, GetPlayerInterior(id));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
	Assistindo[playerid] = true;
	new str[100];
	format(str, 100, "Info: {FFFFFF}Voce esta telando o jogador %s", pName(id));
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:sairtv(playerid)
{
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	TogglePlayerSpectating(playerid, 0);
	SendClientMessage(playerid, -1, "Voce nao esta mais telando o jogador");
	Assistindo[playerid] = false;
	return 1;
}

CMD:trazer(playerid, params[])
{
	new id, Float:Pos[3];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /trazer [ID]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Jogador Offline");
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	SetPlayerPos(id, Pos[0]+1, Pos[1], Pos[2]);
	SetPlayerInterior(id, GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(playerid));
	new str[130];
	format(str, 130, "{82FA58}Info: {FFFFFF}O %s %s trouxe voce ate ele.", CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid));
	SendClientMessage(id, -1, str);
	format(str, 130, "{82FA58}Info: {FFFFFF}Voce trouxe o jogador %s.", pName(id));
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:veh(playerid, params[])
{
	new idcarro, cor1, cor2, Float:Pos[4], carro, str[90];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "ddd", idcarro, cor1, cor2)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /veh [ID Veiculo] [Cor1] [Cor2]");
	if(idcarro <400 || idcarro > 611) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Veiculo invalido");
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	GetPlayerFacingAngle(playerid, Pos[3]);
	carro = CreateVehicle(idcarro, Pos[0], Pos[1], Pos[2], Pos[3], cor1, cor2, -1);
	PutPlayerInVehicle(playerid, carro, 0);
	format(str, 130, "{82FA58}Info: {FFFFFF}Voce spawnou o carro %d.", idcarro);
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:kick(playerid, params[])
{
	new id, motivo[50];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "ds[50]", id, motivo)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /kick [ID] [Motivo]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Jogador Offline");	
	SetTimerEx("DelayKick", 500, false, "d", id);
	new str[120];
	format(str, 120, "{82FA58}Admin: {FFFFFF} O {82FA58}%s %s {FFFFFF}kickou o jogador {82FA58}%s. {FFFFFF}Motivo:{82FA58}%s", CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid), pName(id), motivo);
	SendClientMessageToAll(-1, str);
	return 1;
}

CMD:banir(playerid, params[])
{
	new id, dias, motivo[50];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "uds[50]", id, dias, motivo)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /banir [ID] [Dias] [Motivo]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Jogador Offline");	
	new pastaban[60], str[210];
	format(pastaban, 60, "Banidos/%s.ini", pName(id));
	dini_Create(pastaban);
	DiasBan[playerid] = ConvertDays(dias);
	dini_IntSet(pastaban, "DiasBan", DiasBan[playerid]);
	dini_Set(pastaban, "Motivo", motivo);
	dini_Set(pastaban, "Admin", pName(playerid));
	new Ano, Mes, Dia;
	getdate(Ano, Mes, Dia);
	format(str, 50, "%02d/%02d/%d", Dia, Mes, Ano);
	dini_Set(pastaban, "Data", str);
	SetTimerEx("DelayKick", 500, false, "d", id);
	format(str, 210, "{82FA58}Ban: {FFFFFF}O{82FA58} %s %s{FFFFFF} baniu o jogador {82FA58}%s{FFFFFF} por {82FA58}%d {FFFFFF}dias. Motivo:{FFFFFF} {82FA58}%s",  CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid), pName(id), dias, motivo);
	SendClientMessageToAll(-1, str);
	return 1;
}

CMD:banirip(playerid, params[])
{
	new id, dias, motivo[50];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "uds[50]", id, dias, motivo)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /banirip [ID] [Dias] [Motivo]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Jogador Offline");	
	new pastaipban[70], str[350], ip[50];
	GetPlayerIp(id, ip, sizeof(ip));
	format(pastaipban, 70, "IpsBanidos/%s.ini", ip);
	dini_Create(pastaipban);
	DiasBan[playerid] = ConvertDays(dias);
	dini_IntSet(pastaipban, "DiasBan", DiasBan[playerid]);
	dini_Set(pastaipban, "Motivo", motivo);
	dini_Set(pastaipban, "Admin", pName(playerid));
	dini_Set(pastaipban, "Nick", pName(id));
	new Ano, Mes, Dia;
	getdate(Ano, Mes, Dia);
	format(str, 50, "%02d/%02d/%d", Dia, Mes, Ano);
	dini_Set(pastaipban, "Data", str);
	format(str, sizeof(str), "{82FA58}O{FFFFFF}O{82FA58} %s %s{FFFFFF} baniu por ip o {82FA58}%s{FFFFFF} por {82FA58}%d {FFFFFF}dias. Motivo:{FFFFFF} {82FA58}%s",  CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid), pName(id), dias, motivo); //Mensagem do ban
	SendClientMessageToAll(-1, str);
	SetTimerEx("DelayKick", 1000, false, "d", id);
	
	return 1;
}

CMD:desban(playerid, params[])
{
	new nick[50];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "s[50]", nick)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /desban [Nick]");
	new pastaban[60], str[210];
	format(pastaban, 60, "Banidos/%s.ini", nick);
	if(dini_Exists(pastaban)) dini_Remove(pastaban);
	else return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Este player nao esta banido.");
	format(str, 210, "{82FA58}Ban: {FFFFFF}O{82FA58} %s %s{FFFFFF} desbaniu o jogador {82FA58}%s",  CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid), nick);
	SendClientMessageToAll(-1, str);
	return 1;
}

CMD:desbanip(playerid, params[])
{
	new ip[50];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "s[50]", ip)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /desbanip [ip]");
	new pastaban[60], str[210];
	format(pastaban, 60, "IpsBanidos/%s.ini", ip);
	if(dini_Exists(pastaban)) dini_Remove(pastaban);
	else return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Este ip nao esta banido.");
	format(str, 210, "{82FA58}Ban: {FFFFFF}O{82FA58} %s %s{FFFFFF} desbaniu o jogador {82FA58}%s",  CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid), dini_Get(pastaban, "Nick")); // desbanindo o ip e exibindo o nick
	SendClientMessageToAll(-1, str);
	return 1;
}

CMD:mudarnick(playerid, params[])
{
	new id, nick[50], str[210];
	if(!IsPlayerAdmin(playerid) && pInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao tem autorizacao");
	if(TrabalhandoAdmin[playerid] == false) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Voce nao esta em modo trabalho");
	if(sscanf(params, "us[50]", id, nick)) return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Use /mudarnick [Id] [Nick]");
	format(str, 60, "Contas/%s.ini", nick);
	new pastaconta[60];
	format(pastaconta, 60, "Contas/%s.ini", nick);
	if(!dini_Exists(pastaconta))
	{
		DINI_frenametextfile(Arquivo(id), str);
		format(str, 130, "{82FA58}Info: {FFFFFF}O %s %s trocou o nick para %s.", CargoPlayer(pInfo[playerid][pAdmin]), pName(playerid), nick);
		SendClientMessage(id, -1, str);
		format(str, 130, "{82FA58}Info: {FFFFFF}Voce trocou o nick do jogador %s para %s.", pName(id), nick);
		SendClientMessage(playerid, -1, str);
		SetPlayerName(id, nick);
	} 
	else return SendClientMessage(playerid, -1, "{FA5858}Erro: {FFFFFF}Este nick ja existe.");
	return 1;
}

CMD:admins(playerid)
{
	new str[500], string[100], admins = 0;
	for(new i = 0; i< MAX_PLAYERS; i++)
	{
		if(pInfo[i][pAdmin] > 0 && TrabalhandoAdmin[i] == true)
		{
			format(string, 100, "{A9F5F2}%s - {FFFFFF}Cargo: {58D3F7}%s\n", pName(i), CargoPlayer(pInfo[i][pAdmin])); //exibe os adms no modo trabalho
			strcat(str, string);
			admins ++;
		}
	}
	if(admins == 0) return SendClientMessage(playerid, -1, "{FA5858}Erro: Nao ha nenhum admin online.");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "Admins", str, "Ok", "Fechar");
	return 1;
}

stock VerificarDias(dias)
	return (dias) < gettime();

stock VerificarBan(playerid)
{
	new pastaban[60], pastaipban[50],str[210], ip[50];
	GetPlayerIp(playerid, ip, sizeof(ip));
	format(pastaban, 60, "Banidos/%s.ini", pName(playerid));
	if(dini_Exists(pastaban))
	{
		DiasBan[playerid] = dini_Int(pastaban, "DiasBan");
		if(VerificarDias(DiasBan[playerid]))
		{
			SendClientMessage(playerid, -1, "Info: {FFFFFF}Seu ban acabou, esta livre para jogar novamente");
			DiasBan[playerid] = 0;
			dini_Remove(pastaban);
		}
		else
		{
			format(str, 210, "{FF0000}=-=- Voce esta banido =-=-\n\n{FFFFFF}Informacoes do banimento\n\n{58D3F7}Admin Responsavel: {FFFFFF}%s\n{58D3F7}Dia do Banimento: {FFFFFF}%s\n{58D3F7}Dias Restantes: {FFFFFF}%s\n{58D3F7}Motivo: %s", dini_Get(pastaban, "Admin"), dini_Get(pastaban, "Data"), ConvertToDays(DiasBan[playerid]), dini_Get(pastaban, "Motivo"));
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Banido", str, "Sair", "Fechar");
			SetTimerEx("DelayKick", 500, false, "d", playerid);
		}
	}
	format(pastaipban, 60, "IpsBanidos/%s.ini", ip);
	if(dini_Exists(pastaipban))
	{
		DiasBan[playerid] = dini_Int(pastaipban, "DiasBan");
		if(VerificarDias(DiasBan[playerid]))
		{
			SendClientMessage(playerid, -1, "Info: {FFFFFF}Seu ban acabou, esta livre para jogar novamente");
			DiasBan[playerid] = 0;
			dini_Remove(pastaipban);
		}
		else
		{
			format(str, 210, "{FF0000}=-=- Voce esta banido =-=-\n\n{FFFFFF}Informacoes do banimento\n\n{58D3F7}Admin Responsavel: {FFFFFF}%s\n{58D3F7}Dia do Banimento: {FFFFFF}%s\n{58D3F7}Dias Restantes: {FFFFFF}%s\n{58D3F7}Motivo: %s", dini_Get(pastaipban, "Admin"), dini_Get(pastaipban, "Data"), ConvertToDays(DiasBan[playerid]), dini_Get(pastaipban, "Motivo"));
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Banido", str, "Sair", "Fechar");
			SetTimerEx("DelayKick", 500, false, "d", playerid);
		}
	}
	return 1;
}

stock ConvertToDays(n)
{
	#pragma tabsize 0
	new t[5], DString[75];
    t[4] = n-gettime();
	t[0] = t[4] / 3600;
	t[1] = ((t[4] / 60) - (t[0] * 60));
	t[2] = (t[4] - ((t[0] * 3600) + (t[1] * 60)));
	t[3] = (t[0]/24);

	if(t[3] > 0)
		t[0] = t[0] % 24,
		format(DString, sizeof(DString), "%ddias, %02dh %02dm e %02ds", t[3], t[0], t[1], t[2]);
	else if(t[0] > 0)
		format(DString, sizeof(DString), "%02dh %02dm e %02ds", t[0], t[1], t[2]);
	else
		format(DString, sizeof(DString), "%02dm e %02ds", t[1], t[2]);
	return DString;
}



forward DelayKick(playerid);
public DelayKick(playerid)
{
	Kick(playerid);
	return 1;
}

forward SairCadeia(playerid);
public SairCadeia(playerid)
{
	pInfo[playerid][pSegundosAdmin] -= 1; 
	new str[50];
	format(str, 50, "%02d:%02d", pInfo[playerid][pMinutosAdmin], pInfo[playerid][pSegundosAdmin]);
	PlayerTextDrawSetString(playerid, Text_Timer[playerid][0], str);
	PlayerTextDrawShow(playerid, Text_Timer[playerid][0]);
	if(pInfo[playerid][pSegundosAdmin] == 0 && pInfo[playerid][pMinutosAdmin] > 0)
	{
		pInfo[playerid][pMinutosAdmin] -=1;
		pInfo[playerid][pSegundosAdmin] = 59;

	}
	if(pInfo[playerid][pSegundosAdmin] == 0 && pInfo[playerid][pMinutosAdmin] == 0)
	{
		new pasta[50];
		format(pasta, 50, "Cadeia/%s.ini", pName(playerid));
		dini_Remove(pasta);
		SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 1408.4352,-964.8619,46.9375,356.3838, 0, 0, 0, 0, 0, 0);
		SpawnPlayer(playerid);
		SendClientMessage(playerid, -1, "Voce foi solto");
		KillTimer(TimerCadeia[playerid]);
		pInfo[playerid][pPresoAdmin] = 0;
		SetPlayerInterior(playerid, 0);
		PlayerTextDrawHide(playerid, Text_Timer[playerid][0]);
		SalvarConta(playerid);
	}
	return 1;
}

CMD:comer(playerid)
{
	if(pInfo[playerid][pFome] > 70) return SendClientMessage(playerid, -1, "Voce nao esta com muita fome");
	pInfo[playerid][pFome] += 30;
	SendClientMessage(playerid, -1, "Voce comeu um hamburger");
	new string[30];
	format(string, 30, "%d%", pInfo[playerid][pFome]);
	PlayerTextDrawSetString(playerid, Text_Hud[playerid][2], string);
	PlayerTextDrawShow(playerid, Text_Hud[playerid][2]);
	ApplyAnimation(playerid, "food", "eat_burger", 4.1, 0, 0, 0, 0, -1);
	return 1;
}

CMD:beber(playerid)
{
	if(pInfo[playerid][pSede] > 60) return SendClientMessage(playerid, -1, "Voce nao esta com muita sede");
	pInfo[playerid][pSede] += 40;
	new string[30];
	format(string, 30, "%d%", pInfo[playerid][pSede]);
	PlayerTextDrawSetString(playerid, Text_Hud[playerid][4], string);
	SendClientMessage(playerid, -1, "Voce bebeu uma garrafa de agua");
	PlayerTextDrawShow(playerid, Text_Hud[playerid][4]);
	ApplyAnimation(playerid, "vending", "vend_drink2_p", 4.1, 0, 0, 0, 0, -1);
	return 1;
}

CMD:dormir(playerid)
{
	if(Dormindo[playerid] == true) return 1;
	SetTimerEx("TimerDormir", 10000, false, "d", playerid);
	SendClientMessage(playerid, -1, "Voce esta dormindo");
	TextDrawShowForPlayer(playerid, Text_Dormindo[0]);
	ApplyAnimation(playerid, "crack", "crckdeth1", 4.1, 0, 0, 0, 0, -1);
	Dormindo[playerid] = true;
	return 1;
}

forward TimerDormir(playerid);
public TimerDormir(playerid)
{
	pInfo[playerid][pSono] = 100;
	new string[30];
	format(string, 30, "%d%", pInfo[playerid][pSono]);
	PlayerTextDrawSetString(playerid, Text_Hud[playerid][8], string);
	SendClientMessage(playerid, -1, "Voce acordou de um belo sono");
	PlayerTextDrawShow(playerid, Text_Hud[playerid][8]);
	TextDrawHideForPlayer(playerid, Text_Dormindo[0]);
	Dormindo[playerid] = false;
	ClearAnimations(playerid);
	return 1;
}

forward TimerSalvarConta(playerid);
public TimerSalvarConta(playerid)
{
	SalvarConta(playerid);
	return 1;
}


CMD:teste(playerid)
{
	SetPlayerSkin(playerid, 50); //Colocando a skin no player
	GivePlayerMoney(playerid, 12000); //Dando money pra o player
	GivePlayerWeapon(playerid, 31, 1000); // arma
	GivePlayerWeapon(playerid, 24, 1000); // arma1
	GivePlayerWeapon(playerid, 17, 1000); // arma2
	return 1;
}

stock ProxDetector(playerid, Float:max_range, color, const string[], Float:max_ratio = 1.6)
{
	new
		Float:pos_x,
		Float:pos_y,
		Float:pos_z,
		Float:range,
		Float:range_ratio,
		Float:range_with_ratio,
		clr_r, clr_g, clr_b,
		Float:color_r, Float:color_g, Float:color_b;

	if (!GetPlayerPos(playerid, pos_x, pos_y, pos_z)) {
		return 0;
	}

	color_r = float(color >> 24 & 0xFF);
	color_g = float(color >> 16 & 0xFF);
	color_b = float(color >> 8 & 0xFF);
	range_with_ratio = max_range * max_ratio;

#if defined foreach
	foreach (new i : Player) {
#else
	for (new i = GetPlayerPoolSize(); i != -1; i--) {
#endif
		if (!IsPlayerStreamedIn(i, playerid)) {
			continue;
		}

		range = GetPlayerDistanceFromPoint(i, pos_x, pos_y, pos_z);
		if (range > max_range) {
			continue;
		}

		range_ratio = (range_with_ratio - range) / range_with_ratio;
		clr_r = floatround(range_ratio * color_r);
		clr_g = floatround(range_ratio * color_g);
		clr_b = floatround(range_ratio * color_b);

		SendClientMessage(i, (color & 0xFF) | (clr_b << 8) | (clr_g << 16) | (clr_r << 24), string);
	}

	SendClientMessage(playerid, color, string);
	return 1;
}
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

enum Player
{
	pFome,
	pSede,
	pSono,
	pGrana,
	pSkin,
	pAdmin
};

new pInfo[MAX_PLAYERS][Player];
new PlayerText:Text_Hud[MAX_PLAYERS][9];
new Text:Text_Dormindo[1];
new bool:Dormindo[MAX_PLAYERS];
new DiasBan[MAX_PLAYERS];
new bool:Assistindo[MAX_PLAYERS];
new bool:TrabalhandoAdmin[MAX_PLAYERS];
new SkinStaff[MAX_PLAYERS];

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
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 1408.4352,-964.8619,46.9375,356.3838, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	if(!dini_Exists(Arquivo(playerid)))
	{
		dini_Create(Arquivo(playerid));
		pInfo[playerid][pFome] = 100;
		pInfo[playerid][pSede] = 100;
		pInfo[playerid][pAdmin] = 0;
		pInfo[playerid][pSono] = 100;
		SalvarConta(playerid);

	} 
	CarregarConta(playerid);
	VerificarBan(playerid);
	GivePlayerMoney(playerid,pInfo[playerid][pGrana]);
	SetPlayerSkin(playerid, pInfo[playerid][pSkin]);

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
	return 1;
}

public OnPlayerConnect(playerid)
{
	LimparVariaveis(playerid);
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
	return 1;
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
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
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
	return 1;
}

stock LimparVariaveis(playerid)
{
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

stock VerificarDias(dias)
	return (dias) < gettime();

stock VerificarBan(playerid)
{
	new pastaban[60],str[210];
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
	SetPlayerSkin(playerid, 50);
	GivePlayerMoney(playerid, 12000);
	GivePlayerWeapon(playerid, 31, 1000);
	GivePlayerWeapon(playerid, 24, 1000);
	GivePlayerWeapon(playerid, 17, 1000);
	return 1;
}
#include "a_samp.inc"
#include "izcmd.cpp"

new bool:JogadorReconnect[MAX_PLAYERS];
new StringPlayer[18+8], IPstring[18];

CMD:reconnect(playerid)
{
    ReconnectPlayer(playerid);
    return 1;
}
stock ReconnectPlayer(idplayer)
{
    GetPlayerIp(idplayer, IPstring, 18), SetPVarString(idplayer, "PlayerIP", IPstring);
    format(StringPlayer, sizeof(StringPlayer), "banip %s", IPstring);
    SendRconCommand(StringPlayer);
    //
    JogadorReconnect[idplayer] = true;
    DesbanirReconnectPlayer(idplayer);
    return SendClientMessage(idplayer, 0xFFFFFFFF, "Aguarde, voce esta reconectando!");
}
stock DesbanirReconnectPlayer(idplayer)
{
    GetPlayerIp(idplayer, IPstring, 18), SetPVarString(idplayer, "PlayerIP", IPstring);
    format(StringPlayer, sizeof(StringPlayer), "unbanip %s", IPstring);
    SendRconCommand(StringPlayer);
    //
    JogadorReconnect[idplayer] = true;
}
public OnPlayerConnect(playerid)
{
    JogadorReconnect[playerid] = false;
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    if(JogadorReconnect[playerid])
    {
        new String[10+18];
        GetPVarString(playerid, "PlayerIP", String, 18);
        format(String, sizeof(String), "unbanip %s", String);
        SendRconCommand(String);
    }
    return 1;
}

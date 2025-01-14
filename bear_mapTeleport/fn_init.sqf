disableSerialization;
private _map = findDisplay 12;
		
private _ctrl_background = _map ctrlCreate ["RscText", 832500];
_ctrl_background ctrlSetPosition [0.43833 * safezoneW + safezoneX, 0.960672 * safezoneH + safezoneY, 0.12334 * safezoneW, 0.0376059 * safezoneH];
_ctrl_background ctrlSetBackgroundColor [0, 0, 0, 0.7];
_ctrl_background ctrlCommit 0;

private _ctrl_button = _map ctrlCreate ["RscButton", 832501];
_ctrl_button ctrlSetPosition [0.442735 * safezoneW + safezoneX, 0.970074 * safezoneH + safezoneY, 0.0396449 * safezoneW, 0.0188029 * safezoneH];
_ctrl_button ctrlSetBackgroundColor [0, 0, 0, 0.8];
_ctrl_button ctrlSetTextColor [1, 1, 1, 1];
_ctrl_button ctrlSetText "Teleport";
_ctrl_button ctrlSetEventHandler ["ButtonClick", "_this call bear_mapTeleport_fnc_toggle; true"];
_ctrl_button ctrlCommit 0;

private _ctrl_description = _map ctrlCreate ["RscText", 832502];
_ctrl_description ctrlSetPosition [0.486785 * safezoneW + safezoneX, 0.970074 * safezoneH + safezoneY, 0.0660748 * safezoneW, 0.0188029 * safezoneH];
_ctrl_description ctrlSetBackgroundColor [0, 0, 0, 0];
_ctrl_description ctrlSetTextColor [1, 1, 1, 1];
_ctrl_description ctrlSetText "Teleport with map click";
_ctrl_description ctrlSetFontHeight 0.035;
_ctrl_description ctrlCommit 0;
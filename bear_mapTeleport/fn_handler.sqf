disableSerialization;
params ["_mapIsOpened"];

if (!_mapIsOpened) then {
	// remove click eh
	private _eh = missionNamespace getVariable ["bear_mapTeleport_eh_mapSingleClick", -1];
	if !(_eh isEqualTo -1) then {
		removeMissionEventHandler ["MapSingleClick", _eh];
	};

	missionNamespace setVariable ["bear_mapTeleport_toggle", false];
	
	private _ctrl_background = (findDisplay 12) displayCtrl 832500;
	_ctrl_background ctrlSetBackgroundColor [0, 0, 0, 0.7];
	_ctrl_background ctrlCommit 0;
};
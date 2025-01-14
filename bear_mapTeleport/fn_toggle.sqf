disableSerialization;

private _state = !(missionNamespace getVariable ["bear_mapTeleport_toggle", false]);
missionNamespace setVariable ["bear_mapTeleport_toggle", _state];

private _background = (findDisplay 12) displayCtrl 832500;

if (_state) then {
	private _eh = addMissionEventHandler ["MapSingleClick", {_this call bear_mapTeleport_fnc_teleport;}];
	missionNamespace setVariable ["bear_mapTeleport_eh_mapSingleClick", _eh];
	
	_background ctrlSetBackgroundColor [0.235, 0.43, 0.235, 0.8];
	
	systemChat "Click anywhere on the map to teleport there.";
} else {
	private _eh = missionNamespace getVariable ["bear_mapTeleport_eh_mapSingleClick", -1];
	if !(_eh isEqualTo -1) then {
		removeMissionEventHandler ["MapSingleClick", _eh];
	};
	
	_background ctrlSetBackgroundColor [0, 0, 0, 0.7];
	
	systemChat "Teleporting toggled off.";
};

_background ctrlCommit 0;
/**
	INIT
	- Executed on everyone including the server when the mission is started (before briefing screen).
*/

F_fnc_drawGroupMarkers = {
	params["_mapControl"];
    private["_pos","_dir"];
	
    {
		if (alive _x && _x == effectiveCommander _x) then {
            _pos = getPos _x;
            _dir = direction _x;
            _mapControl drawIcon["\a3\ui_f_curator\Data\CfgCurator\area_ca.paa",[0,0,0,1],_pos,24,24,_dir];
            _mapControl drawIcon["\a3\ui_f_curator\Data\CfgCurator\area_ca.paa",[0.250,0.533,1,1],_pos,20,20,_dir, (((crew vehicle _x) apply {name _x}) joinString ", "), 2, 0.06, "Zeppelin32"];
        };
	} forEach allPlayers;
    
    {
		_pos = getPos _x;
        _dir = direction _x;
        _mapControl drawIcon["\a3\ui_f_curator\Data\CfgCurator\area_ca.paa",[0,0,0,1],_pos,24,24,_dir];
        _mapControl drawIcon["\a3\ui_f_curator\Data\CfgCurator\area_ca.paa",[1,1,1,1],_pos,20,20,_dir,"(drone)", 2, 0.06, "Zeppelin32"];
	} forEach allUnitsUAV;
};

[{
	if (isNull findDisplay 58) exitWith {};
	
	((findDisplay 58) displayctrl 1050) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
	((findDisplay 58) displayCtrl 1050) ctrlAddEventHandler ["draw", "
		params ['_map'];
		_map drawIcon [
			'#(argb,8,8,3)color(0,0,0,0)',
			[1,1,1,1],
			[8020, 7780],
			24,
			24,
			0,
			'Firing Range',
			2,
			0.08,
			'PuristaSemiBold',
			'right'
		];

		_map drawIcon [
			'#(argb,8,8,3)color(0,0,0,0)',
			[1,1,1,1],
			[9600, 10280],
			24,
			24,
			0,
			'Vehicle Spawn',
			2,
			0.08,
			'PuristaSemiBold',
			'center'
		];
	"];
	[_this select 1] call CBA_fnc_removePerFrameHandler;
},0] call CBA_fnc_addPerFrameHandler;
/**
	INIT PLAYER LOCAL
	- Executed locally when player joins a mission (include mission start).
*/
params ["_player", "_didJIP"];

{
    _x addAction [
		"<t size='2' font='RobotoCondensedBold'>ACE Arsenal</t>", 
		{[player, player, true] call ACE_arsenal_fnc_openBox;}, 
		0, 102, true, false
	];
	_x addAction [
		"<t size='2' font='RobotoCondensedBold'>BIS Arsenal</t>", 
		{0 = ["Open", true] spawn BIS_fnc_arsenal;}, 
		0, 102, true, false
	];
} forEach [box1, box2, box3, box4, box6, box7, box9, box10];

// Add garage action to specific objects
{
    _x addAction [
        "<t size='2'>Virtual Garage</t>",
        {
            [
                ["vehrequest_marker_1", "vehrequest_marker_2", "vehrequest_marker_3", "vehrequest_marker_4", "vehrequest_marker_5"],
                true,
                ["Car","Tank","Helicopter","Plane"]
            ] call opec_fnc_garageNew
        }
    ];
} forEach [vehrequest_1_point];

// Add garage action to specific objects
{
    _x addAction [
        "<t size='2'>Virtual Garage</t>",
        {
            [
                ["vehrequest_marker_1", "vehrequest_marker_2", "vehrequest_marker_3", "vehrequest_marker_4", "vehrequest_marker_5"],
                true,
                ["Boat"]
            ] call opec_fnc_garageNew
        }
    ];
} forEach [boatrequest_1_point];

bear_mapTeleport_eh_map = addMissionEventHandler ["Map", {_this call bear_mapTeleport_fnc_handler;}];
[
	{
		!isNull (findDisplay 12)
	},
	{
		call bear_mapTeleport_fnc_init;
	}
] call CBA_fnc_waitUntilAndExecute;

fn_action_instructor_teleport = { 
	titleText ["Click on the map to teleport", "PLAIN DOWN"]; titleFadeOut 7;
	plInsMapClickEvent = {
		player setPos [(_pos select 0), (_pos select 1), 0];
		onMapSingleClick "";
		openMap [false, false];
	};
	openMap [true, false];
	onMapSingleClick "[] call plInsMapClickEvent";
};

[{
    if (isNil "BIS_fnc_init") exitWith {};
    if (isNull findDisplay 46) exitWith {};
    if (player != player || time < 2) exitWith {};
    if (ctrlShown ((findDisplay 58) displayCtrl 1050)) exitWith {};
	
	("bear_layer_welcomemessage" call BIS_fnc_rscLayer) cutRsc ["RscBear_WelcomeMessage", "PLAIN"];
	
    [_this select 1] call CBA_fnc_removePerFrameHandler;
}, 0.5] call CBA_fnc_addPerFrameHandler;

0 = 0 spawn {
	waitUntil {!isNull (findDisplay 12)};
	
	((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", "
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
};

player addRating 900000;

range_trigger = createTrigger ["EmptyDetector", [7925, 7580], false];
range_trigger setTriggerArea [300, 200, 0, true];
range_trigger setTriggerActivation ["VEHICLE", "PRESENT", true];
range_trigger triggerAttachVehicle [player];
range_trigger setTriggerStatements ["this && ((vehicle player) == player)", "player allowDamage false; player setVariable ['ace_medical_allowDamage', false, true];", "player allowDamage true; player setVariable ['ace_medical_allowDamage', true, true];"];

start_trigger = createTrigger ["EmptyDetector", [4900, 15500], false];
start_trigger setTriggerArea [150, 150, 0, true];
start_trigger setTriggerActivation ["VEHICLE", "PRESENT", true];
start_trigger triggerAttachVehicle [player];
start_trigger setTriggerStatements ["this && ((vehicle player) == player)", "player allowDamage false; player setVariable ['ace_medical_allowDamage', false, true];", "player allowDamage true; player setVariable ['ace_medical_allowDamage', true, true];"];
/*
 * Function: fn_garageNew
 * Description: This script handles the spawning of vehicles in a virtual garage.
 *              It iterates through an array of markers to find a free space for spawning.
 *              If no free space is found, it prompts the user to clear a space.
 * 
 * Parameters:
 *   _markerArray - Array of marker names to check for free space
 *   _addEvents   - Boolean: whether to add default events to spawned vehicle (default: true)
 * 
 * Usage:
 *   Simple: [["marker1", "marker2"], true, false] call opec_fnc_garageNew;
 *   No events: [["marker1", "marker2"], false, false] call opec_fnc_garageNew;
 *   Add Action: this addAction ["Create Vehicle", { [["marker1", "marker2"], true, false] call opec_fnc_garageNew }];
 */

disableSerialization;

params [
    ["_markerArray", [], [[]]],
    ["_addEvents", true, [true]]
];

// Validate markers
private _validMarkers = _markerArray select {getMarkerType _x != ""};
if (count _validMarkers != count _markerArray) then {
    hint format["Some markers are invalid. Found %1 valid out of %2", count _validMarkers, count _markerArray];
};
_markerArray = _validMarkers;

// Initial checks
if (_markerArray isEqualTo []) exitWith {
    hint "No valid markers provided for garage spawn points.";
};

if (isNil "garage_claimed_markers") then {
    missionNamespace setVariable ["garage_claimed_markers", createHashMap];
};

_freeSpaceFound = false;

// Check each marker for free space
{
	private _pos = getMarkerPos _x;
	private _nearbyVehicles = nearestObjects [_pos, ["AllVehicles"], 20] select {!(_x isKindOf "CAManBase")};
	private _nearbyPlayers = (_pos nearEntities [["CAManBase"], 10]) select {alive _x && isPlayer _x};
	private _isClaimed = (missionNamespace getVariable "garage_claimed_markers") getOrDefault [_x, false];
	
	if ((count _nearbyVehicles) == 0 && (count _nearbyPlayers) == 0 && !_isClaimed) exitWith {
		(missionNamespace getVariable "garage_claimed_markers") set [_x, true];
		uiNamespace setVariable ["current_garage", _x];
		_freeSpaceFound = true;
	};
} forEach _markerArray;

// If no free space is found, prompt the user to clear a space
if (!_freeSpaceFound) exitWith {
	hint "No free space available. Please clear a space and try again.";
};

hint "Garage Viewer is now running";

// Find the marker position first
_markerPos = getMarkerPos (uiNamespace getVariable "current_garage");

// Make the player face the spawn point
player setDir ([player, _markerPos] call BIS_fnc_dirTo);

_veh = createVehicle [ "Land_HelipadEmpty_F", _markerPos, [], 0, "" ];
uiNamespace setVariable [ "garage_pad", _veh ];
missionNamespace setVariable [ "BIS_fnc_arsenal_fullGarage", [true, 0, false, [false]] call BIS_fnc_param ];

with missionNamespace do {
	BIS_fnc_garage_center = [ true, 1, _veh, [ objNull ] ] call BIS_fnc_param;
};

with uiNamespace do {
	_displayMission = [] call (uiNamespace getVariable "bis_fnc_displayMission");
	if !(isNull findDisplay 312) then {
		_displayMission = findDisplay 312;
	};
	_displayMission createDisplay "RscDisplayGarage";
	uiNamespace setVariable [ "running_garage", true ];
	waitUntil {
		sleep 0.25;
		isNull (uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ])
	};

	_marker = uiNamespace getVariable "current_garage";
    (missionNamespace getVariable "garage_claimed_markers") set [_marker, false];
    
	_pad = uiNamespace getVariable "garage_pad";
	deleteVehicle _pad;
	
	_new_veh = objNull;

	_veh_list = ((getMarkerPos _marker) nearEntities 5) select {!(_x isKindOf "CAManBase")};
	{
		_new_veh = _x;

		_crew = crew _x;
		{
			_x spawn {
				if (!isPlayer _this) then {
					_this action ["Eject", vehicle _this];
					sleep 0.5;
					deleteVehicle _this;
				};
			};
		} forEach _crew;
	} forEach _veh_list;

	// Only add events if _addEvents is true
	if (_addEvents) then {
		_new_veh addAction [
			"Enter Vehicle",
			{
				params ["_target", "_caller"];
				_caller moveInAny _target;
			},
			nil,
			1.5,
			true,
			true,
			"",
			"true",
			100  // Distance parameter
		];

		_new_veh addAction [
			"Delete Vehicle",
			{
				params ["_target", "_caller"];
				
				// Add confirmation action that will auto-remove after 10 seconds
				hint "Confirm vehicle deletion by pressing the Delete Confirmation action within 10 seconds.";
				private _confirmID = _target addAction [
					"<t color='#ff0000'>Delete Confirmation</t>",
					{
						params ["_target", "_caller"];
						{
							_x action ["Eject", vehicle _x];
							sleep 0.5;
							deleteVehicle _x;
						} forEach crew _target;
						deleteVehicle _target;
					},
					nil,
					20,  // Higher priority than other actions
					true,
					true,
					"",
					"true",
					50
				];
				
				// Remove confirmation action after 10 seconds
				[_target, _confirmID] spawn {
					params ["_veh", "_actionId"];
					sleep 10;
					_veh removeAction _actionId;
					if (alive _veh) then {
						hint "Vehicle deletion cancelled.";
					};
				};
			},
			nil,
			1.5,
			true,
			true,
			"",
			"true",
			50  // Distance parameter
		];

		_new_veh addEventHandler ["Killed", {
			params ["_veh"];
			_veh spawn {
				sleep 10;
				deleteVehicle _this;
			};
		}];

		// Add one-time inactivity check
		[_new_veh, getPos _new_veh] spawn {
			params ["_vehicle", "_spawnPos"];
			sleep 60;
			if (alive _vehicle && {(_spawnPos distance (getPos _vehicle)) < 2}) then {
				deleteVehicle _vehicle;
				hint "Vehicle deleted due to inactivity at spawn point.";
			};
		};
	};
};
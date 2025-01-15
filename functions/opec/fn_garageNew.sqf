/*
 * Function: fn_garageNew
 * Description: This script handles the spawning of vehicles in a virtual garage.
 *              It iterates through an array of markers to find a free space for spawning.
 *              If no free space is found, it prompts the user to clear a space.
 * 
 * Parameters:
 *   _markerArray - Array of marker names to check for free space
 *   _addEvents   - Boolean: whether to add default events to spawned vehicle (default: true)
 *   _allowedTypes - Array of allowed vehicle types ["Car", "Tank", "Helicopter", "Plane", "Ship", "StaticWeapon"]
 * 
 * Usage:
 *   Simple: [["marker1", "marker2"], true, ["Car", "Tank"]] call opec_fnc_garageNew;
 *   Only helicopters: [["marker1", "marker2"], true, ["Helicopter"]] call opec_fnc_garageNew;
 *   All vehicles: [["marker1", "marker2"], true, ["Car","Tank","Helicopter","Plane","Ship","StaticWeapon"]] call opec_fnc_garageNew;
 *   Add Action: this addAction ["Create Car", { [["marker1"], true, ["Car"]] call opec_fnc_garageNew }];
 */

disableSerialization;

params [
	["_markerArray", [], [[]]],
	["_addEvents", true, [true]],
	["_allowedTypes", ["Car", "Tank", "Helicopter", "Plane", "Ship", "StaticWeapon"], [[]]]
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

// Convert allowed types to category numbers (0=Car, 1=Tank, etc)
private _typeNums = [];
{
    switch (_x) do {
        case "Car": { _typeNums pushBack 0 };
        case "Tank": { _typeNums pushBack 1 };
        case "Helicopter": { _typeNums pushBack 2 };
        case "Plane": { _typeNums pushBack 3 };
        case "Ship": { _typeNums pushBack 4 };
        case "StaticWeapon": { _typeNums pushBack 5 };
    };
} forEach _allowedTypes;

// Store allowed types for this garage instance
uiNamespace setVariable ["garage_allowed_types", _typeNums];

with missionNamespace do {
	BIS_fnc_garage_center = [ true, 1, _veh, [ objNull ] ] call BIS_fnc_param;
};

with uiNamespace do {
	_displayMission = [] call (uiNamespace getVariable "bis_fnc_displayMission");
	if !(isNull findDisplay 312) then {
		_displayMission = findDisplay 312;
	};
	_display = _displayMission createDisplay "RscDisplayGarage";
    
    // Store the allowed controls for tab navigation
    private _allowedControls = [];
    {
        private _ctrl = _display displayCtrl (930+_x);
        _allowedControls pushBack _ctrl;
        
        // Enable these controls explicitly
        _ctrl ctrlEnable true;
        _ctrl ctrlShow true;
    } forEach (uiNamespace getVariable "garage_allowed_types");
    
    // Hide and disable restricted vehicle categories
    {
        private _ctrl = _display displayCtrl (930+_x);
        _ctrl ctrlShow false;
        _ctrl ctrlEnable false;
    } forEach ([0,1,2,3,4,5] - (uiNamespace getVariable "garage_allowed_types"));
    
    // Set initial focus to first allowed control
    if (count _allowedControls > 0) then {
        ctrlSetFocus (_allowedControls select 0);
    };
    
    // Add display event handler to manage tab navigation
    _display displayAddEventHandler ["KeyDown", {
        params ["_display", "_key", "_shift", "_ctrl", "_alt"];
        
        if (_key == 15) then { // Tab key
            private _allowedControls = _display getVariable ["allowedControls", []];
            if (count _allowedControls == 0) exitWith {true};
            
            private _currentCtrl = focusedCtrl _display;
            private _index = _allowedControls find _currentCtrl;
            
            private _nextIndex = if (_shift) then {
                if (_index <= 0) then {count _allowedControls - 1} else {_index - 1}
            } else {
                if (_index >= count _allowedControls - 1) then {0} else {_index + 1}
            };
            
            ctrlSetFocus (_allowedControls select _nextIndex);
            true
        } else {
            false
        };
    }];
    
    // Store allowed controls in display namespace
    _display setVariable ["allowedControls", _allowedControls];
    
    uiNamespace setVariable ["running_garage", true];
    
    // Store last valid control for focus handling
    {
        private _ctrl = _display displayCtrl (930+_x);
        {
            private _restrictedCtrl = _display displayCtrl (930+_x);
            _restrictedCtrl setVariable ["lastValidControl", _ctrl];
        } forEach ([0,1,2,3,4,5] - (uiNamespace getVariable "garage_allowed_types"));
    } forEach (uiNamespace getVariable "garage_allowed_types");
    
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
			 "vehicle _this == _this", // Only show if player is not in any vehicle
			100  // Distance parameter
		];

		_new_veh addAction [
			"Delete Vehicle",
			{
				params ["_target", "_caller"];
				
				// Check if confirmation action already exists
				if (_target getVariable ["deleteConfirmPending", false]) exitWith {
					hint "Delete confirmation already pending.";
				};
				
				// Mark that confirmation is pending
				_target setVariable ["deleteConfirmPending", true, true];
				
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
					20,
					true,
					true,
					"",
					"vehicle _this == _this",
					50
				];
				
				[_target, _confirmID] spawn {
					params ["_veh", "_actionId"];
					sleep 10;
					if (!isNull _veh) then {
						_veh removeAction _actionId;
						_veh setVariable ["deleteConfirmPending", false, true];
						if (alive _veh) then {
							hint "Vehicle deletion cancelled.";
						};
					};
				};
			},
			nil,
			1.5,
			true,
			true,
			"",
			"vehicle _this == _this",
			50
		];

		// Shared function for vehicle deletion
		private _fnc_deleteVehicle = {
			params ["_veh"];
			if (isNull _veh) exitWith {};
			
			// Eject and delete crew
			{
			_x action ["Eject", vehicle _x];
			if (!isPlayer _x) then { deleteVehicle _x };
			} forEach (crew _veh);
			
			// Delete the vehicle
			deleteVehicle _veh;
		};

		// Add killed event handler
		_new_veh addEventHandler ["Killed", {
			params ["_veh"];
			_veh spawn {
			sleep 10;
			if (!isNull _this && {!alive _this}) then {
				[_this] call _fnc_deleteVehicle;
			};
			};
		}];

		// Add one-time inactivity check
		[_new_veh, getPos _new_veh, _fnc_deleteVehicle] spawn {
			params ["_vehicle", "_spawnPos", "_deleteFunc"];
			sleep 60;
			if (!isNull _vehicle && {alive _vehicle} && {(_spawnPos distance (getPos _vehicle)) < 2}) then {
			[_vehicle] call _deleteFunc;
			hint "Vehicle deleted due to inactivity at spawn point.";
			};
		};
	};
};
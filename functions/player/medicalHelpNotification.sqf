/**
	adds a CBA event that display text to the downed player when being helped by someone else.
*/

{
	["ace_medical_treatment_" + _x, 
		{
			if (lifeState ace_player == "INCAPACITATED") then 
			{
				titleText ["<t color='#FFFFFF' size = '1'>Someone is helping you!</t>", "PLAIN", 1, true, true];
			};
		}
	] call CBA_fnc_addEventHandler;
} forEach ["bandageLocal", "cprLocal", "ivBagLocal", "medicationLocal", "splintLocal", "tourniquetLocal"];
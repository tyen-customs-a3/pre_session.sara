Virtual Garage Script
=====================

Features
========
Access the virtual garage, and spawn any vehicles vanilla game or from mods.

Installtion
===========
1. Install the script titled: functions
into your scenario folder, your scenario folder will be located here: 
   C:\Users\username\Documents\Arma 3\missions

2. Create a description.ext and add the following code:

class CfgFunctions {
	class opec
	{
		class opec
		{
			class garageNew {};
		};
	};
};

Addaction Code to add to an object:
===================================
Add the following code to the init box of an object of choice,
this will enable the player to access the virtual garage:

this addaction ["<t color='#FFFF00'>Virtual Garage</t>", {[("markername")] call opec_fnc_garageNew;}];

Marker
======
Add a marker on the map ingame at the location you want your vehicle to spawn at,
the variable name of the marker will be whatever you want to name it.  
    After naming the marker put the name of the marker you chose in the brackets of the 
addaction code above where it says "markername" replace that with yours.

Addaction Code word Color
=========================
In the addaction code above is this code:
"<t color='#FFFF00'>Virtual Garage</t>"
you can change the color of the word Virtual Garage to another color, by changing the Hex number.

The hex number is the #FFFF00 you currently see, go to this website:
https://www.rapidtables.com/web/color/RGB_Color.html
scroll down and go to where it says "RGB color table"

Choose a color you like and then copy its #, then paste the number in replace
 of the default number in the addaction.

Credits
- Readme by Gunter Severloh
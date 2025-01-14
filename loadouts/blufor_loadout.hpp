class baseMan 
{
	displayName = "Unarmed";
	uniform[] = {};
	vest[] = {};
	backpack[] = {};
	headgear[] = {};
	goggles[] = {};
	hmd[] = {};
	faces[] = {};
	insignias[] = {};
	primaryWeapon[] = {};
	scope[] = {};
	bipod[] = {};
	attachment[] = {};
	silencer[] = {};
	secondaryWeapon[] = {};
	secondaryAttachments[] = {};
	sidearmWeapon[] = {};
	sidearmAttachments[] = {};
	magazines[] = {};
	items[] = {};
	linkedItems[] = 
	{
		"ItemWatch",
		"ItemMap",
		"ItemCompass"
	};
	backpackItems[] = {};
	code = "";
};

class jip : baseMan
{
	displayName = "JIP";
	uniform[] = 
	{
		"U_B_CombatUniform_mcam"
	};
	items[] =
	{
		"ACRE_PRC343",
		LIST_10("ACE_fieldDressing"),
		LIST_4("ACE_tourniquet"),
		LIST_2("ACE_epinephrine"),
		LIST_2("ACE_morphine"),
		LIST_2("ACE_splint")
	};
};
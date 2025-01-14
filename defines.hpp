#define BEAR_RSCTEXT style = 0;\
type = 0;\
access = 0;\
colorShadow[] = {0,0,0,0.5};\
colorText[] = {1,1,1,1};\
fade = 0;\
font = "RobotoCondensed";\
linespacing = 1;\
shadow = 1;\
SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

#define BEAR_RSCCOMBO access = 0;\
type = 4;\
style = "0x10 + 0x200";\
font = "RobotoCondensed";\
sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";\
shadow = 0;\
wholeHeight = 0.45;\
colorSelect[] = {0,0,0,1};\
colorText[] = {1,1,1,1};\
colorBackground[] = {0,0,0,1};\
colorScrollbar[] = {1,0,0,1};\
colorDisabled[] = {1,1,1,0.25};\
colorSelectBackground[] = {1,1,1,0.7};\
arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";\
arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";\
class ComboScrollBar {\
	color[] = {1,1,1,1};\
	colorActive[] = {1, 1, 1, 1};\
	colorDisabled[] = {1, 1, 1, 0.3};\
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";\
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";\
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";\
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";\
	shadow = 0;\
	scrollSpeed = 0.06;\
	width = 0;\
	height = 0;\
	autoScrollEnabled = 0;\
	autoScrollSpeed = -1;\
	autoScrollDelay = 5;\
	autoScrollRewind = 0;\
};

#define BEAR_RSCBUTTON 	type = 16;\
	style = "0x02 + 0xC0";\
	shadow = 0;\
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";\
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";\
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";\
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";\
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";\
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";\
	colorBackground[] = {\
		0, 0, 0, 0.8\
	};\
	colorBackgroundFocused[] = {\
		1, 1, 1, 1\
	};\
	colorBackground2[] = {\
		0.75, 0.75, 0.75, 1\
	};\
	color[] = {\
		1, 1, 1, 1\
	};\
	colorFocused[] = {\
		0, 0, 0, 1\
	};\
	color2[] = {\
		0, 0, 0, 1\
	};\
	colorText[] = {\
		1, 1, 1, 1\
	};\
	colorDisabled[] = {\
		1, 1, 1, 0.25\
	};\
	textSecondary = "";\
	colorSecondary[] = {\
		1, 1, 1, 1\
	};\
	colorFocusedSecondary[] = {\
		0, 0, 0, 1\
	};\
	color2Secondary[] = {\
		0, 0, 0, 1\
	};\
	colorDisabledSecondary[] = {\
		1, 1, 1, 0.25\
	};\
	sizeExSecondary = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";\
	fontSecondary = "PuristaLight";\
	period = 1.2;\
	periodFocus = 1.2;\
	periodOver = 1.2;\
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";\
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";\
	tooltipColorText[] = {\
		1, 1, 1, 1\
	};\
	tooltipColorBox[] = {\
		1, 1, 1, 1\
	};\
	tooltipColorShade[] = {\
		0, 0, 0, 0.65\
	};\
	class TextPos{\
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";\
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";\
		right = 0.005;\
		bottom = 0;\
	};\
	class Attributes{\
		font = "PuristaLight";\
		color = "#E5E5E5";\
		align = "left";\
		shadow = "false";\
	};\
	class ShortcutPos{\
		left = "5.25 * (((safezoneW / safezoneH) min 1.2) / 40)";\
		top = 0;\
		w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";\
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";\
	};\
	soundEnter[] = {\
		"\A3\ui_f\data\sound\RscButtonMenu\soundEnter", 0.09, 1\
	};\
	soundClick[] = {\
		"\A3\ui_f\data\sound\RscButtonMenu\soundClick", 0.09, 1\
	};\
	soundEscape[] = {\
		"\A3\ui_f\data\sound\RscButtonMenu\soundEscape", 0.09, 1\
	};\
};
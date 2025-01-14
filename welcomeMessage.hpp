//Author: Bear
class RscBear_WelcomeMessage
{
	duration = 24;
	fadein = 1;
	fadeout = 1;
	idd = 95716;
	onLoad = "uiNamespace setVariable ['Bear_WelcomeMessage_Display', _this select 0]; 0 call bear_fnc_welcomeMessage";
	onUnload = "uiNamespace setVariable ['Bear_WelcomeMessage_Display', displayNull]";
	name = "RscBear_WelcomeMessage";
	
	enableSimulation = 1;
	movingEnable = 0;
	
	x = 0.35023 * safezoneW + safezoneX;
	y = 0.321372 * safezoneH + safezoneY;
	w = 0.299539 * safezoneW;
	h = 0.357256 * safezoneH;
	class controls
	{
		class textHeader
		{
			idc = 95717;
			
			text = "";
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,0,0,0};
			
			font = "PuristaSemiBold";
			sizeEx = 0.1;
			shadow = 2;
			
			type = 0;
			style = 0;
			
			x = 0.014977 * safezoneW;
			y = 0.037863 * safezoneH;
			w = 0.269585 * safezoneW;
			h = 0.0535884 * safezoneH;
		};
		class textBody
		{
			idc = 95718;
			type = CT_STRUCTURED_TEXT;
			style = ST_MULTI + ST_NO_RECT;
			lineSpacing = 0.25;
			font = "RobotoCondensed";
			size = 0.04;
			text = "";
			x = 0.014977 * safezoneW;
			y = 0.099314 * safezoneH;
			w = 0.269585 * safezoneW;
			h = 0.250079 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,0,0,0};
			sizeEx = 0.035;
			shadow = 2;
		};
	};
};
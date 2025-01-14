if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["Bear_WelcomeMessage_Display", findDisplay 95716];
private _header = _display displayCtrl 95717;
private _body = _display displayCtrl 95718;

private _textHeader = localize "str_bear_greeting";
private _textBody = composeText [
	parseText "<t size='1.1'>This is a warm up mission where people can gather in-game or for people to test out that all their stuff are working correctly.</t>"
];

_header ctrlSetText _textHeader;
_body ctrlSetStructuredText _textBody;
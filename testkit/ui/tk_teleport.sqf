private "_display";
disableSerialization;
_display = findDisplay 12 displayCtrl 51;

call tk_addMap;
tk_teleportOn = !tk_teleportOn;

if (tk_teleportOn) then {
	tk_doTeleport = {
		private ["_height","_pos"];
		_height = if (vehicle player isKindOf "Air" && (getPosATL vehicle player) select 2 > 5) then {100} else {0.5};
		_pos = [_this select 0,_this select 1,_height];
		systemChat format["Teleport to %1",_pos];
		preloadCamera _pos;
		(vehicle player) setPos _pos;
		openMap [false,false];
		{player reveal _x} count (player nearEntities ["AllVehicles",100]);
	};
	
	["Toggle teleport",true] call tk_scriptToggle;
	_done = false;
	closedialog 0;
	systemChat format["Click on the map to Teleport"];
	
	if(!(visibleMap)) then {
		openMap [true, false];
	};
	
	onMapSingleClick '[_pos select 0, _pos select 1, _pos select 2] call tk_doTeleport';
} else {
	["Toggle teleport",false] call tk_scriptToggle;
	onMapSingleClick "";
};
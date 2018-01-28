_handled = _this call DZ_KeyDown_EH_Original;

#include "\ca\editor\Data\Scripts\dikCodes.h"

//Check if keyboard_keys reset (startup or player changed controls in-game)
_code = keyboard_keys select DIK_GRAVE;
if (isNil "_code") then {
	diag_log "keyboard reset for Testkit";
	keyboard_keys set [DIK_GRAVE,{false}];
	keyboard_keys set [DIK_F2,{
		private "_display";
		disableSerialization;
		systemChat "display";
		_display = findDisplay 2929;
		if (!isNull _display) then {
			_display closeDisplay 2;
		} else {
			call tk_open;
		};
		_handled = true
	}];
	
	if (tk_minimalMode) then {
		tk_open = {};
	} else {
		keyboard_keys set [DIK_DELETE,{call tk_delete}];
		keyboard_keys set [DIK_U,{call tk_unlock; _handled = true}];
	};
	
	keyboard_keys set [DIK_5,{call tk_fastForward; _handled = true}];
	keyboard_keys set [DIK_6,{call tk_fastUp; _handled = true}];
	keyboard_keys set [DIK_F8,{call compile preprocessFileLineNumbers "testkit\test.sqf"; _handled = true}];
	keyboard_keys set [DIK_U,{call tk_unlock; _handled = true}];
	keyboard_keys set [DIK_7,{call tk_getPos; _handled = true}];

	if (tk_editorMode) then {
		call tk_editorKeys;
	};
};

//diag_log format["DZ_KeyDown_EH called with:%1  Return:%2",_this,_handled];

_handled
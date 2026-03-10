extends Node

const SAVE_SCHEMA_VERSION = 2

var key = "creature"

var data = {}

var default = { 
	"0": { 
		"drag": 0, 
		"identification": 930245150, 
		"offset": "Vector2(0, 0)", 
		"parentId": null, 
		"path": "user://defaultAvatar/body.png", 
		"pos": "Vector2(0, 0)", 
		"rotDrag": 0, 
		"showBlink": 0, 
		"showTalk": 0, 
		"type": "sprite", 
		"xAmp": 9, 
		"xFrq": 0.002, 
		"yAmp": 11, 
		"yFrq": 0.004, 
		"zindex": -1 }, 
	"1": { 
		"drag": 1, 
		"identification": 456157398, 
		"offset": "Vector2(0, 0)", 
		"parentId": 930245150, 
		"path": "user://defaultAvatar/head.png", 
		"pos": "Vector2(0, 0)", 
		"rotDrag": 0, 
		"showBlink": 0, 
		"showTalk": 0, 
		"type": "sprite", 
		"xAmp": 0, 
		"xFrq": 0, 
		"yAmp": 0, 
		"yFrq": 0, 
		"zindex": 0 }, 
	"2": { "drag": 4, "identification": 928082759, "offset": "Vector2(0, 0)", "parentId": 456157398, "path": "user://defaultAvatar/hair.png", "pos": "Vector2(0, 0)", "rotDrag": 0, "showBlink": 0, "showTalk": 0, "type": "sprite", "xAmp": 0, "xFrq": 0, "yAmp": 0, "yFrq": 0, "zindex": -2 }, "3": { "drag": 0, "identification": 346749260, "offset": "Vector2(0, 0)", "parentId": 456157398, "path": "user://defaultAvatar/mouth1.png", "pos": "Vector2(0, 0)", "rotDrag": 0, "showBlink": 0, "showTalk": 1, "type": "sprite", "xAmp": 0, "xFrq": 0, "yAmp": 0, "yFrq": 0, "zindex": 0 }, "4": { "drag": 0, "identification": 348929106, "offset": "Vector2(0, 0)", "parentId": 456157398, "path": "user://defaultAvatar/mouth2.png", "pos": "Vector2(0, 0)", "rotDrag": 0, "showBlink": 0, "showTalk": 2, "type": "sprite", "xAmp": 0, "xFrq": 0, "yAmp": 0, "yFrq": 0, "zindex": 0 }, "5": { "drag": 0, "identification": 66364456, "offset": "Vector2(0, 0)", "parentId": 456157398, "path": "user://defaultAvatar/eye1.png", "pos": "Vector2(0, 0)", "rotDrag": 0, "showBlink": 1, "showTalk": 2, "type": "sprite", "xAmp": 0, "xFrq": 0, "yAmp": 0, "yFrq": 0, "zindex": 0 }, "6": { "drag": 0, "identification": 261040117, "offset": "Vector2(0, 0)", "parentId": 456157398, "path": "user://defaultAvatar/eye2.png", "pos": "Vector2(0, 0)", "rotDrag": 0, "showBlink": 1, "showTalk": 1, "type": "sprite", "xAmp": 0, "xFrq": 0, "yAmp": 0, "yFrq": 0, "zindex": 0 }, "7": { "drag": 0, "identification": 291459997, "offset": "Vector2(0, 0)", "parentId": 456157398, "path": "user://defaultAvatar/eye3.png", "pos": "Vector2(0, 0)", "rotDrag": 0, "showBlink": 2, "showTalk": 0, "type": "sprite", "xAmp": 0, "xFrq": 0, "yAmp": 0, "yFrq": 0, "zindex": 0 }, "8": { "drag": 0, "identification": 148065686, "offset": "Vector2(-74, 92)", "parentId": 456157398, "path": "user://defaultAvatar/hat.png", "pos": "Vector2(72, -89)", "rotDrag": -2, "showBlink": 0, "showTalk": 0, "type": "sprite", "xAmp": 0, "xFrq": 0, "yAmp": 0, "yFrq": 0, "zindex": 2 } }


var settings = {
	"newUser":true,
	"lastAvatar":"",
	"volume":0.185,
	"sense":0.25,
	"windowSize":{"x": 1280, "y": 720},
	"useStreamDeck":false,
	"bounce":250,
	"gravity":1000,
	"maxFPS":60,
	"secondsToMicReset":180,
	"backgroundColor":{"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0},
	"filtering":false,
	"costumeKeys":["1","2","3","4","5","6","7","8","9","0"],
	"blinkSpeed":1.0,
	"blinkChance":200,
	"bounceOnCostumeChange":false,
	"lastBrowseDir":"",
	"costumes_count":10,
}

var settingsPath = "user://settings.pngtp"

func _ready():
	var datas = read_save(settingsPath)
	if datas == null:
		return
	else:
		settings = datas.duplicate()
		_migrate_settings(settings)

func _exit_tree():
	write_settings(settingsPath)


func _migrate_settings(settings_dict: Dictionary) -> void:
	# Migrate backgroundColor from var_to_str format to structured format
	if settings_dict.has("backgroundColor"):
		var bg = settings_dict["backgroundColor"]
		if bg is String:
			# Old format: var_to_str(Color)
			var legacy_color = str_to_var(bg)
			if legacy_color is Color:
				settings_dict["backgroundColor"] = color_to_data(legacy_color)
		elif bg is not Dictionary:
			# Fallback to default if not recognized
			settings_dict["backgroundColor"] = color_to_data(Color(0.0, 0.0, 0.0, 0.0))
	
	# Migrate windowSize from var_to_str format to structured format
	if settings_dict.has("windowSize"):
		var size = settings_dict["windowSize"]
		if size is String:
			# Old format: var_to_str(Vector2i)
			var legacy_size = str_to_var(size)
			if legacy_size is Vector2i or legacy_size is Vector2:
				settings_dict["windowSize"] = vector2i_to_data(Vector2i(legacy_size))
		elif size is not Dictionary:
			# Fallback to default if not recognized
			settings_dict["windowSize"] = vector2i_to_data(Vector2i(1280, 720))


func vector2_to_data(value: Vector2) -> Dictionary:
	return {"x": value.x, "y": value.y}


func data_to_vector2(raw, fallback: Vector2 = Vector2.ZERO) -> Vector2:
	if raw is Dictionary and raw.has("x") and raw.has("y"):
		return Vector2(float(raw["x"]), float(raw["y"]))
	return fallback


func vector2i_to_data(value: Vector2i) -> Dictionary:
	return {"x": value.x, "y": value.y}


func data_to_vector2i(raw, fallback: Vector2i = Vector2i.ZERO) -> Vector2i:
	if raw is Dictionary and raw.has("x") and raw.has("y"):
		return Vector2i(int(raw["x"]), int(raw["y"]))
	# Fallback to legacy var_to_str format for backward compatibility
	if raw is String:
		var legacy = str_to_var(raw)
		if legacy is Vector2i or legacy is Vector2:
			return Vector2i(legacy)
	return fallback


func color_to_data(value: Color) -> Dictionary:
	return {"r": value.r, "g": value.g, "b": value.b, "a": value.a}


func data_to_color(raw, fallback: Color = Color(0.0, 0.0, 0.0, 0.0)) -> Color:
	if raw is Dictionary and raw.has("r") and raw.has("g") and raw.has("b") and raw.has("a"):
		return Color(float(raw["r"]), float(raw["g"]), float(raw["b"]), float(raw["a"]))
	# Fallback to legacy var_to_str format for backward compatibility
	if raw is String:
		var legacy = str_to_var(raw)
		if legacy is Color:
			return legacy
	return fallback


func _pack_save_payload(sprites: Dictionary) -> Dictionary:
	return {
		"schema_version": SAVE_SCHEMA_VERSION,
		"sprites": sprites,
	}


func _unpack_save_payload(raw):
	if raw is Dictionary and raw.has("schema_version") and raw.has("sprites") and raw["sprites"] is Dictionary:
		return raw["sprites"]
	return raw


func read_save(path):
	
	if path == "default":
		return DefaultAvatarData.data
	
	
	if OS.has_feature('web'):
		var JSONstr = JavaScriptBridge.eval("window.localStorage.getItem('" + key + "');")
		if (JSONstr):
			return _unpack_save_payload(JSON.parse_string(JSONstr))
		else:
			return null
	else:
		var file = FileAccess.open(path, FileAccess.READ)
		if not file:
			return null
		var newData = JSON.parse_string(file.get_as_text())
		file.close()
		return _unpack_save_payload(newData)

func write_save(path):
	var payload = data
	if payload is Dictionary and !payload.has("schema_version"):
		payload = _pack_save_payload(payload)

	if OS.has_feature('web'):
		JavaScriptBridge.eval("window.localStorage.setItem('" + key + "', '" + JSON.stringify(payload) + "');")
		return true
	else:
		var file = FileAccess.open(path, FileAccess.WRITE)
		if file == null:
			var error = FileAccess.get_open_error()
			push_error("Failed to open file for writing: %s (Error: %s)" % [path, error])
			if Global and Global.main:
				Global.pushUpdate("Error saving file: " + error_string(error))
			return false
		file.store_line(JSON.stringify(payload))
		file.close()
		return true

func write_settings(path):
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		var error = FileAccess.get_open_error()
		push_error("Failed to open settings file for writing: %s (Error: %s)" % [path, error])
		if Global and Global.main:
			Global.pushUpdate("Error saving settings: " + error_string(error))
		return false
	file.store_line(JSON.stringify(settings))
	file.close()
	return true


func clearSave():
	
	if OS.has_feature('web'):
		var JSONstr = JavaScriptBridge.eval("window.localStorage.getItem('" + key + "');")
		if (JSONstr):
			JavaScriptBridge.eval("window.localStorage.removeItem('" + key + "');")
		else:
			return null
	else:
		var file = FileAccess.open("user://" + key + ".save", FileAccess.READ)
		if not file:
			return null
		file.close()
		var dir = DirAccess.open("user://")
		dir.remove(key + ".save")
		data = {}
	
func open_site(url):
	if OS.has_feature('web'):
		JavaScriptBridge.eval("window.open(\"" + url + "\");")
	else:
		print("Could not open site " + url + " without an HTML5 build")

func switchToSite(url):
	if OS.has_feature('web'):
		JavaScriptBridge.eval("window.open(\"" + url + "\", \"_parent\");")
	else:
		print("Could not switch to site " + url + " without an HTML5 build")

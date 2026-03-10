extends SceneTree

func _init():
	var run_scene = str(ProjectSettings.get_setting("application/run/main_scene", ""))
	if run_scene.is_empty():
		push_error("Smoke test failed: application/run/main_scene is not set")
		quit(1)
		return

	if !FileAccess.file_exists(run_scene):
		push_error("Smoke test failed: run scene file does not exist: " + run_scene)
		quit(1)
		return

	if !FileAccess.file_exists("res://autoload/global.gd"):
		push_error("Smoke test failed: missing autoload/global.gd")
		quit(1)
		return

	if !FileAccess.file_exists("res://autoload/saving.gd"):
		push_error("Smoke test failed: missing autoload/saving.gd")
		quit(1)
		return

	print("Smoke test passed: configuration and core files are present")
	quit(0)

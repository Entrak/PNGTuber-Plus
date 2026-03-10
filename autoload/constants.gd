extends Node

## Central configuration constants for PNGTuber-Plus
## This file contains all hardcoded values that were previously scattered across the codebase

# Microphone Settings
const MIC_RESET_TIMEOUT = 180.0  ## Microphone reset interval in seconds before recreating the input
const MIC_RESTART_DELAY = 0.25  ## Delay before restarting microphone after deletion (in seconds)

# Physics & Animation
const DEFAULT_BOUNCE_FORCE = 250  ## Default bounce/spring force for sprite movement
const DEFAULT_GRAVITY = 1000  ## Default gravity value for physics simulation
const PHYSICS_DELTA = 1.0 / 60.0  ## Physics delta time approximation (replaces 0.0166)

# UI & Window
const WINDOW_WIDTH_PX = 1250  ## Total window width in pixels (with comment "1187" in original code)
const MAX_COSTUMES = 10  ## Maximum number of costume hotkey slots (1-10)
const DEFAULT_COSTUME_COUNT = 10  ## Default costume count for new avatars

# Audio Bus Names
const MIC_BUS_NAME = "MIC"  ## Name of the microphone audio bus
const MIC_BUS_INDEX = 1  ## Expected index of MIC bus (verify existence before use)
const SPECTRUM_EFFECT_INDEX = 1  ## Index of spectrum analyzer effect on MIC bus


## Initialize a costume layers array with the specified count (default from settings)
static func make_costume_array(count: int = -1) -> Array:
	if count < 0:
		count = Saving.settings.get("costumes_count", DEFAULT_COSTUME_COUNT)
	var result = []
	for i in range(count):
		result.append(1)
	return result


## Resize costume array to target size (pad with 1s or truncate)
static func resize_costume_array(arr: Array, target_size: int = -1) -> Array:
	if target_size < 0:
		target_size = Saving.settings.get("costumes_count", DEFAULT_COSTUME_COUNT)
	
	if arr.size() == target_size:
		return arr
	elif arr.size() < target_size:
		# Pad with 1s
		var padded = arr.duplicate()
		for i in range(target_size - arr.size()):
			padded.append(1)
		return padded
	else:
		# Truncate
		return Array(arr.slice(0, target_size))

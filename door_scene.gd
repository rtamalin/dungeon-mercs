extends AnimatableBody3D

const SLIDE_RATIO = 0.99
const SLIDE_DURATION = 0.5

@onready var door_visuals = $DoorVisuals

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("door_closed", true)

func interact():
	# do nothing if already open
	if not has_meta("door_closed") or not get_meta("door_closed"):
		return

	print("Door is opening...")
	Game.log_msg("After pushing the button, the door slides soundlessly into the ceiling.")
	
	# Stop any existing tween animationions
	if has_meta("active_tween") and get_meta("active_tween").is_valid():
		get_meta("active_tween").stop()

	# Determine target position for end of animation and how long needed
	# to complete the animation
	var door_height = door_visuals.mesh.size.y
	var end_y = (door_height * SLIDE_RATIO) # 1 because centre of door starts at 1
	var slide_time = ((end_y - position.y) / door_height) * SLIDE_DURATION
	var tween = create_tween()
	tween.tween_property(self, "position:y", end_y, slide_time)
	
	# record the active tween
	set_meta("active_tween", tween)

	# setup callback when animation is finished
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished():
	print("Door is now open.")
	set_meta("door_closed", false)
	collision_layer = 0
	#  visible = false

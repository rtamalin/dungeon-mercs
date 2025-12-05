extends Node3D

@onready var front_ray = $FrontRayCast3D
@onready var rear_ray = $RearRayCast3D
@onready var left_ray = $LeftRayCast3D
@onready var right_ray = $RightRayCast3D

var is_acting: bool = false

const GRID_SIZE = 2.0 # Each step is 2 metres
const MOVEMENT_DELAY = 0.3 # Time taken to complete a move


func _action_lock() -> void: is_acting = true


func _action_unlock() -> void:
	is_acting = false
	Game.advance_time()


func _actiion_unlock_no_time() -> void: is_acting = false


func _action_is_locked() -> bool: return is_acting


func _tween_turner(delta: int, duration: float) -> void:
	var target_rotation = rotation_degrees
	target_rotation.y += delta

	# use the tween to smoothly turn the sepcified amount
	_action_tweener("rotation_degrees", target_rotation, duration, _actiion_unlock_no_time)


func _tween_mover(ray: RayCast3D, delta: Vector3, duration: float) -> void:
	if ray.is_colliding():
		return
	
	_action_tweener("position", position + delta, duration, _action_unlock)
	

func _action_tweener(attr: String, val: Variant, duration: float, unlock: Callable) -> void:
	if _action_is_locked():
		return
	_action_lock()
	var tween = create_tween()
	
	tween.tween_property(self, attr, val, duration)
	tween.finished.connect(unlock)


func _unhandled_input(event: InputEvent) -> void:

	# move_forward
	if event.is_action_pressed("move_forward"):
		# if nothing is blocking, move forward in the direction the player is facing
		_tween_mover(front_ray, - (transform.basis.z * GRID_SIZE), MOVEMENT_DELAY)

	# move_left
	elif event.is_action_pressed("move_left"):
		# if nothing is blocking, sidestep left relative to the direction the player is facing,
		_tween_mover(left_ray, - (transform.basis.x * GRID_SIZE), MOVEMENT_DELAY)

	# move_right
	elif event.is_action_pressed("move_right"):
		# if nothing is blocking, sidestep right relative to the direction the player is facing,
		_tween_mover(right_ray, transform.basis.x * GRID_SIZE, MOVEMENT_DELAY)

	# move_back
	elif event.is_action_pressed("move_back"):
		# if nothing is blocking, move backward away from the direction the player is facing
		_tween_mover(rear_ray, transform.basis.z * GRID_SIZE, MOVEMENT_DELAY)

	# turn_left
	elif event.is_action_pressed("turn_left"):
		# turn 90 degrees to the left
		_tween_turner(90, MOVEMENT_DELAY)

	# turn_right
	elif event.is_action_pressed("turn_right"):
		# turn 90 degrees to the right
		_tween_turner(-90, MOVEMENT_DELAY)

	# turn_around
	elif event.is_action_pressed("turn_around"):
		# turn around (180 degrees)
		_tween_turner(180, MOVEMENT_DELAY * 1.5)

	# interact
	elif event.is_action_pressed("interact"):
		# trigger interaction handling
		check_interaction()

func check_interaction() -> void:
	# check if a front collision is hitting something that is interactible
	if front_ray.is_colliding():
		var collider = front_ray.get_collider()
		if collider.has_method("interact"):
			collider.interact()
		else:
			print("You can't interact with ", collider.name)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

extends AnimatableBody3D

@export var contents: Array[ItemData]

func interact() -> void:
	if not contents:
		Game.log_msg("The chest is empty.")
		return

	# TODO - play a sound, animate lid opening

	for item in contents:
		Game.add_shared_inventory(item)
		
	# remove the chest now that it is empty
	queue_free()

	Game.advance_time()

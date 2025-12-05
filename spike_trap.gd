extends Area3D

@export var damage: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect the signal via code
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		trigger_trap()

func _on_area_entered(area: Area3D) -> void:
	# Check if this is the player's hitbox
	if area.name == "HitBox":
		trigger_trap()
		
func trigger_trap() -> void:
	Game.log_msg("[color=red]TRAP! You stepped on a spike trap![/color]")
	print("TRAP! You hit a spike trap.")
	
	if Game.party.size() > 0:
		var victim = Game.party[0]
		victim.cur_health -= damage
		
		if victim.cur_health < 0:
			victim.cur_health = 0
			
	Game.notify_time()

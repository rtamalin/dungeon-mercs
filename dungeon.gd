extends Node3D

@export var width: int = 20
@export var height: int = 20
@export var party_scene: PackedScene
@export var door_scene: PackedScene
@export var trap_scene: PackedScene

@onready var grid_map: GridMap = $FloorPlan
@onready var cell_size = grid_map.cell_size.y
@onready var ceiling_height = Vector3i(0, 1, 0)
@onready var viewpoint_height = Vector3(0.0, 1, 0.0)
@onready var entrance: Vector2i = Vector2i(0, 0)

# Map codes
enum {TILE_WALL, TILE_FLOOR, TILE_CEILING}

# Directions
const DIRECTIONS = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lib = grid_map.mesh_library
	#print("[Tile Audit Start]")
	#print("Tile ID ", TILE_WALL, " (Wall) Transform: ", lib.get_item_mesh_transform(TILE_WALL).origin)
	#print("Tile ID ", TILE_FLOOR, " (Floor) Transform: ", lib.get_item_mesh_transform(TILE_FLOOR).origin)
	#print("Tile ID ", TILE_CEILING, " (Ceiling) Transform: ", lib.get_item_mesh_transform(TILE_CEILING).origin)
	#print("Tile Cell Size: ", grid_map.cell_size)
	#print("[Tile Audit End]")

	generate_map()
	spawn_props()
	spawn_player()

func map_loc_to_grid(loc: Vector2i) -> Vector3:
	return grid_map.map_to_local(Vector3i(loc.x, 0, loc.y))

func spawn_player() -> void:
	if not party_scene:
		push_error("Player Scene not assigned!")
		return

	var party: Node = party_scene.instantiate()
	add_child(party)
	
	# convert grid coordinates to World coordinates
	var party_pos = map_loc_to_grid(entrance) + viewpoint_height

	#player.position = Vector3(player_pos.x, grid_map.cell_size.y/2.0, player_pos.y)
	party.position = party_pos
	party.rotation.y = deg_to_rad(180)
	print("Party position: ", party.position, ", rotation: ", party.rotation)

func spawn_props() -> void:
	spawn_test_door(entrance + Vector2i.DOWN)
	spawn_test_trap(entrance + (Vector2i.DOWN * 2))
	spawn_test_door(entrance + (Vector2i.DOWN * 3))

func spawn_test_door(door_loc: Vector2i) -> void:
	if not door_scene:
		return

	print("Spawning door at ", door_loc)
	make_corridor(door_loc)

	var door = door_scene.instantiate()
	add_child(door)
	
	door.position = map_loc_to_grid(door_loc)
	# door.position += Vector3(0, 0, 0)
	door.position.y += 1.0
	print("Door grid: ", door_loc, ", position: ", door.position, ", global: ", door.global_position)

func spawn_test_trap(trap_loc: Vector2i) -> void:
	if not trap_scene:
		return

	print("Spawning trap at ", trap_loc)
	make_corridor(trap_loc)

	var trap = trap_scene.instantiate()
	add_child(trap)
	
	trap.position = map_loc_to_grid(trap_loc)
	print("Trap grid: ", trap_loc, ", position: ", trap.position, ", global: ", trap.global_position)

func make_wall(loc: Vector2i) -> void:
	var pos = Vector3i(loc.x, 0, loc.y)
	grid_map.set_cell_item(pos, TILE_WALL)


func make_corridor(loc: Vector2i) -> void:
	var pos = Vector3i(loc.x, 0, loc.y)
	grid_map.set_cell_item(pos, TILE_FLOOR)
	grid_map.set_cell_item(pos + ceiling_height, TILE_CEILING)

func out_of_bounds(loc: Vector2i) -> bool:
	return (loc.x < 0) or (loc.y < 0) or (loc.x > width - 1) or (loc.y > height - 1)

func generate_map() -> void:
	grid_map.clear()
	
	# track visited locations
	var visited = {}
	
	# fill grid with walls
	for w in range(-1, width + 1):
		for h in range(-1, height + 1):
			make_wall(Vector2i(w, h))

	# use recursive backtracker to carve out walls, starting
	# at specified entrance.
	carve_passage(entrance, visited)

func carve_passage(cur_loc: Vector2i, visited: Dictionary) -> void:
	# Mark current location as visited
	visited[cur_loc] = true
	
	# Carve out this passage
	make_corridor(cur_loc)
	
	# shuffle a random directional order
	var directions = DIRECTIONS.duplicate()
	directions.shuffle()

	for dir in directions:
		# since both a wall and a corridor each take up 1 location we
		# need to check 2 locations in the targetted direction to see
		# if a corridor exists
		var next_loc = cur_loc + (dir * 2)
		
		# skip if next pos is outside the boundary
		if out_of_bounds(next_loc):
			continue

		# skip if already visited
		if visited.has(next_loc):
			continue

		# connect the current location to the target location
		make_corridor(cur_loc + dir)
		
		# recursively call for the target location
		carve_passage(next_loc, visited)

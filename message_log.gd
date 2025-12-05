extends Panel

@onready var messages: RichTextLabel = $Messages

const MAX_LINES: int = 50

var log_lines: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.message_log = self
	add_message("[b]Welcome to the Dungeon of Doom.[/b]")

func add_message(text: String) -> void:
	log_lines.append(text)
	
	if log_lines.size() > MAX_LINES:
		log_lines.pop_front()
	
	messages.clear()
	messages.append_text("\n".join(log_lines))

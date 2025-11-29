extends Node

@export var enemy_scene: PackedScene
@export var enemy_spawn_timer: Timer
@export var enemy_spawn_location: PathFollow2D
@export var player: Player

var dictionary: Dictionary = {}
var typed_word: String = ""


func _ready() -> void:
	# Load words from text file
	var file = FileAccess.open("res://Assets/words_alpha.txt", FileAccess.READ)
	var content := file.get_as_text().replace("\r", "").split("\n", false)
	for word in content:
		dictionary[word] = 1

	enemy_spawn_timer.wait_time = 1.0
	enemy_spawn_timer.timeout.connect(spawn_enemy)
	enemy_spawn_timer.start()

func _process(_delta):
	player.input_text.text = typed_word
	if Input.is_action_just_pressed("submit_word"):
		var is_word_valid = typed_word in dictionary 
		if is_word_valid:
			print("Word is valid!")
		else: 
			print("Word is invalid.")
		typed_word = ""

func spawn_enemy():
	var enemy: Enemy = enemy_scene.instantiate()

	enemy_spawn_location.progress_ratio = randf()

	enemy.position = enemy_spawn_location.position 
	enemy.player = player
	add_child(enemy)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.is_pressed():
		var key_label = event.as_text_physical_keycode()
		if key_label.length() == 1: 
			typed_word += key_label.to_lower()
		print(typed_word)

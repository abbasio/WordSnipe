class_name Enemy
extends CharacterBody2D

@export var sprite: AnimatedSprite2D
@export var player: Area2D

var speed = 15.0
var current_letter: Alphabet.letters
var letters = Alphabet.letters.values()
var letter_label: String
var active: bool = false

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	var weights = PackedFloat32Array([2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1])
	current_letter = letters[rng.rand_weighted(weights)] as Alphabet.letters
	sprite.frame = current_letter
	letter_label = Alphabet.map_enum_to_letter[current_letter]

func _physics_process(_delta: float) -> void:
	if active:
		sprite.modulate = Color(0, 0, 1, 1)
	else:
		sprite.modulate = Color(0, 0, 1, 0.25)
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()

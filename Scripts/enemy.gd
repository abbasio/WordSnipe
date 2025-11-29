class_name Enemy
extends CharacterBody2D

@export var sprite: AnimatedSprite2D
@export var player: Area2D

var speed = 30.0
var current_letter: Alphabet.letters

func _ready() -> void:
	current_letter = randi_range(0, 25) as Alphabet.letters
	sprite.frame = current_letter

func _physics_process(_delta: float) -> void:
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()

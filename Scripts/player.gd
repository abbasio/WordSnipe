class_name Player
extends Area2D

@export var input_text: RichTextLabel

func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
extends Node2D

@onready var gem_collected_sfx: AudioStreamPlayer2D = %GemCollectedSFX
@onready var sprite_2d: Sprite2D = %Sprite2D

@export var rotation_speed: float = 2

func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_collected()


func get_collected():
	gem_collected_sfx.play()
	sprite_2d.visible = false
	await get_tree().create_timer(0.4).timeout
	queue_free()

extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		star_collected()


func star_collected():
	EventBus.star_collected.emit()
	animation_player.play("star_collected_animation")

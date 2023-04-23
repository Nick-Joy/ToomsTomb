extends CharacterBody2D

@onready var swipe_screen_button: TouchScreenButton = %SwipeScreenButton

@onready var north_cast_2d: RayCast2D = %NorthCast2D
@onready var east_cast_2d: RayCast2D = %EastCast2D
@onready var south_cast_2d: RayCast2D = %SouthCast2D
@onready var west_cast_2d: RayCast2D = %WestCast2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var movement_audio_2d: AudioStreamPlayer2D = %MovementAudio2D


@export var speed: float = 1000
var gravity_direction: Vector2 = Vector2(Vector2.ZERO)
var can_move: bool

func _ready():
	can_move = true

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		if can_move and velocity == Vector2.ZERO:
			match swipe_screen_button.get_swipe_direction(event.relative, 4):
				Vector2.UP:
					set_gravity_direction(Vector2.UP)
				Vector2.DOWN:
					set_gravity_direction(Vector2.DOWN)
				Vector2.LEFT:
					set_gravity_direction(Vector2.LEFT, true)
				Vector2.RIGHT:
					set_gravity_direction(Vector2.RIGHT, false)

func _process(_delta: float) -> void:
	if north_cast_2d.is_colliding():
		can_move = true
	elif east_cast_2d.is_colliding():
		can_move = true
	elif south_cast_2d.is_colliding():
		can_move = true
	elif west_cast_2d.is_colliding():
		can_move = true
	else:
		can_move = false
	
	velocity = gravity_direction * speed
	move_and_slide()


func set_gravity_direction(direction: Vector2, sprite_flip = null):
	gravity_direction = direction
	movement_audio_2d.play()
	if sprite_flip != null:
		sprite_2d.flip_h = sprite_flip

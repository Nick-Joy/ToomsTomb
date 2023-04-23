extends CharacterBody2D
class_name Player

@onready var swipe_screen_button: TouchScreenButton = %SwipeScreenButton

@onready var north_cast_2d: RayCast2D = %NorthCast2D
@onready var east_cast_2d: RayCast2D = %EastCast2D
@onready var south_cast_2d: RayCast2D = %SouthCast2D
@onready var west_cast_2d: RayCast2D = %WestCast2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var movement_audio_2d: AudioStreamPlayer2D = %MovementAudio2D
@onready var movement_trail_vfx: GPUParticles2D = %MovementTrailVFX


@export var move_speed: float = 800
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
					# movement_trail_vfx.emitting = true


func _process(_delta: float) -> void:
	# PC Controls (Debug)
	if Input.is_action_pressed("up"):
		set_gravity_direction(Vector2.UP)
	if Input.is_action_pressed("down"):
		set_gravity_direction(Vector2.DOWN)
	if Input.is_action_pressed("left"):
		set_gravity_direction(Vector2.LEFT, true)
	if Input.is_action_pressed("right"):
		set_gravity_direction(Vector2.RIGHT, false)
	
	check_raycast_collision()                   # Makes sure you're touching a wall before moving
	velocity = gravity_direction * move_speed   # Assigns normalized vectors from _input to velocity
	move_and_slide()


func set_gravity_direction(direction: Vector2, sprite_flip = null):
	gravity_direction = direction
	movement_audio_2d.play()
	if sprite_flip != null:
		sprite_2d.flip_h = sprite_flip


func check_raycast_collision():
	can_move =  north_cast_2d.is_colliding()||\
				east_cast_2d.is_colliding() ||\
				south_cast_2d.is_colliding()||\
				west_cast_2d.is_colliding() ||\
				false

#	if north_cast_2d.is_colliding():
#		can_move = true
#	elif east_cast_2d.is_colliding():
#		can_move = true
#	elif south_cast_2d.is_colliding():
#		can_move = true
#	elif west_cast_2d.is_colliding():
#		can_move = true
#	else: 
#		can_move = false

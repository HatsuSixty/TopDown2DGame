extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

const MAX_VEL = 120
const ACELERATION = 250
const FRICTION = 400

onready var player_animation = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _physics_process(delta):
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		animation_tree.set("parameters/walking/blend_position", direction)
		animation_tree.set("parameters/idle/blend_position", direction)
		
		velocity = velocity.move_toward(direction * MAX_VEL, ACELERATION * delta)
		
		animation_state.travel("walking")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		animation_state.travel("idle")
	
	velocity = move_and_slide(velocity)

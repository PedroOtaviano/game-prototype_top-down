extends Node

var stateName : String = "Idle State"
@onready var animated_sprite_2d = $"../AnimatedSprite2D"

func enter():
	get_parent().velocity = Vector2.ZERO
	
	var dir : Vector2 = get_parent().last_direction
	var anim : String = ""
	
	if dir.x > 0:
		anim = "idle_right"
	elif dir.x < 0:
		anim = "idle_left"
	elif dir.y < 0:
		anim = "idle_up"
	else:
		anim = "idle_down"
		
	animated_sprite_2d.play(anim)

func _physics_process(delta):
	var input_vector: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	
	if input_vector != Vector2.ZERO:
		exit("MoveState")
	elif Input.is_action_just_pressed("Attack") and get_parent().current_state.stateName != "Attack State":
		exit("AttackState")

func exit(NewState: String):

	if NewState == name:
		return

	get_parent().switch_state(NewState)

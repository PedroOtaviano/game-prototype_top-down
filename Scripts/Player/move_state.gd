extends Node

var stateName : String = "Move State"
@onready var animated_sprite_2d = $"../AnimatedSprite2D"

func enter():
	pass

func _physics_process(delta):
	var input_vector : Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	
	if input_vector != Vector2.ZERO:
		get_parent().last_direction = input_vector
	
	if Input.is_action_just_pressed("Attack") and get_parent().current_state.stateName != "Attack State":
		exit("AttackState")
	elif input_vector == Vector2.ZERO:
		exit("IdleState")
	else:
		if Input.is_action_pressed("Run"):
			get_parent().velocity = input_vector * get_parent().speed*1.6
		else:
			get_parent().velocity = input_vector * get_parent().speed
		# Toca animação de movimento conforme direção
		var anim = ""
		if input_vector.x > 0:
			anim = "run_right"
		elif input_vector.x < 0:
			anim = "run_left"
		elif input_vector.y < 0:
			anim = "run_up"
		else:
			anim = "run_down"
			
		animated_sprite_2d.play(anim)

func exit(NewState: String):
	if NewState == name:
		return
	
	get_parent().switch_state(NewState)

extends Node

var stateName : String = "Attack State"
var attack_duration := 0.8 
var timer := 0.0

@onready var animated_sprite_2d = $"../AnimatedSprite2D"

@onready var hurtbox_down = $"../Hurtbox/Hurtbox_down"
@onready var hurtbox_up = $"../Hurtbox/Hurtbox_up"
@onready var hurtbox_right = $"../Hurtbox/Hurtbox_right"
@onready var hurtbox_left = $"../Hurtbox/Hurtbox_left"

func enter():
	timer = attack_duration
	get_parent().velocity = Vector2.ZERO
	var dir = get_parent().last_direction
	var anim = ""
	if dir.x > 0:
		anim = "attack_right"
		animated_sprite_2d.position.x = 8
		hurtbox_right.disabled = false
	elif dir.x < 0:
		anim = "attack_left"
		animated_sprite_2d.position.x = -7
		hurtbox_left.disabled = false
	elif dir.y < 0:
		anim = "attack_up"
		animated_sprite_2d.position.y = -8
		hurtbox_up.disabled = false
	else:
		anim = "attack_down"
		animated_sprite_2d.position.y = 7
		hurtbox_down.disabled = false
	animated_sprite_2d.play(anim)

func _physics_process(delta):
	print(timer)
	timer -= delta
	if timer <= 0.0:
		var input_vector: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
		
		if input_vector != Vector2.ZERO:
			exit("MoveState")
		else:
			exit("IdleState")
			
func exit(NewState: String):
	animated_sprite_2d.position = Vector2.ZERO
	hurtbox_right.disabled = true
	hurtbox_left.disabled = true
	hurtbox_up.disabled = true
	hurtbox_down.disabled = true
	
	if NewState == name:
		return
	get_parent().switch_state(NewState)

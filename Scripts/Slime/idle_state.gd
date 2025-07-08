extends Node
@onready var animated_sprite_2d = $"../AnimatedSprite2D"
@onready var slime = $".."
signal player_detected(player_position: Vector2)

func enter():
	slime.velocity = Vector2.ZERO
	animated_sprite_2d.play("idle")
	
func _physics_process(delta):
	pass
	
func exit(NewState: String):
	if NewState == name:
		return
	slime.switch_state(NewState)

func _on_aggrobox_body_entered(body):
	if body is Player:
		emit_signal("player_detected", body.global_position)
		exit("FollowState")

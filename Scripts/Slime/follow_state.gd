extends Node
@onready var animated_sprite_2d = $"../AnimatedSprite2D"
@onready var slime = $".."
var direction : Vector2 = Vector2.ZERO

var timer := 5

func _ready():
	var idle_state = slime.get_node("IdleState")
	idle_state.connect("player_detected", Callable(self, "_on_player_detected"))

func enter():
	slime.velocity = Vector2.ZERO
	animated_sprite_2d.play("move")
	
func _physics_process(delta):
	timer -= delta
	if timer <= 0:
		exit("IdleState")
	
func exit(NewState: String):
	slime.velocity = Vector2.ZERO
	if NewState == name:
		return
	slime.switch_state(NewState)

func _on_aggrobox_body_exited(body):
	exit("IdleState")

func _on_player_detected(player_pos: Vector2):
	direction = (player_pos - slime.global_position).normalized()
	slime.velocity = direction * slime.speed

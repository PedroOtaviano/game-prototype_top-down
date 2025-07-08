extends CharacterBody2D
class_name Player

@export var speed : int = 70

var current_state : Node = null
var last_direction : Vector2 = Vector2.DOWN

@onready var label = $Label
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	switch_state("IdleState")

func switch_state(state_name: String):
	if current_state:
		current_state.set_process(false)
		current_state.set_physics_process(false)

	current_state = get_node(state_name)
	current_state.set_process(true)
	current_state.set_physics_process(true)
	current_state.enter()

func _physics_process(delta):
	if current_state and current_state.has_method("_physics_process"):
		current_state._physics_process(delta)
	label.text = current_state.stateName #para debug
	move_and_slide()

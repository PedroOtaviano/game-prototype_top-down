extends CharacterBody2D

@export var speed : int = 30

@onready var label = $Label
@onready var animated_sprite_2d = $AnimatedSprite2D

var current_state : Node = null

func switch_state(state_name: String):
	if current_state:
		current_state.set_process(false)
		current_state.set_physics_process(false)

	current_state = get_node(state_name)
	current_state.set_process(true)
	current_state.set_physics_process(true)
	current_state.enter()

func _ready():
	switch_state("IdleState")
	
func _physics_process(delta):
	pass

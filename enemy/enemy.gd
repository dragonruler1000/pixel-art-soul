extends RigidBody2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
var velocity = Vector2.ZERO
var player: Node2D = null
var path_update_timer := 0.0
var path_update_interval := 0.5 # Update path every half second

func _ready():
	# Optional tuning
	nav_agent.path_desired_distance = 8.0
	nav_agent.target_desired_distance = 8.0


func set_target_node(target: Node2D):
	player = target

func _physics_process(delta):
	# Update path every few frames
	if player != null:
		path_update_timer -= delta
		if path_update_timer <= 0.0:
			nav_agent.target_position = player.global_position
			path_update_timer = path_update_interval

	if nav_agent.is_navigation_finished():
		linear_velocity = Vector2.ZERO
		return

	var next_path_point = nav_agent.get_next_path_position()
	var direction = (next_path_point - global_position).normalized()
	var speed = 100.0
	linear_velocity = direction * speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
func game_over():
	queue_free()

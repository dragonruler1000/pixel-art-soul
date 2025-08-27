extends Node

@export var enemy_scene: PackedScene
var score
var enemies_spawned
@onready var spawn_marker = $EnemySpawn
@onready var enemy = $Enemy

func _ready():
	new_game()
	enemy.enemy_killed.connect(_on_enemy_enemy_killed)
	


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	#var enemy = enemy_scene.instantiate()
	enemy.game_over()
	
func new_game():
	score=0
	enemies_spawned=1
	print(enemies_spawned)
	$Player.start($StartPosition.position)
	$StartTimer.start() # Replace with function body.


func _on_mob_timer_timeout() -> void:
	if get_tree().get_nodes_in_group("enemy").size() <= 0:
		var enemy: Node = enemy_scene.instantiate()
		if !is_instance_valid( spawn_marker ): print("No valid spawn marker!")
		enemy.global_position = spawn_marker.global_position
		add_child(enemy)
		enemies_spawned += 1
		print(enemies_spawned)

		# Set player as the target for pathfinding
		var player = $Player
		enemy.set_target_node(player)
	else:
		remove_child(enemy)
		$MobTimer.start()

	


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()


func _on_enemy_enemy_killed():
	# remove_child(enemy)
	enemies_spawned -= 1
	print(enemies_spawned)
	$MobTimer.start()

extends Node

@export var enemy_scene: PackedScene
var score

func _ready():
	new_game()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
func new_game():
	score=0
	$Player.start($StartPosition.position)
	$StartTimer.start() # Replace with function body.


func _on_mob_timer_timeout():
	var enemy = enemy_scene.instantiate()

	# Spawn position
	var spawn_marker = $EnemySpawn
	enemy.global_position = spawn_marker.global_position
	
	add_child(enemy)

	# Set player as the target for pathfinding
	var player = $Player
	enemy.set_target_node(player)

	


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()

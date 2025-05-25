extends Area2D

signal hit
signal killed

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
@export var damage: float = 10
var health: float = PlayerVariables.max_health
var velocity = Vector2.ZERO # The player's movement vector.
#@onready var healthbar = $""

func _ready():
	screen_size = get_viewport_rect().size
	#hide()


func _process(delta):
	velocity=Vector2(0,0)
	if Input.is_action_pressed(&"move_right"):
		velocity.x += 1
	if Input.is_action_pressed(&"move_left"):
		velocity.x -= 1
	if Input.is_action_pressed(&"move_down"):
		velocity.y += 1
	if Input.is_action_pressed(&"move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func start(pos):
	position = pos
	rotation = 0
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(_body):
	print("collided")
	PlayerVariables.current_health -= damage
	
	hit.emit()
	print("Health = ", PlayerVariables.current_health)
	# Must be deferred as we can't change physics properties on a physics callback.
	#$CollisionShape2D.set_deferred(&"disabled", true)
	if PlayerVariables.current_health <= 0.0:
		hide()
		killed.emit()
		get_tree().call_group("player", "queue_free")
		
# TODO: Get player knockback working.
#func apply_knockback(enemy_position: Vector2, knockback_strength: float) -> void:
	#var knockback_direction = (global_position - enemy_position).normalized()
	#velocity = knockback_direction * knockback_strength

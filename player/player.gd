extends Area2D

signal hit
signal killed

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
@export var damage: float = 10
var health: float = PlayerVariables.max_health
var velocity = Vector2.ZERO # The player's movement vector.
var knockback_velocity: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var knockback_duration: float = 0.2 #seconds
var is_invincible: bool = false
var invincibility_duration: float = 2.0 #seconds
var invincibility_timer: float =0.0
#@onready var healthbar = $""
var equipped_weapon : Node = null

func _ready():
	screen_size = get_viewport_rect().size
	#hide()


func _process(delta):
	if Input.is_action_just_pressed("attack") and equipped_weapon:
		equipped_weapon.attack()
	# Invincibility countdown
	if is_invincible:
		invincibility_timer -= delta
		if invincibility_timer <=0:
			is_invincible = false
			$Sprite2D.material.set_shader_parameter("is_invincible", false)
	# Movement and kncokback code
	if knockback_timer > 0:
		position += knockback_velocity * delta
		knockback_timer -= delta
	else:
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


func _on_body_entered(body):
	if body.has_method("get_global_position"):
		apply_knockback(body.global_position, 1000.0) # Can change the value later
	if is_invincible:
		return
	else:
		print("collided")
		PlayerVariables.current_health -= damage
		hit.emit()
		print("Health = ", PlayerVariables.current_health)
		
		is_invincible = true
		invincibility_timer = invincibility_duration
		$Sprite2D.material.set_shader_parameter("is_invincible", true)
		
		if PlayerVariables.current_health <= 0.0:
			hide()
			killed.emit()
			get_tree().call_group("player", "queue_free")
			
# TODO: Get player knockback working.
func apply_knockback(enemy_position: Vector2, knockback_strenght: float):
	var direction = (global_position - enemy_position).normalized()
	knockback_velocity = direction * knockback_strenght
	knockback_timer = knockback_duration
	
func equip_weapon(weapon: Node):
	if equipped_weapon:
		equipped_weapon.queue_free()
	equipped_weapon = weapon
	add_child(equipped_weapon)

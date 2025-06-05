extends Area2D
@export var damage: float = 10.0
@export var stamina_cost: float = 10.0
@export var attack_speed: float = 1.0
@export var weapon_type: String = "sword"
@onready var hitbox: CollisionShape2D = $CollisionShape2D

func _process(delta):
	hitbox.disabled = true
	if Input.action_press("attack")
		enable_hitbox()

func enable_hitbox():
	$CollisionShape2D.disabled = false

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)

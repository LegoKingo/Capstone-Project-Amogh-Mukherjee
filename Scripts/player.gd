extends CharacterBody2D
class_name Player

@onready var utils = get_node("/root/Utilities")
@export var max_speed = 10
@export var rotation_speed = 3.5
@export var velocity_damping_factor = .5
@export var linear_velocity = 200



signal on_player_died

@onready var invincibility_timer = $InvincibilityTimer
@onready var blinking_timer = $BlinkingTimer
@onready var sprite = $Sprite2D
@onready var explosion_particles = $PlayerExplosionParticles
@onready var boost_timer = $BoostTimer
@onready var boost_cooldown = $BoostCooldown
@onready var dodge_timer = $DodgeTimer


@onready var invincible_sound: AudioStreamPlayer2D = $PlayerInvincible
@onready var boost_sound: AudioStreamPlayer2D = $PlayerBoost
@onready var bomb_sound: AudioStreamPlayer2D = $PlayerBomb

var is_boosting: bool
var can_boost: bool = true

var is_invincible: bool
var input_vector: Vector2
var rotation_direction: int

func _ready() -> void:
	blinking_timer.timeout.connect(toggle_visibility)
	invincibility_timer.timeout.connect(stop_invincibility)
	boost_timer.timeout.connect(boost_cooldown.start)
	boost_timer.timeout.connect(utils.boosted.emit)
	boost_cooldown.timeout.connect(end_boost)
	dodge_timer.timeout.connect(stop_invincibility)

func _process(_delta):
	input_vector.x = Input.get_action_strength("rotate_left") - Input.get_action_strength("rotate_right")
	input_vector.y = Input.get_action_strength("thrust") - Input.get_action_strength("backwards_thrust")
	
	if Input.is_action_pressed("rotate_left"):
		rotation_direction = -1
	elif Input.is_action_pressed("rotate_right"):
		rotation_direction = 1
	else:
		rotation_direction = 0
	
	if Input.is_action_just_pressed("boost") && utils.store_dictionary["Boost"]:
		if can_boost:
			boost()
	
	if Input.is_action_just_pressed("bomb") && utils.store_dictionary["Bomb"]:
		if utils.bombCounter == 3:
			return
		utils.bombCounter += 1
		bomb_sound.play()
		utils.bomb_exploded.emit(false)
		
	
	if Input.is_action_just_pressed("dodge") && utils.store_dictionary["Dodge"]:
		dodge()
		utils.dodge_executed.emit()
	


func _physics_process(delta: float) -> void:
	rotation += (rotation_direction * rotation_speed * delta)
	if(input_vector.y > 0):
		accelerate_forward(delta)
	elif (input_vector.y < 0):
		accelerate_backward(delta)
	elif input_vector.y == 0 && velocity != Vector2.ZERO:
		decelerate(delta)
	move_and_collide(velocity * delta)

func accelerate_forward(delta: float):
	velocity += -(input_vector * linear_velocity * delta).rotated(rotation)
	velocity.limit_length(max_speed)

func accelerate_backward(delta: float):
	if !utils.store_dictionary["Move Backwards"]:
		return
	velocity += -(input_vector * linear_velocity * delta).rotated(rotation)
	velocity.limit_length(max_speed)

func decelerate(delta: float):
	velocity = lerp(velocity, Vector2.ZERO, velocity_damping_factor * delta)
	
	if velocity.y >= -0.1 && velocity.y <= 0.1:
		velocity.y = 0

func start_invincibility():
	is_invincible = true
	blinking_timer.start()
	invincibility_timer.start()

func toggle_visibility():
	invincible_sound.play()
	if sprite.visible:
		sprite.visible = false
	else:
		sprite.visible = true

func stop_invincibility():
	is_invincible = false
	sprite.visible = true
	blinking_timer.stop()
	invincibility_timer.stop()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_invincible:
		return
	
	if area is Bullet && !is_boosting:
		utils.play_explosion.emit()
		on_player_died.emit()
		queue_free()
		area.queue_free()
		explosion_particles.emitting = true
		explosion_particles.reparent(get_tree().root)

func boost():
	utils.boostCounter +=1
	boost_sound.play()
	velocity *= 5
	is_boosting = true
	can_boost = false
	boost_timer.start()

func end_boost():
	is_boosting = false
	can_boost = true

func dodge():
	utils.dodgeCounter += 1
	is_invincible = true
	blinking_timer.start()
	dodge_timer.start()

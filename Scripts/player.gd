extends CharacterBody2D
class_name Player

@export var max_speed = 10
@export var rotation_speed = 3.5
@export var velocity_damping_factor = .5
@export var linear_velocity = 200

var reverse_thrust_unlock = false

var input_vector: Vector2

var rotation_direction: int

func _process(delta):
	input_vector.x = Input.get_action_strength("rotate_left") - Input.get_action_strength("rotate_right")
	input_vector.y = Input.get_action_strength("thrust") - Input.get_action_strength("backwards_thrust")
	
	if Input.is_action_pressed("rotate_left"):
		rotation_direction = -1
	elif Input.is_action_pressed("rotate_right"):
		rotation_direction = 1
	else:
		rotation_direction = 0
	
	if Input.is_action_just_pressed("boost"):
		reverse_thrust_unlock = !reverse_thrust_unlock
		print(reverse_thrust_unlock)
	

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
	if reverse_thrust_unlock == false:
		return
	velocity += -(input_vector * linear_velocity * delta).rotated(rotation)
	velocity.limit_length(max_speed)

func decelerate(delta: float):
	velocity = lerp(velocity, Vector2.ZERO, velocity_damping_factor * delta)
	
	if velocity.y >= -0.1 && velocity.y <= 0.1:
		velocity.y = 0


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("You've been hit!")
	print("Is This Thing On?")

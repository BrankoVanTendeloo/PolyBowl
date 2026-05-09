extends Node3D

@onready var ball_body = $Ball
@onready var pins := {}

var ball_finished: bool = false

func _ready() -> void:
	for pin: Node3D in $Pins.get_children():
		pins[pin] = {"standing": true, "in_play": true}
		pins[pin]["position"] = pin.position
		pins[pin]["rotation"] = pin.rotation
	reset_pins()

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		reset_pins()
		var temp_random = randf_range(-3, 3)
		roll_ball(randf_range(8,12), temp_random, 1000, temp_random*-randf_range(50,150))

## Resets all pins to their original state
func reset_pins() -> void:
	for pin in pins.keys():
		pins[pin]["standing"] = true
		pins[pin]["in_play"] = true
		reset_pin_position(pin)
		pin.freeze = true
	for pin in pins.keys():
		pin.freeze = false

## Resets a pin's position and velocity
func reset_pin_position(pin: RigidBody3D) -> void:
	pin.linear_velocity = Vector3.ZERO
	pin.angular_velocity = Vector3.ZERO
	pin.position = pins[pin]["position"]
	pin.rotation = pins[pin]["rotation"]

## Rolls the ball based on the given statistics
func roll_ball(velocity: float, angle: float, backspin: float, sidespin: float, offset: float = 0) -> void:
	ball_body.freeze = true
	ball_body.linear_velocity = Vector3.ZERO
	ball_body.angular_velocity = Vector3.ZERO
	ball_body.position = Vector3(offset, 0.17, 10)
	ball_body.rotation = Vector3(0, 0, 0)
	
	ball_body.freeze = false
	var radian_angle: float = deg_to_rad(-angle)
	var x_velocity: float = velocity * sin(radian_angle)
	var z_velocity: float = velocity * cos(radian_angle)
	ball_body.linear_velocity = Vector3(x_velocity, 0, z_velocity * -1)
	ball_body.angular_velocity = Vector3(backspin, 0, sidespin)
	
	

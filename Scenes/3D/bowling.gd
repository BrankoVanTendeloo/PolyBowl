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

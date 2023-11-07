class_name XRFirearmTrigger
extends Node


@export var mesh_trigger : MeshInstance3D

@export var value : float

@onready var _parent : RigidBody3D = get_parent()

# Current controller holding this object
var _current_controller : XRController3D

var triggered : bool = false


# Add support for is_xr_class on XRTools classes
func is_xr_class(name : String) -> bool:
	return name == "XRFirearmTrigger"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Listen for when this object is picked up or dropped
	_parent.picked_up.connect(_on_picked_up)
	_parent.dropped.connect(_on_dropped)


# Called when this object is picked up
func _on_picked_up(_pickable) -> void:
	# Listen for button events on the associated controller
	_current_controller = _parent.get_picked_up_by_controller()
	if _current_controller:
		_current_controller.button_pressed.connect(_on_controller_trigger_pressed)
		_current_controller.button_released.connect(_on_controller_trigger_released)


# Called when this object is dropped
func _on_dropped(_pickable) -> void:
	# Unsubscribe to controller button events when dropped
	if _current_controller:
		_current_controller.button_pressed.disconnect(_on_controller_trigger_pressed)
		_current_controller.button_released.disconnect(_on_controller_trigger_released)
		if triggered:
			mesh_trigger.rotate(Vector3(1, 0, 0), value)
			triggered = false
		_current_controller = null


func _on_controller_trigger_released(trigger_button : String):
	# Skip if not pose-toggle button
	if trigger_button != "trigger_click":
		return

	mesh_trigger.rotate(Vector3(1, 0, 0), value)
	triggered = false


# Called when a controller button is pressed
func _on_controller_trigger_pressed(trigger_button : String):
	# Skip if not pose-toggle button
	if trigger_button != "trigger_click":
		return
	triggered = true
	mesh_trigger.rotate(Vector3(1, 0, 0), -value)

tool
class_name MovementProvider
extends Node

##
## Movement Provider base class
##
## @desc:
##     This MovementProvider class is the base class of all movement providers.
##     Movement providers are invoked by the PlayerBody object in order to apply
##     motion to the player
##

# Override this function to apply motion to the PlayerBody
func physics_movement(delta: float, player_body: PlayerBody):
	pass

# This method verifies the MovementProvider has a valid configuration.
func _get_configuration_warning():
	if !is_in_group("movement_providers"):
		return "Movement provider not in 'movement_providers' group"

	# Passed basic validation
	return ""

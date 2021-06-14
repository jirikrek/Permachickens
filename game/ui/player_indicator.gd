extends HBoxContainer

var farmer: Farmer


# Initialize children dependencies
func _enter_tree():
	$EnergyProgress.need = farmer.energy

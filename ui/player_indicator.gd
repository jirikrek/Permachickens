extends HBoxContainer


var farmer: Farmer

func _enter_tree():
	$EnergyProgress.need = farmer.energy

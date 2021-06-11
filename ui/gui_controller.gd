extends CanvasLayer

var farmer: Farmer


func _enter_tree():
	$FarmerIndicator.farmer = farmer

# TODO: scale the same way the camera is being zoomed
func _ready():
	scale = Vector2(4, 4)

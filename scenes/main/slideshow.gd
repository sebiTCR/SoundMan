extends VBoxContainer

@export var backward_button: Button
@export var forward_button: Button
@export var slides: Array[Control]

var _current_slide: int = 1

#region Private Methods


func _turn_slide(reverse: bool):
	var invertor = -1 if reverse else 1

	_current_slide += invertor
	for slide in slides:
		slide.visible = false
	slides[_current_slide].visible = true
	_check_button_visibility()


func _check_button_visibility():
	backward_button.visible = !(_current_slide == 0)
	forward_button.visible  = !(_current_slide == slides.size()-1) 


#endregion


#region System

func _ready():
	backward_button.connect("pressed", func(): _turn_slide(true))
	forward_button.connect("pressed", func(): _turn_slide(false))
	for slide in slides:
		slide.visible = false
	slides[0].visible = true
#endregion

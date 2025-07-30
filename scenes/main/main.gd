extends Node2D

@export_category("Slides")
@export var slide_logo: TextureRect


#region animations

func _show_logo():
	var last_position = slide_logo.position
	slide_logo.position -= Vector2(200, 200)
	create_tween().tween_property(slide_logo, "position", last_position, 3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

#endregion


#region System


#endregion

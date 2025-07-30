class_name SFXButton
extends Button


@export_category("Sound Effects")
@export var pressed_sfx_id: String


func _enter_tree() -> void:
	connect("pressed", func(): SoundManager.play(pressed_sfx_id))

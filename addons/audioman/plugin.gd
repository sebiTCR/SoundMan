@tool
extends EditorPlugin

const main_menu = preload("res://addons/audioman/ui/main_menu/main_menu.tscn")
const AUTOLOAD_NAME = "AudioManager"

var main_menu_instance: Control


#----- Private Methods ------



#----- System -----

func _enter_tree() -> void:
	main_menu_instance = main_menu.instantiate()
	EditorInterface.get_editor_main_screen().add_child(main_menu_instance)
	_make_visible(false)


func _exit_tree() -> void:
	main_menu_instance.queue_free()


func _get_plugin_name():
	return "Audioman"


func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("AudioStreamPlayer", "EditorIcons")


func _enable_plugin():
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/audioman/scripts/managers/audio_manager.gd")


func _disable_plugin():
	remove_autoload_singleton(AUTOLOAD_NAME)


func _has_main_screen() -> bool:
	return true


func _make_visible(val: bool):
	if main_menu_instance:
		main_menu_instance.visible = val

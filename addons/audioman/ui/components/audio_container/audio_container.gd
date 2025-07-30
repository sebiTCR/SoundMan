@tool
extends MarginContainer

@export_category("Components")
@export var add_button: Button
@export var refresh_button: Button
@export var container: Container

const creation_dialogue = preload("res://addons/audioman/ui/components/text_input_dialogue/text_input_dialogue.tscn")

var _audio_entry = preload("res://addons/audioman/ui/components/audio_entry/audio_entry.tscn")



#region Signals

func _on_add():
	var audio_name: String
	var entry = _audio_entry.instantiate()
	var _creation_dialogue_instance: ConfirmationDialog
	
	_creation_dialogue_instance = creation_dialogue.instantiate()
	add_child(_creation_dialogue_instance)
	_creation_dialogue_instance.popup_centered()
	audio_name = await _creation_dialogue_instance.confirm
	entry.set_audio_name(audio_name)
	AudioManager.create_audio_entry(audio_name)
	
	container.add_child(entry)


func _refresh():
	for n in container.get_children():
		n.queue_free()
	for k in AudioManager.get_entries():
		var entry = _audio_entry.instantiate()
		container.add_child(entry)
		entry.set_existing_data(k, AudioManager.get_stream(k))

#endregion

func _enter_tree() -> void:
	add_button.connect("pressed", _on_add)
	refresh_button.connect("pressed", _refresh)


func _exit_tree() -> void:
	add_button.disconnect("pressed", _on_add)
	refresh_button.disconnect("pressed", _refresh)

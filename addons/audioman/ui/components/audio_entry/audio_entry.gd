@tool
extends Control

@export var loaded_audio_label: Label
@export var delete_button: Button
@export var container: Control


var _audio_name: String
var _picker: EditorResourcePicker

#region Public Methods

func set_audio_name(audio_name: String):
	loaded_audio_label.text = audio_name
	_audio_name = audio_name


func set_existing_data(audio_name: String, stream: AudioStream):
	_audio_name = audio_name
	_picker.edited_resource = stream
	loaded_audio_label.text = audio_name


#endregion

#region Private Methods

func _create_picker():
	var picker = EditorResourcePicker.new()
	picker.base_type = "AudioStream"
	picker.connect("resource_changed", _on_resource_change)
	picker.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	return picker


#endregion

#region Signals

func _on_resource_change(resource: AudioStream):
	SoundManager.update_audio_stream(_audio_name, resource)


func _on_delete():
	SoundManager.delete(_audio_name)
	queue_free()


#endregion

#----- System -----

func _enter_tree() -> void:
	delete_button.connect("pressed", _on_delete)
	_picker = _create_picker()
	container.add_child(_picker)
	container.move_child(_picker, 3)

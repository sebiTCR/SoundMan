@tool
extends ConfirmationDialog

@export var text_input: TextEdit
@export var warning_label: RichTextLabel

signal confirm(value: String)


#region Public Methods 

func show():
	text_input.text = ""
	visible = true
	
#endregion


#region signals

func _on_confirmed():
	if text_input.text == "":
		warning_label.text = "[color=#fa0000] Don't leave the textbox empty! [/color]"
		return
	emit_signal("confirm", text_input.text)
	visible = false


#TODO: Check if the value already exists
func _on_text_change():
	var exists = false
	warning_label.text = ""
	if exists:
		warning_label.text = "[color=#fa0000] Entry already exists! [/color]"

#endregion


#region system

func _enter_tree() -> void:
	visible = false
	connect("confirmed", _on_confirmed)
	text_input.connect("text_changed", _on_text_change)

#endregion

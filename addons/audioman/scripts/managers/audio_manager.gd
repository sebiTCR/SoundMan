@tool
extends Node

@export var database: AudioManDatabase

var _audio_database: Dictionary = {}
var _audio_node_container: Node = Node.new()

#region Public Methods

##Creates an audio entry in the database
func create_audio_entry(audio_name: String):
	_audio_database[audio_name] = AudioStreamPlayer.new()
	database.data[audio_name] = null


func update_audio_stream(audio_name: String, stream: AudioStream):
	_audio_database[audio_name].stream = stream
	database.data[audio_name] = stream


func play(audio_name: String):
	if _audio_database.has(audio_name):
		_audio_database[audio_name].play()


##Delets an entry from the database
func delete(audio_name: String):
	_audio_database.erase(audio_name)
	database.data.erase(audio_name)


func get_entries() -> Array:
	print("Getting entries")
	return _audio_database.keys()


func get_stream(audio_name: String) -> AudioStream:
	if database.data.has(audio_name):
		return database.data[audio_name]
	return null

#endregion


#region Private Methods

func _refresh_entries():
	for n in _audio_node_container.get_children():
		n.queue_free()
	_load_database_data()
	_add_players()


func _add_players():
	for k in _audio_database.keys():
		_audio_node_container.add_child(_audio_database[k])


func _create_stream_player(stream: AudioStream) -> AudioStreamPlayer:
	var player = AudioStreamPlayer.new()
	player.stream = stream
	return player


func _load_database_data():
	for k in database.data.keys():
		_audio_database[k] = _create_stream_player(database.data[k])

#endregion

#region System

func _ready():
	_refresh_entries()
	add_child(_audio_node_container)


func _enter_tree() -> void:
	database = preload("res://addons/audioman/resources/databases/sfx_db.tres")

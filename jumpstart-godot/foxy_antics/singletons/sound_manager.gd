extends Node


const SOUND_BOSS_ARRIVE = "boss_arrive"
const SOUND_CHECKPOINT = "checkpoint"
const SOUND_DAMAGE = "damage"
const SOUND_FARM = "Farm"
const SOUND_FLOWING = "Flowing"
const SOUND_GAME_OVER = "game_over"
const SOUND_IMPACT = "impact"
const SOUND_JUMP = "jump"
const SOUND_LAND = "land"
const SOUND_LASER = "laser"
const SOUND_PHASEJUMP1 = "phaseJump1"
const SOUND_PICKUP3 = "pickup3"
const SOUND_PICKUP5 = "pickup5"
const SOUND_PICKUP = "pickup"
const SOUND_YOU_WIN = "you_win"


var SOUNDS = {
	SOUND_BOSS_ARRIVE: preload("res://assets/sound/boss_arrive.wav"),
	SOUND_CHECKPOINT: preload("res://assets/sound/checkpoint.wav"),
	SOUND_DAMAGE: preload("res://assets/sound/damage.wav"),
	SOUND_FARM: preload("res://assets/sound/Farm Frolics.ogg"),
	SOUND_FLOWING: preload("res://assets/sound/Flowing Rocks.ogg"),
	SOUND_GAME_OVER: preload("res://assets/sound/game_over.ogg"),
	SOUND_IMPACT: preload("res://assets/sound/impact.wav"),
	SOUND_JUMP: preload("res://assets/sound/jump.wav"),
	SOUND_LAND: preload("res://assets/sound/land.wav"),
	SOUND_LASER: preload("res://assets/sound/laser.wav"),
	SOUND_PHASEJUMP1: preload("res://assets/sound/phaseJump1.ogg"),
	SOUND_PICKUP3: preload("res://assets/sound/pickup3.ogg"),
	SOUND_PICKUP5: preload("res://assets/sound/pickup5.ogg"),
	SOUND_PICKUP: preload("res://assets/sound/pickup.wav"),
	SOUND_YOU_WIN: preload("res://assets/sound/you_win.ogg"),
}


func play_clip(player: AudioStreamPlayer2D, clip_key: String) -> void:
	if not SOUNDS.has(clip_key):
		return

	player.stream = SOUNDS[clip_key]
	player.play()

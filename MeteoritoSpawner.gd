## MeteoritoSpawner.gd
extends Position2D

## Atributos export
export var direccion : Vector2 = Vector2(1,1)

## Metodos
func _ready() -> void:
	yield(owner, "ready")
	spawnear_meteorito()

func spawnear_meteorito() -> void:
	Eventos.emit_signal("spawn_meteorito", global_position, direccion)

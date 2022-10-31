## Nivel.gd
class_name Nivel
extends Node2D

## Atributos onready
onready var contenedor_proyectiles = Node
onready var contenedor_meteoritos = Node

## Atributos export
export var explosion : PackedScene = null
export var meteorito : PackedScene = null

## Metodos
func _ready() -> void:
	conectar_seniales()
	crear_contenedores()

## Metodos custom
func conectar_seniales() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("nave_destruida", self, "_on_nave_destruida")
	Eventos.connect("spawn_meteorito", self, "_on_spawn_meteoritos")

func crear_contenedores() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)
	contenedor_meteoritos = Node.new()
	contenedor_meteoritos.name = "ContenedorMeteoritos"
	add_child(contenedor_meteoritos)

func _on_disparo(proyectil : Proyectil) -> void:
	add_child(proyectil)

## Conexiones señales externas
func _on_nave_destruida(posicion : Vector2, num_explosiones : int) -> void:
	for i in range(num_explosiones):
		var new_explosion : Node2D = explosion.instance()
		new_explosion.global_position = posicion
		add_child(new_explosion)
		yield(get_tree().create_timer(0.6), "timeout")

func _on_spawn_meteoritos(pos_spawn : Vector2, dir_meteorito : Vector2) -> void:
	var new_meteorito : Meteorito = meteorito.instance()
	new_meteorito.crear(pos_spawn, dir_meteorito)
	contenedor_meteoritos.add_child(new_meteorito)
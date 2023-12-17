package physics

import la "core:math/linalg"

Object :: struct {
	position: la.Vector2f32,
	velocity: la.Vector2f32,
	force:    la.Vector2f32,
	mass:     f32,
}


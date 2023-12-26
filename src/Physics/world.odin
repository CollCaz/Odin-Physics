package physics

import "core:fmt"
import la "core:math/linalg"


Object :: struct {
	positionCurrent: la.Vector2f32,
	oldPosition:     la.Vector2f32,
	accelation:      la.Vector2f32,
	friction:        la.Vector2f32,
}

update :: proc(o: ^Object, dt: f32) {
	velocity := o.positionCurrent - o.oldPosition
	o.oldPosition = o.positionCurrent

	// Verlet Integration
	o.positionCurrent =
		o.positionCurrent + velocity - (velocity * o.friction) + o.accelation * dt * dt

	o.accelation = {}
	o.friction = 0
}

accelerate :: proc(o: ^Object, acc: la.Vector2f32) {
	o.accelation += acc
}

objects: [dynamic]Object

addObject :: proc(o: ^Object) {
	append(&objects, o^)
}

removeObject :: proc(o: ^Object) {
	for &v, i in objects {
		if v == o^ {
			unordered_remove(&objects, i)
		}
	}
}

gravity := la.Vector2f32{0.0, 1000.0}


step :: proc(dt: f32) {
	for &o in objects {
		accelerate(&o, gravity)
		applyConstraint(&o)
		update(&o, dt)
	}
}

constraint := la.Vector2f32{400, 0}
radius: f32 = 400.0

applyConstraint :: proc(o: ^Object) {
	vec_to_obj := o.positionCurrent - constraint
	dist := la.distance(o.positionCurrent, constraint)

	if (dist > radius - 30) {
		n := vec_to_obj / dist

		o.positionCurrent = constraint + (n) * (radius - 30)

		o.friction += 0.008
	}
}

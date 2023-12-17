package physics

import "core:fmt"
import la "core:math/linalg"

gravity := la.Vector2f32{0, 0.0981}

Object :: struct {
	position: la.Vector2f32,
	velocity: la.Vector2f32,
	force:    la.Vector2f32,
	mass:     f32,
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

step :: proc(dt: f32) {
	for &o, _ in objects {
		fmt.println(o)
		// set force then make sure it's reset at the end of the step
		o.force += o.mass * gravity
		defer o.force = la.Vector2f32{0, 0}

		o.velocity += o.force / o.mass * dt
		o.position += o.velocity
	}
}

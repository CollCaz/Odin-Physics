package physics

import "core:fmt"
import la "core:math/linalg"
import rl "vendor:raylib"


Object :: struct {
	radius:          f32,
	color:           rl.Color,
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
		solveCollisions(&o, dt)
		applyConstraint(&o)
		update(&o, dt)
	}
}

// TODO:
// O(n^2) algo for testing
// Change later
solveCollisions :: proc(o1: ^Object, dt: f32) {
	for &o in objects {
		if o1^ != o {
			sumOfRad := o1.radius + o.radius
			collisionAxis := o1.positionCurrent - o.positionCurrent
			dist := la.length(collisionAxis)
			overlap := (sumOfRad - dist)
			colVec := (collisionAxis / dist) * overlap
			if dist < sumOfRad {
				fmt.println("Collision")
				o.positionCurrent -= colVec / 2
				o1.positionCurrent += colVec / 2
			}
		}
	}
}

constraint := la.Vector2f32{400, 0}
radius: f32 = 400.0

applyConstraint :: proc(o: ^Object) {
	vec_to_obj := o.positionCurrent - constraint
	dist := la.distance(o.positionCurrent, constraint)

	if (dist > radius - o.radius) {
		n := vec_to_obj / dist

		o.positionCurrent = constraint + (n) * (radius - o.radius)
		//fmt.println(vec_to_obj)

		//o.friction += 0.02
	}
}

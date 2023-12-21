package main

import p "Physics"
import "core:fmt"
import la "core:math/linalg"
import rl "vendor:raylib"

main :: proc() {
	vec := la.Vector2f32{50, 0}
	vec2 := la.Vector2f32{30, 0}

	defer fmt.println("bye!")

	ob1 := p.Object {
		positionCurrent = vec,
		oldPosition     = vec,
	}

	ob2 := p.Object {
		positionCurrent = vec2,
		oldPosition     = vec2,
	}

	fmt.println(p.objects)
	p.addObject(&ob1)
	p.addObject(&ob2)

	o1 := &p.objects[0]
	o2 := &p.objects[1]

	rl.InitWindow(800, 400, "AA")
	rl.SetTargetFPS(60)

	for (!rl.WindowShouldClose()) {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawCircle((i32)(p.constraint.x), (i32)(p.constraint.y), p.radius, rl.GRAY)

		rl.DrawCircle((i32)(o1.positionCurrent.x), (i32)(o1.positionCurrent.y), 30, rl.WHITE)

		p.step(rl.GetFrameTime())

		rl.EndDrawing()
	}
}

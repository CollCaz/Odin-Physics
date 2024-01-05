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
		radius          = 30,
	}

	ob2 := p.Object {
		positionCurrent = vec2,
		oldPosition     = vec2,
		radius          = 20,
	}

	p.addObject(&ob1)
	p.addObject(&ob2)

	rl.InitWindow(800, 400, "AA")
	rl.SetTargetFPS(60)

	for (!rl.WindowShouldClose()) {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawCircleV(p.constraint, p.radius, rl.GRAY)

		for &o in p.objects {
			rl.DrawCircleV(o.positionCurrent, o.radius, rl.WHITE)
		}

		p.step(rl.GetFrameTime())
		selectBall()

		rl.EndDrawing()
	}
}

selectBall :: proc() {
	// Only works when mouse is pressed
	if !rl.IsMouseButtonDown(rl.MouseButton.LEFT) {
		return
	}
	ms := rl.GetMousePosition()
	for &o in p.objects {
		// if mouse within ball
		if la.length(ms - o.positionCurrent) <= o.radius {
			o.positionCurrent = ms
			return
		}
	}
}

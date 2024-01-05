package main

import p "Physics"
import "core:fmt"
import la "core:math/linalg"
import rl "vendor:raylib"

main :: proc() {
	vec := la.Vector2f32{50, 0}
	vec2 := la.Vector2f32{750, 10}

	defer fmt.println("bye!")

	ob1 := p.Object {
		positionCurrent = vec,
		oldPosition     = vec,
		radius          = 30,
		color           = rl.PINK,
	}

	ob2 := p.Object {
		positionCurrent = vec2,
		oldPosition     = vec2,
		radius          = 30,
		color           = rl.SKYBLUE,
	}

	for i := 0; i < 100; i += 1 {
		o := p.Object {
			positionCurrent = la.Vector2f32 {
				vec.x + (f32)(rl.GetRandomValue(0, 100)),
				vec.y + (f32)(rl.GetRandomValue(0, 100)),
			},
			oldPosition = la.Vector2f32 {
				vec.x + (f32)(rl.GetRandomValue(0, 100)),
				vec.y + (f32)(rl.GetRandomValue(0, 100)),
			},
			radius = 10,
			color = rl.PURPLE,
		}
		p.addObject(&o)
	}

	p.addObject(&ob1)
	p.addObject(&ob2)

	rl.InitWindow(800, 400, "AA")
	rl.SetTargetFPS(60)

	fmt.println(p.objects)
	for (!rl.WindowShouldClose()) {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawCircleV(p.constraint, p.radius, rl.GRAY)

		for &o in p.objects {
			rl.DrawCircleV(o.positionCurrent, o.radius, o.color)
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

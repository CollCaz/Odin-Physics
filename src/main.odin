package main

import p "Physics"
import "core:fmt"
import la "core:math/linalg"
import rl "vendor:raylib"

main :: proc() {
	vec := la.Vector2f32{370, 20}
	vec2 := la.Vector2f32{0, 0}

	defer fmt.println("bye!")

	o := p.Object {
		positionCurrent = vec,
		oldPosition     = vec,
	}

	fmt.println(p.objects)
	p.addObject(&o)

	ob := &p.objects[0]

	rl.InitWindow(800, 700, "AA")

	for (!rl.WindowShouldClose()) {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawCircle((i32)(ob.positionCurrent.x), (i32)(ob.positionCurrent.y), 3, rl.WHITE)

		p.step(rl.GetFrameTime())

		rl.EndDrawing()
	}
}

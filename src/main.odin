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
		position = vec,
		velocity = vec2,
		force    = vec,
		mass     = 20.0,
	}

	fmt.println(p.objects)
	p.addObject(&o)

	ob := &p.objects[0]

	rl.InitWindow(800, 700, "AA")

	for (!rl.WindowShouldClose()) {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawCircle((i32)(ob.position.x), (i32)(ob.position.y), 30, rl.WHITE)

		p.step(rl.GetFrameTime())

		rl.EndDrawing()
	}
}

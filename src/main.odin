package main

import p "Physics"
import "core:fmt"
import la "core:math/linalg"
import rl "vendor:raylib"


step := true

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
	//rl.SetTargetFPS(60)

	for (!rl.WindowShouldClose()) {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		rl.DrawFPS(2, 2)

		rl.DrawCircle((i32)(p.constraint.x), (i32)(p.constraint.y), p.radius, rl.GRAY)

		//rl.DrawCircle((i32)(o1.positionCurrent.x), (i32)(o1.positionCurrent.y), 30, rl.WHITE)
		control()
		createBall()
		//rl.DrawCircleV(o1.positionCurrent, 30.0, rl.WHITE)
		for &o in p.objects {
			rl.DrawCircleV(o.positionCurrent, 30.0, rl.WHITE)
		}

		p.step(rl.GetFrameTime(), step)

		rl.EndDrawing()
	}
}

control :: proc() {
	ms := rl.GetMousePosition()
	if rl.IsMouseButtonDown(rl.MouseButton.LEFT) {
		step = false
		found, o := isMouseOnBall()
		if !found {
			return
		}
		o.positionCurrent = ms
	}
}

createBall :: proc() {
	if !rl.IsMouseButtonPressed(rl.MouseButton.LEFT) {
		return
	}
	found, o := isMouseOnBall()
	if found {
		return
	}

	fmt.println("Creating")
	pos := rl.GetMousePosition()
	ball := p.Object {
		positionCurrent = pos,
		oldPosition     = pos,
	}

	p.addObject(&ball)
}

isMouseOnBall :: proc() -> (bool, ^p.Object) {
	for &o in p.objects {
		if la.distance(o.positionCurrent, rl.GetMousePosition()) <= 30 {
			return true, &o
		}
	}
	return false, nil
}

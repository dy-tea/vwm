module pixman

import rand

// TODO make this build
fn test_region() {
	mut r1 := unsafe { C.pixman_region32_t{} }
	mut r2 := unsafe { C.pixman_region32_t{} }
	mut r3 := unsafe { C.pixman_region32_t{} }

	boxes := [
		C.pixman_box32_t{10, 10, 20, 20},
		C.pixman_box32_t{30, 30, 30, 40},
		C.pixman_box32_t{50, 45, 60, 44},
	]

	boxes2 := [
		C.pixman_box32_t{2, 6, 7, 6},
		C.pixman_box32_t{4, 1, 6, 7},
	]

	boxes3 := [
		C.pixman_box32_t{2, 6, 7, 6},
		C.pixman_box32_t{4, 1, 6, 1},
	]

	mut i := 0
	mut j := 0

	mut image := C.pixman_image_t{}
	mut fill := C.pixman_image_t{}
	white := C.pixman_color_t{0xffff, 0xffff, 0xffff, 0xffff}

	rand.seed([u32(0), u32(0)])

	pixman_region32_init_rect(&r1, 0, 0, 20, 64000)
	pixman_region32_init_rect(&r2, 0, 0, 20, 64000)
	pixman_region32_init_rect(&r3, 0, 0, 20, 64000)

	pixman_region32_subtract(&r1, &r2, &r3)

	pixman_region32_init_rects(&r1, &boxes[0], 3)

	mut b := pixman_region32_rectangles(&r1, &i)

	assert i == 1

	for i > 0 {
		unsafe {
			assert b[i].x1 < b[i].x2
			assert b[i].y1 < b[i].y2
		}
		i -= 1
	}

	pixman_region32_init_rects(&r1, &boxes2[0], 2)

	b = pixman_region32_rectangles(&r1, &i)

	assert i == 1

	unsafe {
		assert b[0].x1 == 4
		assert b[0].y1 == 1
		assert b[0].x2 == 6
		assert b[0].y2 == 7
	}
	pixman_region32_init_rects(&r1, &boxes3[0], 2)

	b = pixman_region32_rectangles(&r1, &i)

	assert i == 0

	fill = pixman_image_create_solid_fill(white)
	for _ in 0 .. 100 {
		size := 128

		pixman_region32_init(&r1)

		for _ in 0 .. 64 {
			pixman_region32_union_rect(r1, r2, rand.intn(size) or { 0 }, rand.intn(size) or { 0 },
				u32(rand.intn(25) or { 0 }), u32(rand.intn(25) or { 0 }))
		}

		pixman_region32_init_rect(&r2, 0, 0, u32(size), u32(size))
		pixman_region32_intersect(&r1, &r1, &r2)
		pixman_region32_fini(&r2)

		image = pixman_image_create_bits(C.pixman_format_code_t.pixman_a1, size, size,
			unsafe { nil }, 0)
		pixman_image_set_clip_region32(&image, &r1)
		pixman_image_composite32(C.pixman_op_t.pixman_op_src, &fill, unsafe { nil }, &image,
			0, 0, 0, 0, 0, 0, size, size)
		pixman_region32_init_from_image(&r2, &image)

		pixman_image_unref(&image)

		assert pixman_region32_equal(&r1, &r2)
		pixman_region32_fini(&r1)
		pixman_region32_fini(&r2)
	}

	pixman_image_unref(&fill)
}

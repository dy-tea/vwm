@[translated]
module pixman

#flag linux -I/usr/include/pixman-1
#flag linux -lpixman-1
#include <pixman.h>

//*****************************
//
// Copyright 1987, 1998  The Open Group
//
// Permission to use, copy, modify, distribute, and sell this software and its
// documentation for any purpose is hereby granted without fee, provided that
// the above copyright notice appear in all copies and that both that
// copyright notice and this permission notice appear in supporting
// documentation.
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
// AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// Except as contained in this notice, the name of The Open Group shall not be
// used in advertising or otherwise to promote the sale, use or other dealings
// in this Software without prior written authorization from The Open Group.
//
// Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts.
//
//                        All Rights Reserved
//
// Permission to use, copy, modify, and distribute this software and its
// documentation for any purpose and without fee is hereby granted,
// provided that the above copyright notice appear in all copies and that
// both that copyright notice and this permission notice appear in
// supporting documentation, and that the name of Digital not be
// used in advertising or publicity pertaining to distribution of the
// software without specific, written prior permission.
//
// DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
// ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
// DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
// ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
// WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
// ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
// SOFTWARE.
//
//*********************************/
///* *Copyright Â© 1998, 2004 Keith Packard
// *Copyright   2007 Red Hat, Inc.
// * *Permission to use, copy, modify, distribute, and sell this software and its
// *documentation for any purpose is hereby granted without fee, provided that
// *the above copyright notice appear in all copies and that both that
// *copyright notice and this permission notice appear in supporting
// *documentation, and that the name of Keith Packard not be used in
// *advertising or publicity pertaining to distribution of the software without
// *specific, written prior permission.  Keith Packard makes no
// *representations about the suitability of this software for any purpose.  It
// *is provided "as is" without express or implied warranty.
// * *KEITH PACKARD DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
// *INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
// *EVENT SHALL KEITH PACKARD BE LIABLE FOR ANY SPECIAL, INDIRECT OR
// *CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
// *DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
// *TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
// *PERFORMANCE OF THIS SOFTWARE.
//
// *Misc structs
//
pub type Pixman_color_t = struct {
	red   u16
	green u16
	blue  u16
	alpha u16
}
pub type Pixman_point_fixed_t = struct {
	x int
	y int
}
pub type Pixman_line_fixed_t = struct {
	p1 Pixman_point_fixed_t
	p2 Pixman_point_fixed_t
}
pub type Pixman_vector_t = struct {
	vector [3]int
}
pub type Pixman_transform_t = struct {
	matrix [3][3]int
}

pub struct Pixman_color {
	red   u16
	green u16
	blue  u16
	alpha u16
}

pub struct Pixman_point_fixed {
	x int
	y int
}

pub struct Pixman_line_fixed {
	p1 Pixman_point_fixed_t
	p2 Pixman_point_fixed_t
}

//
// *Fixed point matrices
//
pub struct Pixman_vector {
	vector [3]int
}

pub struct Pixman_transform {
	matrix [3][3]int
}

// forward declaration (sorry)
pub struct Pixman_image_t {}

fn C.pixman_transform_init_identity(matrix &Pixman_transform)

pub fn pixman_transform_init_identity(matrix &Pixman_transform) {
	C.pixman_transform_init_identity(matrix)
}

fn C.pixman_transform_point_3d(transform &Pixman_transform, vector &Pixman_vector) bool

pub fn pixman_transform_point_3d(transform &Pixman_transform, vector &Pixman_vector) bool {
	return C.pixman_transform_point_3d(transform, vector)
}

fn C.pixman_transform_point(transform &Pixman_transform, vector &Pixman_vector) bool

pub fn pixman_transform_point(transform &Pixman_transform, vector &Pixman_vector) bool {
	return C.pixman_transform_point(transform, vector)
}

fn C.pixman_transform_multiply(dst &Pixman_transform, l &Pixman_transform, r &Pixman_transform) bool

pub fn pixman_transform_multiply(dst &Pixman_transform, l &Pixman_transform, r &Pixman_transform) bool {
	return C.pixman_transform_multiply(dst, l, r)
}

fn C.pixman_transform_init_scale(t &Pixman_transform, sx int, sy int)

pub fn pixman_transform_init_scale(t &Pixman_transform, sx int, sy int) {
	C.pixman_transform_init_scale(t, sx, sy)
}

fn C.pixman_transform_scale(forward &Pixman_transform, reverse &Pixman_transform, sx int, sy int) bool

pub fn pixman_transform_scale(forward &Pixman_transform, reverse &Pixman_transform, sx int, sy int) bool {
	return C.pixman_transform_scale(forward, reverse, sx, sy)
}

fn C.pixman_transform_init_rotate(t &Pixman_transform, cos int, sin int)

pub fn pixman_transform_init_rotate(t &Pixman_transform, cos int, sin int) {
	C.pixman_transform_init_rotate(t, cos, sin)
}

fn C.pixman_transform_rotate(forward &Pixman_transform, reverse &Pixman_transform, c int, s int) bool

pub fn pixman_transform_rotate(forward &Pixman_transform, reverse &Pixman_transform, c int, s int) bool {
	return C.pixman_transform_rotate(forward, reverse, c, s)
}

fn C.pixman_transform_init_translate(t &Pixman_transform, tx int, ty int)

pub fn pixman_transform_init_translate(t &Pixman_transform, tx int, ty int) {
	C.pixman_transform_init_translate(t, tx, ty)
}

fn C.pixman_transform_translate(forward &Pixman_transform, reverse &Pixman_transform, tx int, ty int) bool

pub fn pixman_transform_translate(forward &Pixman_transform, reverse &Pixman_transform, tx int, ty int) bool {
	return C.pixman_transform_translate(forward, reverse, tx, ty)
}

fn C.pixman_transform_bounds(matrix &Pixman_transform, b &Pixman_box16) bool

pub fn pixman_transform_bounds(matrix &Pixman_transform, b &Pixman_box16) bool {
	return C.pixman_transform_bounds(matrix, b)
}

fn C.pixman_transform_invert(dst &Pixman_transform, src &Pixman_transform) bool

pub fn pixman_transform_invert(dst &Pixman_transform, src &Pixman_transform) bool {
	return C.pixman_transform_invert(dst, src)
}

fn C.pixman_transform_is_identity(t &Pixman_transform) bool

pub fn pixman_transform_is_identity(t &Pixman_transform) bool {
	return C.pixman_transform_is_identity(t)
}

fn C.pixman_transform_is_scale(t &Pixman_transform) bool

pub fn pixman_transform_is_scale(t &Pixman_transform) bool {
	return C.pixman_transform_is_scale(t)
}

fn C.pixman_transform_is_int_translate(t &Pixman_transform) bool

pub fn pixman_transform_is_int_translate(t &Pixman_transform) bool {
	return C.pixman_transform_is_int_translate(t)
}

fn C.pixman_transform_is_inverse(a &Pixman_transform, b &Pixman_transform) bool

pub fn pixman_transform_is_inverse(a &Pixman_transform, b &Pixman_transform) bool {
	return C.pixman_transform_is_inverse(a, b)
}

//
// *Floating point matrices
//
type Pixman_f_transform_t = Pixman_f_transform
type Pixman_f_vector_t = Pixman_f_vector

struct Pixman_f_vector {
	v [3]f64
}

struct Pixman_f_transform {
	m [3][3]f64
}

fn C.pixman_transform_from_pixman_f_transform(t &Pixman_transform, ft &Pixman_f_transform) bool

pub fn pixman_transform_from_pixman_f_transform(t &Pixman_transform, ft &Pixman_f_transform) bool {
	return C.pixman_transform_from_pixman_f_transform(t, ft)
}

fn C.pixman_f_transform_from_pixman_transform(ft &Pixman_f_transform, t &Pixman_transform)

pub fn pixman_f_transform_from_pixman_transform(ft &Pixman_f_transform, t &Pixman_transform) {
	C.pixman_f_transform_from_pixman_transform(ft, t)
}

fn C.pixman_f_transform_invert(dst &Pixman_f_transform, src &Pixman_f_transform) bool

pub fn pixman_f_transform_invert(dst &Pixman_f_transform, src &Pixman_f_transform) bool {
	return C.pixman_f_transform_invert(dst, src)
}

fn C.pixman_f_transform_point(t &Pixman_f_transform, v &Pixman_f_vector) bool

pub fn pixman_f_transform_point(t &Pixman_f_transform, v &Pixman_f_vector) bool {
	return C.pixman_f_transform_point(t, v)
}

fn C.pixman_f_transform_point_3d(t &Pixman_f_transform, v &Pixman_f_vector)

pub fn pixman_f_transform_point_3d(t &Pixman_f_transform, v &Pixman_f_vector) {
	C.pixman_f_transform_point_3d(t, v)
}

fn C.pixman_f_transform_multiply(dst &Pixman_f_transform, l &Pixman_f_transform, r &Pixman_f_transform)

pub fn pixman_f_transform_multiply(dst &Pixman_f_transform, l &Pixman_f_transform, r &Pixman_f_transform) {
	C.pixman_f_transform_multiply(dst, l, r)
}

fn C.pixman_f_transform_init_scale(t &Pixman_f_transform, sx f64, sy f64)

pub fn pixman_f_transform_init_scale(t &Pixman_f_transform, sx f64, sy f64) {
	C.pixman_f_transform_init_scale(t, sx, sy)
}

fn C.pixman_f_transform_scale(forward &Pixman_f_transform, reverse &Pixman_f_transform, sx f64, sy f64) bool

pub fn pixman_f_transform_scale(forward &Pixman_f_transform, reverse &Pixman_f_transform, sx f64, sy f64) bool {
	return C.pixman_f_transform_scale(forward, reverse, sx, sy)
}

fn C.pixman_f_transform_init_rotate(t &Pixman_f_transform, cos f64, sin f64)

pub fn pixman_f_transform_init_rotate(t &Pixman_f_transform, cos f64, sin f64) {
	C.pixman_f_transform_init_rotate(t, cos, sin)
}

fn C.pixman_f_transform_rotate(forward &Pixman_f_transform, reverse &Pixman_f_transform, c f64, s f64) bool

pub fn pixman_f_transform_rotate(forward &Pixman_f_transform, reverse &Pixman_f_transform, c f64, s f64) bool {
	return C.pixman_f_transform_rotate(forward, reverse, c, s)
}

fn C.pixman_f_transform_init_translate(t &Pixman_f_transform, tx f64, ty f64)

pub fn pixman_f_transform_init_translate(t &Pixman_f_transform, tx f64, ty f64) {
	C.pixman_f_transform_init_translate(t, tx, ty)
}

fn C.pixman_f_transform_translate(forward &Pixman_f_transform, reverse &Pixman_f_transform, tx f64, ty f64) bool

pub fn pixman_f_transform_translate(forward &Pixman_f_transform, reverse &Pixman_f_transform, tx f64, ty f64) bool {
	return C.pixman_f_transform_translate(forward, reverse, tx, ty)
}

fn C.pixman_f_transform_bounds(t &Pixman_f_transform, b &Pixman_box16) bool

pub fn pixman_f_transform_bounds(t &Pixman_f_transform, b &Pixman_box16) bool {
	return C.pixman_f_transform_bounds(t, b)
}

fn C.pixman_f_transform_init_identity(t &Pixman_f_transform)

pub fn pixman_f_transform_init_identity(t &Pixman_f_transform) {
	C.pixman_f_transform_init_identity(t)
}

enum Pixman_repeat_t {
	pixman_repeat_none
	pixman_repeat_normal
	pixman_repeat_pad
	pixman_repeat_reflect
}

enum Pixman_dither_t {
	pixman_dither_none
	pixman_dither_fast
	pixman_dither_good
	pixman_dither_best
	pixman_dither_ordered_bayer_8
	pixman_dither_ordered_blue_noise_64
}

enum Pixman_filter_t {
	pixman_filter_fast
	pixman_filter_good
	pixman_filter_best
	pixman_filter_nearest
	pixman_filter_bilinear
	pixman_filter_convolution
	// The SEPARABLE_CONVOLUTION filter takes the following parameters:
	//     *     *        width:           integer given as 16.16 fixpoint number
	//     *        height:          integer given as 16.16 fixpoint number
	//     *        x_phase_bits:	integer given as 16.16 fixpoint
	//     *        y_phase_bits:	integer given as 16.16 fixpoint
	//     *        xtables:         (1 << x_phase_bits) tables of size width
	//     *        ytables:         (1 << y_phase_bits) tables of size height
	//     *     *When sampling at (x, y), the location is first rounded to one of
	//     *n_x_phases *n_y_phases subpixel positions. These subpixel positions
	//     *determine an xtable and a ytable to use.
	//     *     *Conceptually a width x height matrix is then formed in which each entry
	//     *is the product of the corresponding entries in the x and y tables.
	//     *This matrix is then aligned with the image pixels such that its center
	//     *is as close as possible to the subpixel location chosen earlier. Then
	//     *the image is convolved with the matrix and the resulting pixel returned.
	//
	pixman_filter_separable_convolution
}

enum Pixman_op_t {
	pixman_op_clear                 = 0
	pixman_op_src                   = 1
	pixman_op_dst                   = 2
	pixman_op_over                  = 3
	pixman_op_over_reverse          = 4
	pixman_op_in                    = 5
	pixman_op_in_reverse            = 6
	pixman_op_out                   = 7
	pixman_op_out_reverse           = 8
	pixman_op_atop                  = 9
	pixman_op_atop_reverse          = 10
	pixman_op_xor                   = 11
	pixman_op_add                   = 12
	pixman_op_saturate              = 13
	pixman_op_disjoint_clear        = 16
	pixman_op_disjoint_src          = 17
	pixman_op_disjoint_dst          = 18
	pixman_op_disjoint_over         = 19
	pixman_op_disjoint_over_reverse = 20
	pixman_op_disjoint_in           = 21
	pixman_op_disjoint_in_reverse   = 22
	pixman_op_disjoint_out          = 23
	pixman_op_disjoint_out_reverse  = 24
	pixman_op_disjoint_atop         = 25
	pixman_op_disjoint_atop_reverse = 26
	pixman_op_disjoint_xor          = 27
	pixman_op_conjoint_clear        = 32
	pixman_op_conjoint_src          = 33
	pixman_op_conjoint_dst          = 34
	pixman_op_conjoint_over         = 35
	pixman_op_conjoint_over_reverse = 36
	pixman_op_conjoint_in           = 37
	pixman_op_conjoint_in_reverse   = 38
	pixman_op_conjoint_out          = 39
	pixman_op_conjoint_out_reverse  = 40
	pixman_op_conjoint_atop         = 41
	pixman_op_conjoint_atop_reverse = 42
	pixman_op_conjoint_xor          = 43
	pixman_op_multiply              = 48
	pixman_op_screen                = 49
	pixman_op_overlay               = 50
	pixman_op_darken                = 51
	pixman_op_lighten               = 52
	pixman_op_color_dodge           = 53
	pixman_op_color_burn            = 54
	pixman_op_hard_light            = 55
	pixman_op_soft_light            = 56
	pixman_op_difference            = 57
	pixman_op_exclusion             = 58
	pixman_op_hsl_hue               = 59
	pixman_op_hsl_saturation        = 60
	pixman_op_hsl_color             = 61
	pixman_op_hsl_luminosity        = 62
}

//
// *Regions
//
type Pixman_region16_data_t = Pixman_region16_data
type Pixman_box16_t = Pixman_box16
type Pixman_rectangle16_t = Pixman_rectangle16
type Pixman_region16_t = Pixman_region16

struct Pixman_region16_data {
	size     int
	numRects int
	//  pixman_box16_t	rects[size];   in memory but not explicitly declared
}

struct Pixman_rectangle16 {
	x      i16
	y      i16
	width  u16
	height u16
}

struct Pixman_box16 {
	x1 i16
	y1 i16
	x2 i16
	y2 i16
}

struct Pixman_region16 {
	extents Pixman_box16_t
	data    &Pixman_region16_data_t
}

enum Pixman_region_overlap_t {
	pixman_region_out
	pixman_region_in
	pixman_region_part
}

// This function exists only to make it possible to preserve
// *the X ABI - it should go away at first opportunity.
//
fn C.pixman_region_set_static_pointers(empty_box &Pixman_box16_t, empty_data &Pixman_region16_data_t, broken_data &Pixman_region16_data_t)

pub fn pixman_region_set_static_pointers(empty_box &Pixman_box16_t, empty_data &Pixman_region16_data_t, broken_data &Pixman_region16_data_t) {
	C.pixman_region_set_static_pointers(empty_box, empty_data, broken_data)
}

// creation/destruction
fn C.pixman_region_init(region &Pixman_region16_t)

pub fn pixman_region_init(region &Pixman_region16_t) {
	C.pixman_region_init(region)
}

fn C.pixman_region_init_rect(region &Pixman_region16_t, x int, y int, width u32, height u32)

pub fn pixman_region_init_rect(region &Pixman_region16_t, x int, y int, width u32, height u32) {
	C.pixman_region_init_rect(region, x, y, width, height)
}

fn C.pixman_region_init_rects(region &Pixman_region16_t, boxes &Pixman_box16_t, count int) bool

pub fn pixman_region_init_rects(region &Pixman_region16_t, boxes &Pixman_box16_t, count int) bool {
	return C.pixman_region_init_rects(region, boxes, count)
}

fn C.pixman_region_init_with_extents(region &Pixman_region16_t, extents &Pixman_box16_t)

pub fn pixman_region_init_with_extents(region &Pixman_region16_t, extents &Pixman_box16_t) {
	C.pixman_region_init_with_extents(region, extents)
}

fn C.pixman_region_init_from_image(region &Pixman_region16_t, image &Pixman_image_t)

pub fn pixman_region_init_from_image(region &Pixman_region16_t, image &Pixman_image_t) {
	C.pixman_region_init_from_image(region, image)
}

fn C.pixman_region_fini(region &Pixman_region16_t)

pub fn pixman_region_fini(region &Pixman_region16_t) {
	C.pixman_region_fini(region)
}

// manipulation
fn C.pixman_region_translate(region &Pixman_region16_t, x int, y int)

pub fn pixman_region_translate(region &Pixman_region16_t, x int, y int) {
	C.pixman_region_translate(region, x, y)
}

fn C.pixman_region_copy(dest &Pixman_region16_t, source &Pixman_region16_t) bool

pub fn pixman_region_copy(dest &Pixman_region16_t, source &Pixman_region16_t) bool {
	return C.pixman_region_copy(dest, source)
}

fn C.pixman_region_intersect(new_reg &Pixman_region16_t, reg1 &Pixman_region16_t, reg2 &Pixman_region16_t) bool

pub fn pixman_region_intersect(new_reg &Pixman_region16_t, reg1 &Pixman_region16_t, reg2 &Pixman_region16_t) bool {
	return C.pixman_region_intersect(new_reg, reg1, reg2)
}

fn C.pixman_region_union(new_reg &Pixman_region16_t, reg1 &Pixman_region16_t, reg2 &Pixman_region16_t) bool

pub fn pixman_region_union(new_reg &Pixman_region16_t, reg1 &Pixman_region16_t, reg2 &Pixman_region16_t) bool {
	return C.pixman_region_union(new_reg, reg1, reg2)
}

fn C.pixman_region_union_rect(dest &Pixman_region16_t, source &Pixman_region16_t, x int, y int, width u32, height u32) bool

pub fn pixman_region_union_rect(dest &Pixman_region16_t, source &Pixman_region16_t, x int, y int, width u32, height u32) bool {
	return C.pixman_region_union_rect(dest, source, x, y, width, height)
}

fn C.pixman_region_intersect_rect(dest &Pixman_region16_t, source &Pixman_region16_t, x int, y int, width u32, height u32) bool

pub fn pixman_region_intersect_rect(dest &Pixman_region16_t, source &Pixman_region16_t, x int, y int, width u32, height u32) bool {
	return C.pixman_region_intersect_rect(dest, source, x, y, width, height)
}

fn C.pixman_region_subtract(reg_d &Pixman_region16_t, reg_m &Pixman_region16_t, reg_s &Pixman_region16_t) bool

pub fn pixman_region_subtract(reg_d &Pixman_region16_t, reg_m &Pixman_region16_t, reg_s &Pixman_region16_t) bool {
	return C.pixman_region_subtract(reg_d, reg_m, reg_s)
}

fn C.pixman_region_inverse(new_reg &Pixman_region16_t, reg1 &Pixman_region16_t, inv_rect &Pixman_box16_t) bool

pub fn pixman_region_inverse(new_reg &Pixman_region16_t, reg1 &Pixman_region16_t, inv_rect &Pixman_box16_t) bool {
	return C.pixman_region_inverse(new_reg, reg1, inv_rect)
}

fn C.pixman_region_contains_point(region &Pixman_region16_t, x int, y int, box &Pixman_box16_t) bool

pub fn pixman_region_contains_point(region &Pixman_region16_t, x int, y int, box &Pixman_box16_t) bool {
	return C.pixman_region_contains_point(region, x, y, box)
}

fn C.pixman_region_contains_rectangle(region &Pixman_region16_t, prect &Pixman_box16_t) Pixman_region_overlap_t

pub fn pixman_region_contains_rectangle(region &Pixman_region16_t, prect &Pixman_box16_t) Pixman_region_overlap_t {
	return C.pixman_region_contains_rectangle(region, prect)
}

fn C.pixman_region_empty(region &Pixman_region16_t) bool

pub fn pixman_region_empty(region &Pixman_region16_t) bool {
	return C.pixman_region_empty(region)
}

fn C.pixman_region_not_empty(region &Pixman_region16_t) bool

pub fn pixman_region_not_empty(region &Pixman_region16_t) bool {
	return C.pixman_region_not_empty(region)
}

fn C.pixman_region_extents(region &Pixman_region16_t) &Pixman_box16_t

pub fn pixman_region_extents(region &Pixman_region16_t) &Pixman_box16_t {
	return C.pixman_region_extents(region)
}

fn C.pixman_region_n_rects(region &Pixman_region16_t) int

pub fn pixman_region_n_rects(region &Pixman_region16_t) int {
	return C.pixman_region_n_rects(region)
}

fn C.pixman_region_rectangles(region &Pixman_region16_t, n_rects &int) &Pixman_box16_t

pub fn pixman_region_rectangles(region &Pixman_region16_t, n_rects &int) &Pixman_box16_t {
	return C.pixman_region_rectangles(region, n_rects)
}

fn C.pixman_region_equal(region1 &Pixman_region16_t, region2 &Pixman_region16_t) bool

pub fn pixman_region_equal(region1 &Pixman_region16_t, region2 &Pixman_region16_t) bool {
	return C.pixman_region_equal(region1, region2)
}

fn C.pixman_region_selfcheck(region &Pixman_region16_t) bool

pub fn pixman_region_selfcheck(region &Pixman_region16_t) bool {
	return C.pixman_region_selfcheck(region)
}

fn C.pixman_region_reset(region &Pixman_region16_t, box &Pixman_box16_t)

pub fn pixman_region_reset(region &Pixman_region16_t, box &Pixman_box16_t) {
	C.pixman_region_reset(region, box)
}

fn C.pixman_region_clear(region &Pixman_region16_t)

pub fn pixman_region_clear(region &Pixman_region16_t) {
	C.pixman_region_clear(region)
}

//
// *32 bit regions
//
type Pixman_region32_data_t = Pixman_region32_data
type Pixman_box32_t = Pixman_box32
type Pixman_rectangle32_t = Pixman_rectangle32
type Pixman_region32_t = Pixman_region32

struct Pixman_region32_data {
	size     int
	numRects int
	//  pixman_box32_t	rects[size];   in memory but not explicitly declared
}

struct Pixman_rectangle32 {
	x      int
	y      int
	width  u32
	height u32
}

struct Pixman_box32 {
	x1 int
	y1 int
	x2 int
	y2 int
}

struct Pixman_region32 {
	extents Pixman_box32_t
	data    &Pixman_region32_data_t
}

// creation/destruction
fn C.pixman_region32_init(region &Pixman_region32_t)

pub fn pixman_region32_init(region &Pixman_region32_t) {
	C.pixman_region32_init(region)
}

fn C.pixman_region32_init_rect(region &Pixman_region32_t, x int, y int, width u32, height u32)

pub fn pixman_region32_init_rect(region &Pixman_region32_t, x int, y int, width u32, height u32) {
	C.pixman_region32_init_rect(region, x, y, width, height)
}

fn C.pixman_region32_init_rects(region &Pixman_region32_t, boxes &Pixman_box32_t, count int) bool

pub fn pixman_region32_init_rects(region &Pixman_region32_t, boxes &Pixman_box32_t, count int) bool {
	return C.pixman_region32_init_rects(region, boxes, count)
}

fn C.pixman_region32_init_with_extents(region &Pixman_region32_t, extents &Pixman_box32_t)

pub fn pixman_region32_init_with_extents(region &Pixman_region32_t, extents &Pixman_box32_t) {
	C.pixman_region32_init_with_extents(region, extents)
}

fn C.pixman_region32_init_from_image(region &Pixman_region32_t, image &Pixman_image_t)

pub fn pixman_region32_init_from_image(region &Pixman_region32_t, image &Pixman_image_t) {
	C.pixman_region32_init_from_image(region, image)
}

fn C.pixman_region32_fini(region &Pixman_region32_t)

pub fn pixman_region32_fini(region &Pixman_region32_t) {
	C.pixman_region32_fini(region)
}

// manipulation
fn C.pixman_region32_translate(region &Pixman_region32_t, x int, y int)

pub fn pixman_region32_translate(region &Pixman_region32_t, x int, y int) {
	C.pixman_region32_translate(region, x, y)
}

fn C.pixman_region32_copy(dest &Pixman_region32_t, source &Pixman_region32_t) bool

pub fn pixman_region32_copy(dest &Pixman_region32_t, source &Pixman_region32_t) bool {
	return C.pixman_region32_copy(dest, source)
}

fn C.pixman_region32_intersect(new_reg &Pixman_region32_t, reg1 &Pixman_region32_t, reg2 &Pixman_region32_t) bool

pub fn pixman_region32_intersect(new_reg &Pixman_region32_t, reg1 &Pixman_region32_t, reg2 &Pixman_region32_t) bool {
	return C.pixman_region32_intersect(new_reg, reg1, reg2)
}

fn C.pixman_region32_union(new_reg &Pixman_region32_t, reg1 &Pixman_region32_t, reg2 &Pixman_region32_t) bool

pub fn pixman_region32_union(new_reg &Pixman_region32_t, reg1 &Pixman_region32_t, reg2 &Pixman_region32_t) bool {
	return C.pixman_region32_union(new_reg, reg1, reg2)
}

fn C.pixman_region32_intersect_rect(dest &Pixman_region32_t, source &Pixman_region32_t, x int, y int, width u32, height u32) bool

pub fn pixman_region32_intersect_rect(dest &Pixman_region32_t, source &Pixman_region32_t, x int, y int, width u32, height u32) bool {
	return C.pixman_region32_intersect_rect(dest, source, x, y, width, height)
}

fn C.pixman_region32_union_rect(dest &Pixman_region32_t, source &Pixman_region32_t, x int, y int, width u32, height u32) bool

pub fn pixman_region32_union_rect(dest &Pixman_region32_t, source &Pixman_region32_t, x int, y int, width u32, height u32) bool {
	return C.pixman_region32_union_rect(dest, source, x, y, width, height)
}

fn C.pixman_region32_subtract(reg_d &Pixman_region32_t, reg_m &Pixman_region32_t, reg_s &Pixman_region32_t) bool

pub fn pixman_region32_subtract(reg_d &Pixman_region32_t, reg_m &Pixman_region32_t, reg_s &Pixman_region32_t) bool {
	return C.pixman_region32_subtract(reg_d, reg_m, reg_s)
}

fn C.pixman_region32_inverse(new_reg &Pixman_region32_t, reg1 &Pixman_region32_t, inv_rect &Pixman_box32_t) bool

pub fn pixman_region32_inverse(new_reg &Pixman_region32_t, reg1 &Pixman_region32_t, inv_rect &Pixman_box32_t) bool {
	return C.pixman_region32_inverse(new_reg, reg1, inv_rect)
}

fn C.pixman_region32_contains_point(region &Pixman_region32_t, x int, y int, box &Pixman_box32_t) bool

pub fn pixman_region32_contains_point(region &Pixman_region32_t, x int, y int, box &Pixman_box32_t) bool {
	return C.pixman_region32_contains_point(region, x, y, box)
}

fn C.pixman_region32_contains_rectangle(region &Pixman_region32_t, prect &Pixman_box32_t) Pixman_region_overlap_t

pub fn pixman_region32_contains_rectangle(region &Pixman_region32_t, prect &Pixman_box32_t) Pixman_region_overlap_t {
	return C.pixman_region32_contains_rectangle(region, prect)
}

fn C.pixman_region32_empty(region &Pixman_region32_t) bool

pub fn pixman_region32_empty(region &Pixman_region32_t) bool {
	return C.pixman_region32_empty(region)
}

fn C.pixman_region32_not_empty(region &Pixman_region32_t) bool

pub fn pixman_region32_not_empty(region &Pixman_region32_t) bool {
	return C.pixman_region32_not_empty(region)
}

fn C.pixman_region32_extents(region &Pixman_region32_t) &Pixman_box32_t

pub fn pixman_region32_extents(region &Pixman_region32_t) &Pixman_box32_t {
	return C.pixman_region32_extents(region)
}

fn C.pixman_region32_n_rects(region &Pixman_region32_t) int

pub fn pixman_region32_n_rects(region &Pixman_region32_t) int {
	return C.pixman_region32_n_rects(region)
}

fn C.pixman_region32_rectangles(region &Pixman_region32_t, n_rects &int) &Pixman_box32_t

pub fn pixman_region32_rectangles(region &Pixman_region32_t, n_rects &int) &Pixman_box32_t {
	return C.pixman_region32_rectangles(region, n_rects)
}

fn C.pixman_region32_equal(region1 &Pixman_region32_t, region2 &Pixman_region32_t) bool

pub fn pixman_region32_equal(region1 &Pixman_region32_t, region2 &Pixman_region32_t) bool {
	return C.pixman_region32_equal(region1, region2)
}

fn C.pixman_region32_selfcheck(region &Pixman_region32_t) bool

pub fn pixman_region32_selfcheck(region &Pixman_region32_t) bool {
	return C.pixman_region32_selfcheck(region)
}

fn C.pixman_region32_reset(region &Pixman_region32_t, box &Pixman_box32_t)

pub fn pixman_region32_reset(region &Pixman_region32_t, box &Pixman_box32_t) {
	C.pixman_region32_reset(region, box)
}

fn C.pixman_region32_clear(region &Pixman_region32_t)

pub fn pixman_region32_clear(region &Pixman_region32_t) {
	C.pixman_region32_clear(region)
}

// Copy / Fill / Misc
fn C.pixman_blt(src_bits &u32, dst_bits &u32, src_stride int, dst_stride int, src_bpp int, dst_bpp int, src_x int, src_y int, dest_x int, dest_y int, width int, height int) bool

pub fn pixman_blt(src_bits &u32, dst_bits &u32, src_stride int, dst_stride int, src_bpp int, dst_bpp int, src_x int, src_y int, dest_x int, dest_y int, width int, height int) bool {
	return C.pixman_blt(src_bits, dst_bits, src_stride, dst_stride, src_bpp, dst_bpp,
		src_x, src_y, dest_x, dest_y, width, height)
}

fn C.pixman_fill(bits &u32, stride int, bpp int, x int, y int, width int, height int, _xor u32) bool

pub fn pixman_fill(bits &u32, stride int, bpp int, x int, y int, width int, height int, _xor u32) bool {
	return C.pixman_fill(bits, stride, bpp, x, y, width, height, _xor)
}

fn C.pixman_version() int

pub fn pixman_version() int {
	return C.pixman_version()
}

fn C.pixman_version_string() &i8

pub fn pixman_version_string() &i8 {
	return C.pixman_version_string()
}

//
// *Images
//
type Pixman_indexed_t = Pixman_indexed

struct Pixman_gradient_stop_t {
	x     int
	color Pixman_color_t
}

type Pixman_read_memory_func_t = fn (voidptr, int) u32

type Pixman_write_memory_func_t = fn (voidptr, u32, int)

type Pixman_image_destroy_func_t = fn (&Pixman_image_t, voidptr)

struct Pixman_index_type {
	x     int
	color Pixman_color_t
}

// XXX depth must be <= 8
struct Pixman_indexed {
	color bool
	rgba  [256]u32
	ent   [32768]Pixman_index_type
}

//
// *While the protocol is generous in format support, the
// *sample implementation allows only packed RGB and GBR
// *representations for data to simplify software rendering,
//
enum Pixman_format_code_t {
	// 128bpp formats
	pixman_rgba_float = 128 >> 3 << 24 | 3 << 22 | 11 << 16 | 32 >> 3 << 12 | 32 >> 3 << 8 | 32 >> 3 << 4 | 32 >> 3
	// 96bpp formats
	pixman_rgb_float = 96 >> 3 << 24 | 3 << 22 | 11 << 16 | 0 >> 3 << 12 | 32 >> 3 << 8 | 32 >> 3 << 4 | 32 >> 3
	// 32bpp formats
	pixman_a8r8g8b8    = 32 << 24 | 2 << 16 | 8 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_x8r8g8b8    = 32 << 24 | 2 << 16 | 0 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_a8b8g8r8    = 32 << 24 | 3 << 16 | 8 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_x8b8g8r8    = 32 << 24 | 3 << 16 | 0 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_b8g8r8a8    = 32 << 24 | 8 << 16 | 8 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_b8g8r8x8    = 32 << 24 | 8 << 16 | 0 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_r8g8b8a8    = 32 << 24 | 9 << 16 | 8 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_r8g8b8x8    = 32 << 24 | 9 << 16 | 0 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_x14r6g6b6   = 32 << 24 | 2 << 16 | 0 << 12 | 6 << 8 | 6 << 4 | 6
	pixman_x2r10g10b10 = 32 << 24 | 2 << 16 | 0 << 12 | 10 << 8 | 10 << 4 | 10
	pixman_a2r10g10b10 = 32 << 24 | 2 << 16 | 2 << 12 | 10 << 8 | 10 << 4 | 10
	pixman_x2b10g10r10 = 32 << 24 | 3 << 16 | 0 << 12 | 10 << 8 | 10 << 4 | 10
	pixman_a2b10g10r10 = 32 << 24 | 3 << 16 | 2 << 12 | 10 << 8 | 10 << 4 | 10
	// sRGB formats
	pixman_a8r8g8b8_s_rgb = 32 << 24 | 10 << 16 | 8 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_r8g8b8_s_rgb   = 24 << 24 | 10 << 16 | 0 << 12 | 8 << 8 | 8 << 4 | 8
	// 24bpp formats
	pixman_r8g8b8 = 24 << 24 | 2 << 16 | 0 << 12 | 8 << 8 | 8 << 4 | 8
	pixman_b8g8r8 = 24 << 24 | 3 << 16 | 0 << 12 | 8 << 8 | 8 << 4 | 8
	// 16bpp formats
	pixman_r5g6b5   = 16 << 24 | 2 << 16 | 0 << 12 | 5 << 8 | 6 << 4 | 5
	pixman_b5g6r5   = 16 << 24 | 3 << 16 | 0 << 12 | 5 << 8 | 6 << 4 | 5
	pixman_a1r5g5b5 = 16 << 24 | 2 << 16 | 1 << 12 | 5 << 8 | 5 << 4 | 5
	pixman_x1r5g5b5 = 16 << 24 | 2 << 16 | 0 << 12 | 5 << 8 | 5 << 4 | 5
	pixman_a1b5g5r5 = 16 << 24 | 3 << 16 | 1 << 12 | 5 << 8 | 5 << 4 | 5
	pixman_x1b5g5r5 = 16 << 24 | 3 << 16 | 0 << 12 | 5 << 8 | 5 << 4 | 5
	pixman_a4r4g4b4 = 16 << 24 | 2 << 16 | 4 << 12 | 4 << 8 | 4 << 4 | 4
	pixman_x4r4g4b4 = 16 << 24 | 2 << 16 | 0 << 12 | 4 << 8 | 4 << 4 | 4
	pixman_a4b4g4r4 = 16 << 24 | 3 << 16 | 4 << 12 | 4 << 8 | 4 << 4 | 4
	pixman_x4b4g4r4 = 16 << 24 | 3 << 16 | 0 << 12 | 4 << 8 | 4 << 4 | 4
	// 8bpp formats
	pixman_a8       = 8 << 24 | 1 << 16 | 8 << 12 | 0 << 8 | 0 << 4 | 0
	pixman_r3g3b2   = 8 << 24 | 2 << 16 | 0 << 12 | 3 << 8 | 3 << 4 | 2
	pixman_b2g3r3   = 8 << 24 | 3 << 16 | 0 << 12 | 3 << 8 | 3 << 4 | 2
	pixman_a2r2g2b2 = 8 << 24 | 2 << 16 | 2 << 12 | 2 << 8 | 2 << 4 | 2
	pixman_a2b2g2r2 = 8 << 24 | 3 << 16 | 2 << 12 | 2 << 8 | 2 << 4 | 2
	pixman_c8       = 8 << 24 | 4 << 16 | 0 << 12 | 0 << 8 | 0 << 4 | 0
	pixman_g8       = 8 << 24 | 5 << 16 | 0 << 12 | 0 << 8 | 0 << 4 | 0
	pixman_x4a4     = 8 << 24 | 1 << 16 | 4 << 12 | 0 << 8 | 0 << 4 | 0
	pixman_x4c4     = 8 << 24 | 4 << 16 | 0 << 12 | 0 << 8 | 0 << 4 | 0
	pixman_x4g4     = 8 << 24 | 5 << 16 | 0 << 12 | 0 << 8 | 0 << 4 | 0
	// 4bpp formats
	pixman_a4       = 4 << 24 | 1 << 16 | 4 << 12 | 0 << 8 | 0 << 4 | 0
	pixman_r1g2b1   = 4 << 24 | 2 << 16 | 0 << 12 | 1 << 8 | 2 << 4 | 1
	pixman_b1g2r1   = 4 << 24 | 3 << 16 | 0 << 12 | 1 << 8 | 2 << 4 | 1
	pixman_a1r1g1b1 = 4 << 24 | 2 << 16 | 1 << 12 | 1 << 8 | 1 << 4 | 1
	pixman_a1b1g1r1 = 4 << 24 | 3 << 16 | 1 << 12 | 1 << 8 | 1 << 4 | 1
	pixman_c4       = 4 << 24 | 4 << 16 | 0 << 12 | 0 << 8 | 0 << 4 | 0
	pixman_g4       = 4 << 24 | 5 << 16 | 0 << 12 | 0 << 8 | 0 << 4 | 0
	// 1bpp formats
	pixman_a1 = 1 << 24 | 1 << 16 | 1 << 12 | 0 << 8 | 0 << 4 | 0
	pixman_g1 = 1 << 24 | 5 << 16 | 0 << 12 | 0 << 8 | 0 << 4 | 0
	// YUV formats
	pixman_yuy2 = 16 << 24 | 6 << 16 | 0 << 12 | 0 << 8 | 0 << 4 | 0
	pixman_yv12 = 12 << 24 | 7 << 16 | 0 << 12 | 0 << 8 | 0 << 4 | 0
}

// Querying supported format values.
fn C.pixman_format_supported_destination(format Pixman_format_code_t) bool

pub fn pixman_format_supported_destination(format Pixman_format_code_t) bool {
	return C.pixman_format_supported_destination(format)
}

fn C.pixman_format_supported_source(format Pixman_format_code_t) bool

pub fn pixman_format_supported_source(format Pixman_format_code_t) bool {
	return C.pixman_format_supported_source(format)
}

// Constructors
fn C.pixman_image_create_solid_fill(color &Pixman_color_t) &Pixman_image_t

pub fn pixman_image_create_solid_fill(color &Pixman_color_t) &Pixman_image_t {
	return C.pixman_image_create_solid_fill(color)
}

fn C.pixman_image_create_linear_gradient(p1 &Pixman_point_fixed_t, p2 &Pixman_point_fixed_t, stops &Pixman_gradient_stop_t, n_stops int) &Pixman_image_t

pub fn pixman_image_create_linear_gradient(p1 &Pixman_point_fixed_t, p2 &Pixman_point_fixed_t, stops &Pixman_gradient_stop_t, n_stops int) &Pixman_image_t {
	return C.pixman_image_create_linear_gradient(p1, p2, stops, n_stops)
}

fn C.pixman_image_create_radial_gradient(inner &Pixman_point_fixed_t, outer &Pixman_point_fixed_t, inner_radius int, outer_radius int, stops &Pixman_gradient_stop_t, n_stops int) &Pixman_image_t

pub fn pixman_image_create_radial_gradient(inner &Pixman_point_fixed_t, outer &Pixman_point_fixed_t, inner_radius int, outer_radius int, stops &Pixman_gradient_stop_t, n_stops int) &Pixman_image_t {
	return C.pixman_image_create_radial_gradient(inner, outer, inner_radius, outer_radius,
		stops, n_stops)
}

fn C.pixman_image_create_conical_gradient(center &Pixman_point_fixed_t, angle int, stops &Pixman_gradient_stop_t, n_stops int) &Pixman_image_t

pub fn pixman_image_create_conical_gradient(center &Pixman_point_fixed_t, angle int, stops &Pixman_gradient_stop_t, n_stops int) &Pixman_image_t {
	return C.pixman_image_create_conical_gradient(center, angle, stops, n_stops)
}

fn C.pixman_image_create_bits(format Pixman_format_code_t, width int, height int, bits &u32, rowstride_bytes int) &Pixman_image_t

pub fn pixman_image_create_bits(format Pixman_format_code_t, width int, height int, bits &u32, rowstride_bytes int) &Pixman_image_t {
	return C.pixman_image_create_bits(format, width, height, bits, rowstride_bytes)
}

fn C.pixman_image_create_bits_no_clear(format Pixman_format_code_t, width int, height int, bits &u32, rowstride_bytes int) &Pixman_image_t

pub fn pixman_image_create_bits_no_clear(format Pixman_format_code_t, width int, height int, bits &u32, rowstride_bytes int) &Pixman_image_t {
	return C.pixman_image_create_bits_no_clear(format, width, height, bits, rowstride_bytes)
}

// Destructor
fn C.pixman_image_ref(image &Pixman_image_t) &Pixman_image_t

pub fn pixman_image_ref(image &Pixman_image_t) &Pixman_image_t {
	return C.pixman_image_ref(image)
}

fn C.pixman_image_unref(image &Pixman_image_t) bool

pub fn pixman_image_unref(image &Pixman_image_t) bool {
	return C.pixman_image_unref(image)
}

fn C.pixman_image_set_destroy_function(image &Pixman_image_t, function Pixman_image_destroy_func_t, data voidptr)

pub fn pixman_image_set_destroy_function(image &Pixman_image_t, function Pixman_image_destroy_func_t, data voidptr) {
	C.pixman_image_set_destroy_function(image, function, data)
}

fn C.pixman_image_get_destroy_data(image &Pixman_image_t) voidptr

pub fn pixman_image_get_destroy_data(image &Pixman_image_t) voidptr {
	return C.pixman_image_get_destroy_data(image)
}

// Set properties
fn C.pixman_image_set_clip_region(image &Pixman_image_t, region &Pixman_region16_t) bool

pub fn pixman_image_set_clip_region(image &Pixman_image_t, region &Pixman_region16_t) bool {
	return C.pixman_image_set_clip_region(image, region)
}

fn C.pixman_image_set_clip_region32(image &Pixman_image_t, region &Pixman_region32_t) bool

pub fn pixman_image_set_clip_region32(image &Pixman_image_t, region &Pixman_region32_t) bool {
	return C.pixman_image_set_clip_region32(image, region)
}

fn C.pixman_image_set_has_client_clip(image &Pixman_image_t, clien_clip bool)

pub fn pixman_image_set_has_client_clip(image &Pixman_image_t, clien_clip bool) {
	C.pixman_image_set_has_client_clip(image, clien_clip)
}

fn C.pixman_image_set_transform(image &Pixman_image_t, transform &Pixman_transform_t) bool

pub fn pixman_image_set_transform(image &Pixman_image_t, transform &Pixman_transform_t) bool {
	return C.pixman_image_set_transform(image, transform)
}

fn C.pixman_image_set_repeat(image &Pixman_image_t, repeat Pixman_repeat_t)

pub fn pixman_image_set_repeat(image &Pixman_image_t, repeat Pixman_repeat_t) {
	C.pixman_image_set_repeat(image, repeat)
}

fn C.pixman_image_set_dither(image &Pixman_image_t, dither Pixman_dither_t)

pub fn pixman_image_set_dither(image &Pixman_image_t, dither Pixman_dither_t) {
	C.pixman_image_set_dither(image, dither)
}

fn C.pixman_image_set_dither_offset(image &Pixman_image_t, offset_x int, offset_y int)

pub fn pixman_image_set_dither_offset(image &Pixman_image_t, offset_x int, offset_y int) {
	C.pixman_image_set_dither_offset(image, offset_x, offset_y)
}

fn C.pixman_image_set_filter(image &Pixman_image_t, filter Pixman_filter_t, filter_params &int, n_filter_params int) bool

pub fn pixman_image_set_filter(image &Pixman_image_t, filter Pixman_filter_t, filter_params &int, n_filter_params int) bool {
	return C.pixman_image_set_filter(image, filter, filter_params, n_filter_params)
}

fn C.pixman_image_set_source_clipping(image &Pixman_image_t, source_clipping bool)

pub fn pixman_image_set_source_clipping(image &Pixman_image_t, source_clipping bool) {
	C.pixman_image_set_source_clipping(image, source_clipping)
}

fn C.pixman_image_set_alpha_map(image &Pixman_image_t, alpha_map &Pixman_image_t, x i16, y i16)

pub fn pixman_image_set_alpha_map(image &Pixman_image_t, alpha_map &Pixman_image_t, x i16, y i16) {
	C.pixman_image_set_alpha_map(image, alpha_map, x, y)
}

fn C.pixman_image_set_component_alpha(image &Pixman_image_t, component_alpha bool)

pub fn pixman_image_set_component_alpha(image &Pixman_image_t, component_alpha bool) {
	C.pixman_image_set_component_alpha(image, component_alpha)
}

fn C.pixman_image_get_component_alpha(image &Pixman_image_t) bool

pub fn pixman_image_get_component_alpha(image &Pixman_image_t) bool {
	return C.pixman_image_get_component_alpha(image)
}

fn C.pixman_image_set_accessors(image &Pixman_image_t, read_func Pixman_read_memory_func_t, write_func Pixman_write_memory_func_t)

pub fn pixman_image_set_accessors(image &Pixman_image_t, read_func Pixman_read_memory_func_t, write_func Pixman_write_memory_func_t) {
	C.pixman_image_set_accessors(image, read_func, write_func)
}

fn C.pixman_image_set_indexed(image &Pixman_image_t, indexed &Pixman_indexed_t)

pub fn pixman_image_set_indexed(image &Pixman_image_t, indexed &Pixman_indexed_t) {
	C.pixman_image_set_indexed(image, indexed)
}

fn C.pixman_image_get_data(image &Pixman_image_t) &u32

pub fn pixman_image_get_data(image &Pixman_image_t) &u32 {
	return C.pixman_image_get_data(image)
}

fn C.pixman_image_get_width(image &Pixman_image_t) int

pub fn pixman_image_get_width(image &Pixman_image_t) int {
	return C.pixman_image_get_width(image)
}

fn C.pixman_image_get_height(image &Pixman_image_t) int

pub fn pixman_image_get_height(image &Pixman_image_t) int {
	return C.pixman_image_get_height(image)
}

fn C.pixman_image_get_stride(image &Pixman_image_t) int

pub fn pixman_image_get_stride(image &Pixman_image_t) int {
	return C.pixman_image_get_stride(image)
}

// in bytes
fn C.pixman_image_get_depth(image &Pixman_image_t) int

pub fn pixman_image_get_depth(image &Pixman_image_t) int {
	return C.pixman_image_get_depth(image)
}

fn C.pixman_image_get_format(image &Pixman_image_t) Pixman_format_code_t

pub fn pixman_image_get_format(image &Pixman_image_t) Pixman_format_code_t {
	return C.pixman_image_get_format(image)
}

enum Pixman_kernel_t {
	pixman_kernel_impulse
	pixman_kernel_box
	pixman_kernel_linear
	pixman_kernel_cubic
	pixman_kernel_gaussian
	pixman_kernel_lanczos_2
	pixman_kernel_lanczos_3
	pixman_kernel_lanczos_3_stretched
	// Jim Blinn's 'nice' filter
}

// Create the parameter list for a SEPARABLE_CONVOLUTION filter
// *with the given kernels and scale parameters.
//
fn C.pixman_filter_create_separable_convolution(n_values &int, scale_x int, scale_y int, reconstruct_x Pixman_kernel_t, reconstruct_y Pixman_kernel_t, sample_x Pixman_kernel_t, sample_y Pixman_kernel_t, subsample_bits_x int, subsample_bits_y int) &int

pub fn pixman_filter_create_separable_convolution(n_values &int, scale_x int, scale_y int, reconstruct_x Pixman_kernel_t, reconstruct_y Pixman_kernel_t, sample_x Pixman_kernel_t, sample_y Pixman_kernel_t, subsample_bits_x int, subsample_bits_y int) &int {
	return C.pixman_filter_create_separable_convolution(n_values, scale_x, scale_y, reconstruct_x,
		reconstruct_y, sample_x, sample_y, subsample_bits_x, subsample_bits_y)
}

fn C.pixman_image_fill_rectangles(op Pixman_op_t, image &Pixman_image_t, color &Pixman_color_t, n_rects int, rects &Pixman_rectangle16_t) bool

pub fn pixman_image_fill_rectangles(op Pixman_op_t, image &Pixman_image_t, color &Pixman_color_t, n_rects int, rects &Pixman_rectangle16_t) bool {
	return C.pixman_image_fill_rectangles(op, image, color, n_rects, rects)
}

fn C.pixman_image_fill_boxes(op Pixman_op_t, dest &Pixman_image_t, color &Pixman_color_t, n_boxes int, boxes &Pixman_box32_t) bool

pub fn pixman_image_fill_boxes(op Pixman_op_t, dest &Pixman_image_t, color &Pixman_color_t, n_boxes int, boxes &Pixman_box32_t) bool {
	return C.pixman_image_fill_boxes(op, dest, color, n_boxes, boxes)
}

// Composite
fn C.pixman_compute_composite_region(region &Pixman_region16_t, src_image &Pixman_image_t, mask_image &Pixman_image_t, dest_image &Pixman_image_t, src_x i16, src_y i16, mask_x i16, mask_y i16, dest_x i16, dest_y i16, width u16, height u16) bool

pub fn pixman_compute_composite_region(region &Pixman_region16_t, src_image &Pixman_image_t, mask_image &Pixman_image_t, dest_image &Pixman_image_t, src_x i16, src_y i16, mask_x i16, mask_y i16, dest_x i16, dest_y i16, width u16, height u16) bool {
	return C.pixman_compute_composite_region(region, src_image, mask_image, dest_image,
		src_x, src_y, mask_x, mask_y, dest_x, dest_y, width, height)
}

fn C.pixman_image_composite(op Pixman_op_t, src &Pixman_image_t, mask &Pixman_image_t, dest &Pixman_image_t, src_x i16, src_y i16, mask_x i16, mask_y i16, dest_x i16, dest_y i16, width u16, height u16)

pub fn pixman_image_composite(op Pixman_op_t, src &Pixman_image_t, mask &Pixman_image_t, dest &Pixman_image_t, src_x i16, src_y i16, mask_x i16, mask_y i16, dest_x i16, dest_y i16, width u16, height u16) {
	C.pixman_image_composite(op, src, mask, dest, src_x, src_y, mask_x, mask_y, dest_x,
		dest_y, width, height)
}

fn C.pixman_image_composite32(op Pixman_op_t, src &Pixman_image_t, mask &Pixman_image_t, dest &Pixman_image_t, src_x int, src_y int, mask_x int, mask_y int, dest_x int, dest_y int, width int, height int)

pub fn pixman_image_composite32(op Pixman_op_t, src &Pixman_image_t, mask &Pixman_image_t, dest &Pixman_image_t, src_x int, src_y int, mask_x int, mask_y int, dest_x int, dest_y int, width int, height int) {
	C.pixman_image_composite32(op, src, mask, dest, src_x, src_y, mask_x, mask_y, dest_x,
		dest_y, width, height)
}

// Executive Summary: This function is a no-op that only exists
// *for historical reasons.
// * *There used to be a bug in the X server where it would rely on
// *out-of-bounds accesses when it was asked to composite with a
// *window as the source. It would create a pixman image pointing
// *to some bogus position in memory, but then set a clip region
// *to the position where the actual bits were.
// * *Due to a bug in old versions of pixman, where it would not clip
// *against the image bounds when a clip region was set, this would
// *actually work. So when the pixman bug was fixed, a workaround was
// *added to allow certain out-of-bound accesses. This function disabled
// *those workarounds.
// * *Since 0.21.2, pixman doesn't do these workarounds anymore, so now this
// *function is a no-op.
//
fn C.pixman_disable_out_of_bounds_workaround()

pub fn pixman_disable_out_of_bounds_workaround() {
	C.pixman_disable_out_of_bounds_workaround()
}

//
// *Glyphs
//
struct Pixman_glyph_cache_t {}

struct Pixman_glyph_t {
	x     int
	y     int
	glyph voidptr
}

fn C.pixman_glyph_cache_create() &Pixman_glyph_cache_t

pub fn pixman_glyph_cache_create() &Pixman_glyph_cache_t {
	return C.pixman_glyph_cache_create()
}

fn C.pixman_glyph_cache_destroy(cache &Pixman_glyph_cache_t)

pub fn pixman_glyph_cache_destroy(cache &Pixman_glyph_cache_t) {
	C.pixman_glyph_cache_destroy(cache)
}

fn C.pixman_glyph_cache_freeze(cache &Pixman_glyph_cache_t)

pub fn pixman_glyph_cache_freeze(cache &Pixman_glyph_cache_t) {
	C.pixman_glyph_cache_freeze(cache)
}

fn C.pixman_glyph_cache_thaw(cache &Pixman_glyph_cache_t)

pub fn pixman_glyph_cache_thaw(cache &Pixman_glyph_cache_t) {
	C.pixman_glyph_cache_thaw(cache)
}

fn C.pixman_glyph_cache_lookup(cache &Pixman_glyph_cache_t, font_key voidptr, glyph_key voidptr) voidptr

pub fn pixman_glyph_cache_lookup(cache &Pixman_glyph_cache_t, font_key voidptr, glyph_key voidptr) voidptr {
	return C.pixman_glyph_cache_lookup(cache, font_key, glyph_key)
}

fn C.pixman_glyph_cache_insert(cache &Pixman_glyph_cache_t, font_key voidptr, glyph_key voidptr, origin_x int, origin_y int, glyph_image &Pixman_image_t) voidptr

pub fn pixman_glyph_cache_insert(cache &Pixman_glyph_cache_t, font_key voidptr, glyph_key voidptr, origin_x int, origin_y int, glyph_image &Pixman_image_t) voidptr {
	return C.pixman_glyph_cache_insert(cache, font_key, glyph_key, origin_x, origin_y,
		glyph_image)
}

fn C.pixman_glyph_cache_remove(cache &Pixman_glyph_cache_t, font_key voidptr, glyph_key voidptr)

pub fn pixman_glyph_cache_remove(cache &Pixman_glyph_cache_t, font_key voidptr, glyph_key voidptr) {
	C.pixman_glyph_cache_remove(cache, font_key, glyph_key)
}

fn C.pixman_glyph_get_extents(cache &Pixman_glyph_cache_t, n_glyphs int, glyphs &Pixman_glyph_t, extents &Pixman_box32_t)

pub fn pixman_glyph_get_extents(cache &Pixman_glyph_cache_t, n_glyphs int, glyphs &Pixman_glyph_t, extents &Pixman_box32_t) {
	C.pixman_glyph_get_extents(cache, n_glyphs, glyphs, extents)
}

fn C.pixman_glyph_get_mask_format(cache &Pixman_glyph_cache_t, n_glyphs int, glyphs &Pixman_glyph_t) Pixman_format_code_t

pub fn pixman_glyph_get_mask_format(cache &Pixman_glyph_cache_t, n_glyphs int, glyphs &Pixman_glyph_t) Pixman_format_code_t {
	return C.pixman_glyph_get_mask_format(cache, n_glyphs, glyphs)
}

fn C.pixman_composite_glyphs(op Pixman_op_t, src &Pixman_image_t, dest &Pixman_image_t, mask_format Pixman_format_code_t, src_x int, src_y int, mask_x int, mask_y int, dest_x int, dest_y int, width int, height int, cache &Pixman_glyph_cache_t, n_glyphs int, glyphs &Pixman_glyph_t)

pub fn pixman_composite_glyphs(op Pixman_op_t, src &Pixman_image_t, dest &Pixman_image_t, mask_format Pixman_format_code_t, src_x int, src_y int, mask_x int, mask_y int, dest_x int, dest_y int, width int, height int, cache &Pixman_glyph_cache_t, n_glyphs int, glyphs &Pixman_glyph_t) {
	C.pixman_composite_glyphs(op, src, dest, mask_format, src_x, src_y, mask_x, mask_y,
		dest_x, dest_y, width, height, cache, n_glyphs, glyphs)
}

fn C.pixman_composite_glyphs_no_mask(op Pixman_op_t, src &Pixman_image_t, dest &Pixman_image_t, src_x int, src_y int, dest_x int, dest_y int, cache &Pixman_glyph_cache_t, n_glyphs int, glyphs &Pixman_glyph_t)

pub fn pixman_composite_glyphs_no_mask(op Pixman_op_t, src &Pixman_image_t, dest &Pixman_image_t, src_x int, src_y int, dest_x int, dest_y int, cache &Pixman_glyph_cache_t, n_glyphs int, glyphs &Pixman_glyph_t) {
	C.pixman_composite_glyphs_no_mask(op, src, dest, src_x, src_y, dest_x, dest_y, cache,
		n_glyphs, glyphs)
}

//
// *Trapezoids
//
type Pixman_edge_t = Pixman_edge
type Pixman_trapezoid_t = Pixman_trapezoid
type Pixman_trap_t = Pixman_trap
type Pixman_span_fix_t = Pixman_span_fix
type Pixman_triangle_t = Pixman_triangle

//
// *An edge structure.  This represents a single polygon edge
// *and can be quickly stepped across small or large gaps in the
// *sample grid
//
struct Pixman_edge {
	x           int
	e           int
	stepx       int
	signdx      int
	dy          int
	dx          int
	stepx_small int
	stepx_big   int
	dx_small    int
	dx_big      int
}

struct Pixman_trapezoid {
	top    int
	bottom int
	left   Pixman_line_fixed_t
	right  Pixman_line_fixed_t
}

struct Pixman_triangle {
	p1 Pixman_point_fixed_t
	p2 Pixman_point_fixed_t
	p3 Pixman_point_fixed_t
}

// whether 't' is a well defined not obviously empty trapezoid
struct Pixman_span_fix {
	l int
	r int
	y int
}

struct Pixman_trap {
	top Pixman_span_fix_t
	bot Pixman_span_fix_t
}

fn C.pixman_sample_ceil_y(y int, bpp int) int

pub fn pixman_sample_ceil_y(y int, bpp int) int {
	return C.pixman_sample_ceil_y(y, bpp)
}

fn C.pixman_sample_floor_y(y int, bpp int) int

pub fn pixman_sample_floor_y(y int, bpp int) int {
	return C.pixman_sample_floor_y(y, bpp)
}

fn C.pixman_edge_step(e &Pixman_edge_t, n int)

pub fn pixman_edge_step(e &Pixman_edge_t, n int) {
	C.pixman_edge_step(e, n)
}

fn C.pixman_edge_init(e &Pixman_edge_t, bpp int, y_start int, x_top int, y_top int, x_bot int, y_bot int)

pub fn pixman_edge_init(e &Pixman_edge_t, bpp int, y_start int, x_top int, y_top int, x_bot int, y_bot int) {
	C.pixman_edge_init(e, bpp, y_start, x_top, y_top, x_bot, y_bot)
}

fn C.pixman_line_fixed_edge_init(e &Pixman_edge_t, bpp int, y int, line &Pixman_line_fixed_t, x_off int, y_off int)

pub fn pixman_line_fixed_edge_init(e &Pixman_edge_t, bpp int, y int, line &Pixman_line_fixed_t, x_off int, y_off int) {
	C.pixman_line_fixed_edge_init(e, bpp, y, line, x_off, y_off)
}

fn C.pixman_rasterize_edges(image &Pixman_image_t, l &Pixman_edge_t, r &Pixman_edge_t, t int, b int)

pub fn pixman_rasterize_edges(image &Pixman_image_t, l &Pixman_edge_t, r &Pixman_edge_t, t int, b int) {
	C.pixman_rasterize_edges(image, l, r, t, b)
}

fn C.pixman_add_traps(image &Pixman_image_t, x_off i16, y_off i16, ntrap int, traps &Pixman_trap_t)

pub fn pixman_add_traps(image &Pixman_image_t, x_off i16, y_off i16, ntrap int, traps &Pixman_trap_t) {
	C.pixman_add_traps(image, x_off, y_off, ntrap, traps)
}

fn C.pixman_add_trapezoids(image &Pixman_image_t, x_off i16, y_off int, ntraps int, traps &Pixman_trapezoid_t)

pub fn pixman_add_trapezoids(image &Pixman_image_t, x_off i16, y_off int, ntraps int, traps &Pixman_trapezoid_t) {
	C.pixman_add_trapezoids(image, x_off, y_off, ntraps, traps)
}

fn C.pixman_rasterize_trapezoid(image &Pixman_image_t, trap &Pixman_trapezoid_t, x_off int, y_off int)

pub fn pixman_rasterize_trapezoid(image &Pixman_image_t, trap &Pixman_trapezoid_t, x_off int, y_off int) {
	C.pixman_rasterize_trapezoid(image, trap, x_off, y_off)
}

fn C.pixman_composite_trapezoids(op Pixman_op_t, src &Pixman_image_t, dst &Pixman_image_t, mask_format Pixman_format_code_t, x_src int, y_src int, x_dst int, y_dst int, n_traps int, traps &Pixman_trapezoid_t)

pub fn pixman_composite_trapezoids(op Pixman_op_t, src &Pixman_image_t, dst &Pixman_image_t, mask_format Pixman_format_code_t, x_src int, y_src int, x_dst int, y_dst int, n_traps int, traps &Pixman_trapezoid_t) {
	C.pixman_composite_trapezoids(op, src, dst, mask_format, x_src, y_src, x_dst, y_dst,
		n_traps, traps)
}

fn C.pixman_composite_triangles(op Pixman_op_t, src &Pixman_image_t, dst &Pixman_image_t, mask_format Pixman_format_code_t, x_src int, y_src int, x_dst int, y_dst int, n_tris int, tris &Pixman_triangle_t)

pub fn pixman_composite_triangles(op Pixman_op_t, src &Pixman_image_t, dst &Pixman_image_t, mask_format Pixman_format_code_t, x_src int, y_src int, x_dst int, y_dst int, n_tris int, tris &Pixman_triangle_t) {
	C.pixman_composite_triangles(op, src, dst, mask_format, x_src, y_src, x_dst, y_dst,
		n_tris, tris)
}

fn C.pixman_add_triangles(image &Pixman_image_t, x_off int, y_off int, n_tris int, tris &Pixman_triangle_t)

pub fn pixman_add_triangles(image &Pixman_image_t, x_off int, y_off int, n_tris int, tris &Pixman_triangle_t) {
	C.pixman_add_triangles(image, x_off, y_off, n_tris, tris)
}

// PIXMAN_H__

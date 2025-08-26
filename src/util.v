module src

fn ptr_eq[T](a T, b T) bool {
	return unsafe { i64(a) - i64(b) == 0 }
}

fn is_nullptr[T](val &T) bool {
	return unsafe { val == nil }
}

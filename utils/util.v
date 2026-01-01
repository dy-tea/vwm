module utils

fn C.strcmp(s1 &u8, s2 &u8) int

pub fn ptr_eq[T](a T, b T) bool {
	return unsafe { i64(a) - i64(b) == 0 }
}

pub fn cstr_eq(a &u8, b &u8) bool {
	return C.strcmp(a, b) == 0
}

pub fn is_nullptr[T](val &T) bool {
	return unsafe { val == nil }
}

pub fn offsetof[T](member_name string) int {
	tmp := &T{}
	$if T is $struct {
		$for field in T.fields {
			if field.name == member_name {
				access := int(voidptr(&tmp.$(field.name)))
				return access - int(tmp)
			}
		}
	} $else {
		$compile_error('offsetof only accepts struct types')
	}
	return 0
}

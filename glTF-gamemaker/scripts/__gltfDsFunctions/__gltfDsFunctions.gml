// Feather disable all

/// function for helping to reverse lookup (unique) values of an array, usually an array of strings
function __gltfBimap(arr, ret = { }) {
	for (var i = 0; i < array_length(arr); i++) {
		var key = string(arr[i]);
		ret[$ key] = i;
	}
	return ret;
}

/// shallow copy values from src struct into dest
function __gltfStructCopy(dest, src) {
	var names = variable_struct_get_names(src);
	var i = 0; repeat(array_length(names)) {
		var n = names[i++];
		dest[$ n] = src[$ n] ?? dest[$ n];
	}
}

/// return last element of an array or undefined if empty
/// it is literally array_last
/// @deprecated
function __gltfArrayLast(arr=[]) {
	gml_pragma("forceinline");
	var n = array_length(arr);
	return (n>0) ? arr[array_length(arr)-1] : undefined;
}

/// efficiently store booleans without arrays
function gltfBitVector() constructor {
	static NBITS = 32;
	
	arr = [];
	len = 0;
	
	static set = function(bit, val=1) {
		var iarr = bit div NBITS
		bit = bit % NBITS;
		while (len <= iarr) {
			array_push(arr, 0);
			len++;
		}
		var d = arr[iarr];
		if (val == 0) {
			arr[iarr] = d & ~(1 << bit);
		}
		else {
			arr[iarr] = d | (1 << bit);
		}
	};
	
	static get = function(bit) {
		var iarr = bit div NBITS;
		bit = bit % NBITS;
		while (len <= iarr) {
			array_push(arr, 0);
			len++;
		}
		var d = arr[iarr];
		return (1 & (d >> bit));
	};
	
	static clear = function() {
		array_resize(arr, 0);
		len = 0;
	};
	
	static toString = function() {
		return string(arr);
	};
}

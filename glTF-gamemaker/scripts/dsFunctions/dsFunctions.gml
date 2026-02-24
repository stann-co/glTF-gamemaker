/// function for helping to reverse lookup values of an array, usually an array of strings
function bimap(arr, ret = { }) {
	for (var i = 0; i < array_length(arr); i++) {
		var key = string(arr[i]);
		//if (!is_undefined(key)) {
			//debugPrint(string("{0}: {1}", i, key));
			ret[$ key] = i;
		//}
	}
	return ret;
}

/// func should be a function of (i,arr[i])
function foreach(arr, func) {
	var n = array_length(arr);
	for (var i = 0; i < n; i++) {
		func(i, arr);
	}
}

/// light copy values from src struct into dest
function structCopy(dest, src) {
	var names = variable_struct_get_names(src);
	var i = 0; repeat(array_length(names)) {
		var n = names[i++];
		dest[$ n] = src[$ n] ?? dest[$ n];
	}
}

// no idea if this works
//function structForeach(struct, func) {
//	var names = variable_struct_get_names(struct);
//	var n = array_length(names);
//	for (var i = 0; i < n; i++) {
//		func(names[i], struct);
//	}
//}

/// return last element of an array or undefined if empty
function arrayLast(arr=[]) {
	gml_pragma("forceinline");
	var n = array_length(arr);
	return (n>0) ? arr[array_length(arr)-1] : undefined;
}

// Feather disable all

function __gltfVec3(_x=0, _y=0, _z=0) : __gltfVec4(_x, _y, _z) constructor { }

/**
 * Function Description
 * @param {real} [_x]=0 Description
 * @param {real} [_y]=0 Description
 * @param {real} [_z]=0 Description
 * @param {real} [_w]=1 Description
 */
function __gltfVec4(_x=0, _y=0, _z=0, _w=1) constructor {
	x = _x;
	y = _y;
	z = _z;
	w = _w;
	
	/// checks if two vectors have the same values
	static compare = function(v) {
		return (x == v.x && y == v.y && z == v.z && w == v.w);
	};
	
	/// get length of vector
	static length = function() {
		return sqrt(x*x + y*y + z*z + w*w);
	};
	
	/// length but ignore the w component
	static length3 = function() {
		return sqrt(x*x + y*y + z*z);
	};
	
	/// vector component addition without creating a new vec4
	static translate = function(v) {
		x += v.x;
		y += v.y;
		z += v.z;
		w += v.w;
		return self;
	};
	
	/// scalar multiply a vector without creating a new vec4
	static scale = function(s) {
		x *= s;
		y *= s;
		z *= s;
		w *= s;
		return self;
	};
	
	/// normalise vector without creating a new vec4
	static normalise = function() {
		return scale(1 / length());
	};
	
	/// make array [ x, y, z, w ]
	static toArray = function() {
		return [ x, y, z, w ];
	};
	
	/// create duplicate vec4 
	static duplicate = function() {
		return new __gltfVec4(x, y, z, w);
	};
	
	/// toString
	static toString = function() {
		return $"({x}, {y}, {z}, {w})";
	};
}

/// axis aligned bounding box
function __gltfAabb(_v1, _v2) constructor {
	v1 = _v1;
	v2 = _v2;
	
	/// expand hitbox size with new min and max vectors, but does extra steps to make sure
	/// v1 has lower values than v2
	static expand = function(_v1, _v2) {
		v1 = __gltfVecComponentMin(v1, _v1);
		v1 = __gltfVecComponentMin(v1, _v2);
		v2 = __gltfVecComponentMax(v2, _v2);
		v2 = __gltfVecComponentMax(v2, _v1);
		return self;
	};
	
	expand(v1, v2); // ensure v1 < v2
	
	static size = function() {
		var result = __gltfVecSubtract(v2, v1);
		result.w = 0;
		return result;
	};
	
	static midPoint = function() {
		return new __gltfVec4(
			(v1.x+v2.x)/2,
			(v1.y+v2.y)/2,
			(v1.z+v2.z)/2
			// leaving w as default (1) since u are usually doing this with a vec3 with position
		);
	};
}

/// add two vectors and return result as new vector
function __gltfVecAdd(a, b) {
	gml_pragma("forceinline");
	return new __gltfVec4(a.x+b.x, a.y+b.y, a.z+b.z, a.w+b.w);
}

/// subtract two vectors and return result as new vector
function __gltfVecSubtract(a, b) {
	gml_pragma("forceinline");
	return new __gltfVec4(a.x-b.x, a.y-b.y, a.z-b.z, a.w-b.w);
}

/// returns lowest value of a vectors x,y,z,w
function __gltfVecComponentMin(a, b) {
	gml_pragma("forceinline");
	return new __gltfVec4(
		min(a.x, b.x),
		min(a.y, b.y),
		min(a.z, b.z),
		min(a.w, b.w)
	);
}

/// returns highest value of a vectors x,y,z,w
function __gltfVecComponentMax(a, b) {
	gml_pragma("forceinline");
	return new __gltfVec4(
		max(a.x, b.x),
		max(a.y, b.y),
		max(a.z, b.z),
		max(a.w, b.w)
	);
}

/// add an array of vectors together, component wise, and return the result as a new vector
function __gltfVecAddSeries(vecs = [ ]) {
	gml_pragma("forceinline");
	var result = new __gltfVec4(0, 0, 0, 0);
	var i = 0; repeat(array_length(vecs)) {
		result.translate(vecs[i++]);
	}
	return result;
}

/*
0	4	8	12
1	5	9	13
2	6	10	14
3	7	11	15
*/

/// get value of matrix at [row,col], coordinates are 0-indexed
function __gltfMatRead(m, row, col) {
	gml_pragma("forceinline");
	return m[row + col * 4];
}

/// write to a matrix at [row,col]
function __gltfMatWrite(m, row, col, value) {
	gml_pragma("forceinline");
	m[row + col * 4] = value;
}

/// return a column of a matrix as a vector
function __gltfMatReadColumn(m, col) {
	gml_pragma("forceinline");
	return new __gltfVec4(gltfMatRead(m, 0, col), gltfMatRead(m, 1, col), gltfMatRead(m, 2, col), gltfMatRead(m, 3, col));
}

/// write a column of a matrix with a vector, doing nothing if the vector is undefined
function __gltfMatWriteColumn(m, col, vec=undefined) {
	gml_pragma("forceinline");
	if (!is_undefined(vec) && vec != noone) {
		array_copy(m, col*4, vec.toArray(), 0, 4);
	}
}

/// take (up to) 4 vectors and build an array with those vectors as the columns
function __gltfMatBuildFromVectors(vecs=[ ]) {
	gml_pragma("forceinline");
	var n = array_length(vecs);
	var result = matrix_build_identity();
	for (var i = 0; i < 4; i++) {
		if (n > i) {
			__gltfMatWriteColumn(result, i, vecs[i]);
		}
	}
	return result;
}

/// returns new vector with (x,y,z,w) equal to 0-3th elements of array
function __gltfArrayToVec(a) {
	gml_pragma("forceinline");
	return new __gltfVec4(a[0], a[1], a[2], a[3]);
}

/// same as arrayToVec but if u have an array size of only 3 it wont crash
function __gltfArrayToVec3(a) {
	gml_pragma("forceinline");
	return new __gltfVec3(a[0], a[1], a[2]);
}

/*

matrix multiplied by vector defines as:

	[x1 y1 .. w1][v1] =   v1[x1] +    v2[y1] + .. +   vn[w1]
	[x2 y2 .. w2][v2]		[x2]		[y2]			[w2]
	 ..
	[xn yn .. wn][vn]		[xn]		[yn]			[wn]

eg build matrix from vectors:
	(vector components as scalars).(matrix columns as vectors)
*/

/// multiply matrix m with vector v, returns new vector
function __gltfMulMatVec(m, v) {
	gml_pragma("forceinline");
	
	return new __gltfVec4(
		m[0]*v.x + m[4]*v.y +  m[8]*v.z + m[12]*v.w,
		m[1]*v.x + m[5]*v.y +  m[9]*v.z + m[13]*v.w,
		m[2]*v.x + m[6]*v.y + m[10]*v.z + m[14]*v.w,
		m[3]*v.x + m[7]*v.y + m[11]*v.z + m[15]*v.w
	);
}

/// multiply two matrices together, in the correct order
function __gltfMulMats(m1, m2) {
	// this function was needed for my own sanity
	gml_pragma("forceinline");
	return matrix_multiply(m2, m1);
}

/// multiply two matrices together, in the correct order
/// utilise result_matrix to cut down on temp data structures
function __gltfMulMatsResult(m1, m2, result) {
	gml_pragma("forceinline");
	return matrix_multiply(m2, m1, result);
}

/// scalar product of s and v, returns new vector
function __gltfMulScalarVec(s, v) {
	gml_pragma("forceinline");
	//return new vec4(s*v.x, s*v.y, s*v.z, s*v.w);
	return v.duplicate().scale(s);
}

#region https://github.com/callmeEthan/Gamemaker_quaternion/blob/main/scripts/Quaternion/Quaternion.gml

/// @function		__gltfQuaternionSlerp(qa, qb, amount, array)
/// @description	Lerp the quaternions using spherical linear interpolation. See comments for details.
/// @param	{Array<Real>}	qa		The quaternion from which to lerp
/// @param	{Array<Real>}	qb		The quaternion to which to lerp
/// @param	{Real}			amount	The lerp factor, from 0 to 1
/// @param	{Array<Real>}	[array]	Optional pass-by-reference output array
function __gltfQuaternionSlerp(qa, qb, amount, array=array_create(4)) {
	// Interpolate between two quaternions representing rotations with Spherical-linear-interpolation for better quality
	var qax=qa[0], qay=qa[1], qaz=qa[2], qaw=qa[3];
	var qbx=qb[0], qby=qb[1], qbz=qb[2], qbw=qb[3];
	var dot = qaw * qbw + qax * qbx + qay * qby + qaz * qbz;
	if (dot < 0) {
		// Make sure we take the shortest way around
		qbx = -qbx;
		qby = -qby;
		qbz = -qbz;
		qbw = -qbw;
		dot = qaw * qbw + qax * qbx + qay * qby + qaz * qbz;
	}
	if (dot > 0.99) {
		// Linear interpolation
		array[@0] = lerp(qax, qbx, amount);
		array[@1] = lerp(qay, qby, amount);
		array[@2] = lerp(qaz, qbz, amount);
		array[@3] = lerp(qaw, qbw, amount);
		return array;
	}
	var angle = arccos(dot);
	var denom = sin(angle);
	// Spherical linear interpolation.
	var r1 = sin((1-amount)*angle);
	var r2 = sin(amount*angle);
	array[@0] = (qax * r1 + qbx * r2)/denom
	array[@1] = (qay * r1 + qby * r2)/denom
	array[@2] = (qaz * r1 + qbz * r2)/denom
	array[@3] = (qaw * r1 + qbw * r2)/denom
	return array;
}

/// @function					__gltfQuaternionToAngle(q)
/// @description				Returns the XYZ Euler angles (degrees) describing the provided quaternion; the roll-pitch-yaw
/// @param	{Array<Real>}	q	The XYZW quaternion
/// @return	{Array<Real>}		The XYZ Euler angles (degrees) equivalent to the provided quaternion; the roll-pitch-yaw
function __gltfQuaternionToAngle(q) {
	gml_pragma("forceinline");
    // roll (x-axis rotation)
    var sinr_cosp = 2 * (q[3] * q[0] + q[1] * q[2]);
    var cosr_cosp = 1 - 2 * (q[0] * q[0] + q[1] * q[1]);
    var roll = arctan2(sinr_cosp, cosr_cosp);

    // pitch (y-axis rotation)
    var sinp = sqrt(1 + 2 * (q[3] * q[0] - q[1] * q[2]));
    var cosp = sqrt(1 - 2 * (q[3] * q[0] - q[1] * q[2]));
    var pitch = 2 * arctan2(sinp, cosp) - pi / 2;

    // yaw (z-axis rotation)
    var siny_cosp = 2 * (q[3] * q[2] + q[0] * q[1]);
    var cosy_cosp = 1 - 2 * (q[1] * q[1] + q[2] * q[2]);
    var yaw = arctan2(siny_cosp, cosy_cosp);

	yaw = radtodeg(yaw);
	pitch = radtodeg(pitch);
	roll = radtodeg(roll);
    return [roll, pitch, yaw];
}

/// @function							__gltfAngleToQuaternion(xangle, yangle, zangle, output)
/// @description						Returns the quaternion describing the provided XYZ Euler angles (degrees); the roll-pitch-yaw
/// @param	{Real}	xangle				The X angle (degrees) of the Euler rotation; the roll
/// @param	{Real}	yangle				The Y angle (degrees) of the Euler rotation; the pitch
/// @param	{Real}	zangle				The Z angle (degrees) of the Euler rotation; the yaw
/// @param	{Array<Real>}	[output]	An optional array to write the output to by reference
/// @return	{Array<Real>}				The XYZW quaternion describing the provided XYZ Euler rotation
function __gltfAngleToQuaternion(xangle, yangle, zangle, output=array_create(4))
{
	gml_pragma("forceinline");
    // Abbreviations for the various angular functions
    var cr = dcos(xangle * 0.5);
    var sr = dsin(xangle * 0.5);
    var cp = dcos(yangle * 0.5);
    var sp = dsin(yangle * 0.5);
    var cy = dcos(zangle * 0.5);
    var sy = dsin(zangle * 0.5);	
    output[@3] = cr * cp * cy + sr * sp * sy;
    output[@0] = sr * cp * cy - cr * sp * sy;
    output[@1] = cr * sp * cy + sr * cp * sy;
    output[@2] = cr * cp * sy - sr * sp * cy;
    return output;
}

function __gltfMatrixBuildQuaternion(x, y, z, quaternion, xscale, yscale, zscale, matrix=array_create(16)) {
	// Build transform matrix based on quaternion rotation instead of Euler angle
	// https://www.euclideanspace.com/maths/geometry/rotations/conversions/quaternionToMatrix/index.htm
	//	You can defined output array (1D array length 16), it will write transform matrix directly onto output array and return nothing.
	//	Output should be an array size 16 to write data directly, if not defined return a new array.
	gml_pragma("forceinline");
	var sqw = quaternion[3]*quaternion[3];
	var sqx = quaternion[0]*quaternion[0];
	var sqy = quaternion[1]*quaternion[1];
	var sqz = quaternion[2]*quaternion[2];
	matrix[@ 0] = (sqx - sqy - sqz + sqw) * xscale; // since sqw + sqx + sqy + sqz =1
	matrix[@ 5] = (-sqx + sqy - sqz + sqw) * yscale;
	matrix[@ 10] = (-sqx - sqy + sqz + sqw) * zscale;
   
	var tmp1 = quaternion[0]*quaternion[1];
	var tmp2 = quaternion[2]*quaternion[3];
	matrix[@ 1] = 2.0 * (tmp1 + tmp2) * xscale;
	matrix[@ 4] = 2.0 * (tmp1 - tmp2) * yscale;
   
	tmp1 = quaternion[0]*quaternion[2];
	tmp2 = quaternion[1]*quaternion[3];
	matrix[@ 2] = 2.0 * (tmp1 - tmp2) * xscale;
	matrix[@ 8] = 2.0 * (tmp1 + tmp2) * zscale;
   
	tmp1 = quaternion[1]*quaternion[2];
	tmp2 = quaternion[0]*quaternion[3];
	matrix[@ 6] = 2.0 * (tmp1 + tmp2) * yscale;
	matrix[@ 9] = 2.0 * (tmp1 - tmp2) * zscale;
	
	matrix[@ 12] = x;
	matrix[@ 13] = y;
	matrix[@ 14] = z;
	matrix[@ 15] = 1.0;
	return matrix;
}

/// @function						__gltfMatrixToQuaternion(matrix, array=array_create(4))
/// @description					Get the rotation from a transformation (4x4) matrix and return a quaternion unit.
/// @param	{Array<Real>}	matrix	Transformation matrix (4x4)
/// @param	{Array<Real>}	array	Optional pass-by-reference output array
function __gltfMatrixToQuaternion(matrix, array = array_create(4))
{
	var qx, qy, qz, qw, s, trace
	// Convert transformation matrix to rotation matrix
	// Source: https://stackoverflow.com/questions/27655885/get-position-rotation-and-scale-from-matrix-in-opengl
	var a00=matrix[0], a10=matrix[1], a20=matrix[2];
	var a01=matrix[4], a11=matrix[5], a21=matrix[6];
	var a02=matrix[8], a12=matrix[9], a22=matrix[10];
	var factor = sqrt(a00 * a00 + a01 * a01 + a02 * a02);
	a00/=factor; a01/=factor; a02/=factor;
	a10/=factor; a11/=factor; a12/=factor;
	a20/=factor; a21/=factor; a22/=factor;
	
	// Convert rotation matrix to quaternion unit
	// Source: https://www.euclideanspace.com/maths/geometry/rotations/conversions/matrixToQuaternion/
	trace = a00 + a11 + a22; // removed + 1.0f;
	if( trace > 0 ) {// changed M_EPSILON to 0
		s = 0.5 / sqrt(trace+ 1.0);
		qw = 0.25 / s;
		qx = ( a21 - a12 ) * s;
		qy = ( a02 - a20 ) * s;
		qz = ( a10 - a01 ) * s;
	} else {
		if ( a00 > a11 && a00 > a22 ) {
		    s = 2.0 * sqrt( 1.0 + a00 - a11 - a22);
		    qw = (a21 - a12 ) / s;
		    qx = 0.25 * s;
		    qy = (a01 + a10 ) / s;
		    qz = (a02 + a20 ) / s;
		} else if (a11 > a22) {
		    s = 2.0 * sqrt( 1.0 + a11 - a00 - a22);
		    qw = (a02 - a20 ) / s;
		    qx = (a01 + a10 ) / s;
		    qy = 0.25 * s;
		    qz = (a12 + a21 ) / s;
		} else {
		    s = 2.0 * sqrt( 1.0 + a22 - a00 - a11 );
		    qw = (a10 - a01 ) / s;
		    qx = (a02 + a20 ) / s;
		    qy = (a12 + a21 ) / s;
		    qz = 0.25 * s;
		}
	}
	
	array[@0] = qx;
	array[@1] = qy;
	array[@2] = qz;
	array[@3] = qw;
	return array
}

#endregion

/// shorter than typing point_distance and only needs first two arguments
function __gltfPDist(x0, y0, x1=0, y1=0) {
	return sqrt(sqr(x1-x0) + sqr(y1-y0));
}

/// inverse lerp
function __gltfInvlerp(a, b, val) {
	gml_pragma("forceinline");
	return (val - a) / (b - a);
}

/// lerp elements of one array to another
function __gltfLerpArray(a, b, amount) {
	gml_pragma("forceinline");
	var n = min(array_length(a), array_length(b));
	var result = array_create(n);
	var i = 0; repeat(n) {
		result[i] = lerp(a[i], b[i], amount);
		i++;
	}
	return result;
}

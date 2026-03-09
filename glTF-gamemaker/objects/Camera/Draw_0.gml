/// @desc setup camera transforms

var m;

var i = 0; while (!matrix_stack_is_empty()) {
	i++;
	matrix_stack_pop();
	__gltfDebugPrint("current matrix stack count: {0}", [ i ]);
}

var to = __gltfVecAdd(pos, dir);
var from = pos;

var look = matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x, up.y, up.z);
look = __gltfMulMats(look, matrix_build(0, 0, 0, 0, rot, 0, 1, 1, 1));
var proj = matrix_build_projection_perspective_fov(60, window_get_width() / window_get_height(), 1, 32000); // perspective
//var proj = matrix_build_projection_ortho(1280, 720, 1, 32000); // ortho

var cam = camera_get_active();
camera_set_view_mat(cam, look);
camera_set_proj_mat(cam, proj);
camera_apply(cam);

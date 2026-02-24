if (!skinned) exit;

var n = getLastDigit();

var names = variable_struct_get_names(testSkin.skin.animLength); // todo: make specific getter for this

if (n >= 1 && n <= 9) {
	if (lastDigit != n) {
		//lastDigit = n;
		
		var a = n-1;
		if (a < array_length(names)) {
			animationOn[a] = !animationOn[a];
			hudDisplayText(string_ext("toggling animation {0}: {1}, {2}", [ a, names[a], animationOn[a] ? "ON" : "OFF" ]));
		}
	}
}

t += 1/60;

// LOL this is so busted

var posed = false;
var posedata = [];
for (var i = 0; i < animations; i++) {
	if (animationOn[i]) {
		var toBlend = testSkin.skin.animate(t, names[i]);
		if (!posed) {
			posed = true;
			posedata = toBlend;
		}
		else {
			posedata = testSkin.blendAnimation(posedata, toBlend, 0.5);
		}
	}
}

if (posed) {
	testSkin.animateBlended(posedata);
}
else {
	//testSkin.update();
}


// test blending two+ animations
		//var a1 = testSkin.skin.animate(t, "walk");
		//var a2 = testSkin.skin.animate(t, "headbang");
		//var blended = testSkin.blendAnimation(a1, a2, 0.5);
		//testSkin.animateBlended(blended);
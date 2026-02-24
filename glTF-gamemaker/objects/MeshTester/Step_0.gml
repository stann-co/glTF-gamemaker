// a

if (!skinned) exit;

var n = getLastDigit();

if (n >= 1 && n <= 9) {
	if (lastDigit != n) {
		lastDigit = n;
		testSkin.setAnimationIndex(n-1);
		hudDisplayText(string_ext("setting animation {0}: {1}", [ n-1, testSkin.currentAnimation ]));
	}
}

t += 1/60;
testSkin.animate(t);

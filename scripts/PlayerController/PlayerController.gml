function PlayerController(p = other) constructor {
	parent = p;
	direction = 0;
	
	static step = function(update = true) {
		horizontal = (InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT));
		jump = (InputCheck(INPUT_VERB.JUMP));
		down = (InputPressed(INPUT_VERB.DOWN));
		
		glide = (InputCheck(INPUT_VERB.GLIDE));
		dash = InputPressed(INPUT_VERB.DASH);
		
		direction = (horizontal == 0 ? direction : horizontal);
		
		if (update == false) return;
		if (horizontal != 0) parent.collider.velocity.x = direction;
		
		if (jump) parent.collider.jump();
		if (glide) parent.collider.glide();
		if (down) parent.collider.pass_trough();
		
		if (!parent.collider.grounded) parent.state.change("airborne");
		else if (horizontal != 0) parent.state.change("run");
		else parent.state.change("idle");
		
		if (dash) parent.state.change("dash");
	}
}
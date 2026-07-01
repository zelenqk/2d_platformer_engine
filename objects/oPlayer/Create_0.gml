controller = new PlayerController(self);

collider = new Collider(self);
collider.speed = 12;

dir = 1;
cooldown = 0;

hit = function(damage, pushDirection) {
	state.change("hit");
	cooldown = 100;
	
	collider.velocity.x = lengthdir_x(2, pushDirection);
	
	if (collider.grounded) {
		collider.velocity.y = -7;
		collider.jumped = true;
		collider.grounded = false;
	} else {
		collider.velocity.y = 0;
	}
}

state = new SnowState("idle");
state.event_set_default_function("step", function() {
	controller.step();
});

state.add("idle", {
		
});

state.add("run", {
	
});

state.add("airborne", {
	
});

state.add("hit", {
	enter: function() {
		collider.friction = 0.2; // lighter drag during knockback
	},
	leave: function() {
		cooldown = 0;
		collider.friction = 0.85; // restore normal friction
	},
	
	step: function() {
		cooldown--;
		
		if (cooldown <= 0 or collider.grounded) {
			state.change("idle");
			state.step();
		}
	}
});

state.add("dash", {
	enter: function() {
		mask_index = sCollisionMaskDash;
		sprite_index = sCollisionMaskDash;
		
		collider.velocity.x = 18 * controller.direction;
		collider.velocity.y = 0;
		
		collider.terminal.x = 4;
	},
	
	leave: function() {
		mask_index = sCollisionMask;
		sprite_index = sCollisionMask;
		collider.terminal.x = collider.speed;
		
		if (controller.jump) collider.jump();
	},
	
	step: function() {
		controller.step(false);
		
		var move = (controller.horizontal != controller.direction and controller.horizontal != 0);
		if (abs(collider.velocity.x) < 4 or controller.jump or move) {
			collider.velocity.x = 0;
			controller.step(true);
		}	
	}
})
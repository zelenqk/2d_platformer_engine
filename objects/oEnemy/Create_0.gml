collider = new Collider(self);
state = new SnowState("sleeping");
rolled = false;
lunging = false;
lunge_timer = 0;
lunge_duration = 64; // tune this to how many steps the lunge should last

state.add("sleeping", {
	step: function() {
		if (distance <= radius) state.change("seeking");
	}
});

state.add("idle", {
	step: function() {
		if (distance > radius) {
			state.change("sleeping");
			return;
		}
		
		if (abs(lengthdir_x(distance, direction)) > range) {
			state.change("seeking");
			return;
		}
		// lunge trigger now lives in the step event via rolled/lungeRange,
		// so idle just holds position otherwise
	}
});

state.add("seeking", {
	step: function() {
		if (distance <= range) {
			state.change("attack");
			state.step();
			return;
		}
		
		collider.velocity.x = sign(lengthdir_x(1, direction));
	}
});

state.add("attack", {
	enter: function() {
		oPlayer.hit(12, )	
	}
});


state.add("lunge", {
	enter: function() {
		sprite_index = sCollisionMaskDash;
		collider.friction = 0;
		collider.velocity.x = lengthdir_x(distance, direction) / 10;
		collider.terminal.x = 2.5;
		collider.gravity = 0.1;
		collider.velocity.y = -3;
		lunging = true;
		lunge_timer = 0;
	},
	
	step: function() {
		lunge_timer++;
		
		var hit = place_meeting(x, y, oPlayer);
		
		if (hit) oPlayer.hit(12, sign(collider.velocity.x));
		if (lunge_timer >= lunge_duration or hit) state.change("seeking");
	},
	
	leave: function() {
		sprite_index = sCollisionMask_2;
		collider.terminal.x = collider.speed;
		collider.gravity = 1;
		collider.friction = 0.1;

		lunging = false;
		// rolled is NOT reset here — only the step event resets it,
		// once the player has actually left lungeRange
	}
});
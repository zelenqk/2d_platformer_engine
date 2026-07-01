function Collider(mirror = other) constructor {
	parent = mirror;
	
	speed = 3;
	gravity = 1;
	friction = 0.85;
	jump_height = 18;
	jumped = false;
	
	velocity = {x: 0, y: 0};
	terminal = {x: speed, y: jump_height};
		tvelx = clamp(velocity.x, -terminal.x, terminal.x);
		tvely = clamp(velocity.y, -terminal.y, terminal.y);
	
	grounded = false;

	block = oBlock;
	platform = oPlatform;
	
	static step = function(time = 1) {
		tvelx = clamp(velocity.x, -terminal.x, terminal.x);
		tvely = clamp(velocity.y, -terminal.y, terminal.y);
		
		with (parent) {	//vertical check
			var py = y;
			var hit = false;
			var plat = noone;
			
			if (other.tvely > 0){
				repeat ceil(abs(other.tvely)) {
					plat = instance_place(x, y + sign(other.tvely), oPlatform);
					
					if (plat != noone and !place_meeting(x, y, plat)) {
						other.velocity.y = 0;
						other.grounded = true;
						other.jumped = false;
						hit = true;
						break;
					}
					
					y += sign(other.tvely);
				}
			}
			
			if (!hit) {
				y = py;
				
				repeat ceil(abs(other.tvely)) {
					if (place_meeting(x, y + sign(other.tvely), oBlock)) {
						other.velocity.y = 0;
						other.grounded = true;
						other.jumped = false;
						break;
					}
					
					y += sign(other.tvely);
				}
			}
			
			other.grounded = !other.jumped and (place_meeting(x, y + 1, other.block) or (plat != noone and !place_meeting(x, y, plat)));
			if (!other.grounded) other.velocity.y += other.gravity * time;
			
			repeat ceil(abs(other.speed * other.tvelx)) {
				if (place_meeting(x + sign(other.tvelx), y, oBlock)) {
					other.velocity.x = 0;
					break;
				}
				
				x += sign(other.tvelx)
			}
			
			other.velocity.x = sign(other.velocity.x) * (clamp(abs(other.velocity.x) - other.friction * time, 0, infinity));
		}
	}
	
	static dash = function(length) {
		var distance = 0;
		with (parent) {	//vertical check
			repeat abs(ceil(length)) {
				if (place_meeting(x + sign(length), y, oBlock)) {
					other.velocity.x = 0;
					break;
				}
				
				x += sign(length);
				distance++;
			}
		}
		
		velocity.y = -1;
		return distance;
	}
	
	static pass_trough = function() {
		with (parent) {
			var plat = instance_place(x, y + 1, oPlatform);
					
			if (plat != noone and !place_meeting(x, y, plat)) {
				y++;
			}
		}
	}
	
	static jump = function(time = 1) {
		if (grounded) {
			velocity.y = -jump_height;	
			jumped = true;
			grounded = false;
			
			return true;
		}
		
		return false;
	}
	
	static glide = function(time = 1){
		if (jumped) velocity.y -= (gravity / 3) * time;
	}
}
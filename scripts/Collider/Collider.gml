function Collider(mirror = other) constructor {
	parent = mirror;
	
	speed = 3;
	gravity = 1;
	friction = 0.85;
	jump_height = 18;
	jumped = false;
	
	velocity = {x: 0, y: 0};
	terminal = {x: speed, y: jump_height};
	grounded = false;

	block = oBlock;
	platform = oPlatform;
	
	static step = function(time = 1) {
		var tvelx = clamp(velocity.x, -terminal.x, terminal.x);
		var tvely = clamp(velocity.y, -terminal.y, terminal.y);
		
		with (parent) {	//vertical check
			var py = y;
			var hit = false;
			
			if (tvely > 0){
				repeat ceil(abs(tvely)) {
					if (place_meeting(x, y + sign(tvely), oPlatform) and !place_meeting(x, y, oPlatform)) {
						other.velocity.y = 0;
						other.grounded = true;
						other.jumped = false;
						hit = true;
						break;
					}
					
					y += sign(tvely);
				}
			}
			
			if (!hit) {
				y = py;
				
				repeat ceil(abs(tvely)) {
					if (place_meeting(x, y + sign(tvely), oBlock)) {
						other.velocity.y = 0;
						other.grounded = true;
						other.jumped = false;
						break;
					}
					
					y += sign(tvely);
				}
			}
			
			other.grounded = !other.jumped and (place_meeting(x, y + 1, other.block) or (place_meeting(x, y + 1, other.platform) and !place_meeting(x, y, other.platform)));
			if (!other.grounded) other.velocity.y += other.gravity * time;
			
			repeat ceil(abs(other.speed * tvelx)) {
				if (place_meeting(x + sign(tvelx), y, oBlock)) {
					other.velocity.x = 0;
					break;
				}
				
				x += sign(tvelx)
			}
			
			other.velocity.x = sign(other.velocity.x) * clamp(abs(other.velocity.x) - other.friction * time, 0, infinity);
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
			if (place_meeting(x, y + 1, other.platform) and !place_meeting(x, y, other.platform) and !place_meeting(x, y + 1, other.block)) {
				y++;
			}
		}
	}
	
	static jump = function(time = 1) {
		if (grounded) {
			velocity.y = -jump_height;	
			jumped = true;
			grounded = false;
		}
		
		if (jumped) velocity.y -= (gravity / 3) * time;
		
	}
}
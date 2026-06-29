collider.step(dt);

var h = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var jump = keyboard_check_pressed(vk_space) and collider.grounded;

if (mask_index == sCollisionMasKick){
	if (abs(collider.velocity.x) < 4 or jump or (h != dir and h != 0)) {
		mask_index = sCollisionMask;
		sprite_index = sCollisionMask;
		collider.terminal.x = collider.speed;
		
		if (jump) collider.jump();
	}
	exit;	
}

dir = (h == 0 ? dir : h);
if (h != 0) collider.velocity.x = h * dt;

if (keyboard_check(vk_space)) collider.jump(dt);
if (keyboard_check_pressed(ord("S"))) collider.pass_trough();

if (keyboard_check_pressed(vk_shift)) {
	mask_index = sCollisionMasKick;
	sprite_index = sCollisionMasKick;
	collider.velocity.x = 18 * dir;
	collider.velocity.y = 0;
	
	collider.terminal.x = 4;
}
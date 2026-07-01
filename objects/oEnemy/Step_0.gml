distance = point_distance(x, y, oPlayer.x, oPlayer.y);
direction = point_direction(x, y, oPlayer.x, oPlayer.y);
state.step();
collider.step(dt);

if (!rolled and distance <= lungeRange and canLunge) {
	rolled = true;
	lunging = choose(true);
	
	if (lunging) state.change("lunge");
}

if (rolled and distance > lungeRange) rolled = false;
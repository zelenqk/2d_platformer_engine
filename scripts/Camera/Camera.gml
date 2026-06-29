function Camera(follow = other) constructor {
	following = follow;
	
	x = follow.x;
	y = follow.y;
	
	offset = {x: 0, y: 0};
	
	index = camera_create();
	view = 0;
	
	factor = 0.1;
	width = display_get_gui_width();
	height = display_get_gui_height();

	view_enabled = true;
	view_visible[view] = true;
	view_camera[view] = index;
		
	step = function(time = 1) {
		x += ((following.x - x) * time) * factor;
		y += ((following.y - y) * time) * factor;
		
		camera_set_view_size(index, width, height);	
		camera_set_view_pos(index, floor(x - width / 2 + offset.x), floor(y - height / 2 + offset.y));
	}
}
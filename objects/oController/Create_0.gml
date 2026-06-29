globalvar dt;
deltatime = new DeltaTime(60);
dt = deltatime.step();

camera = new Camera(oPlayer);
camera.offset.y = -64;


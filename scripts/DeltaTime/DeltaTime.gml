function DeltaTime(targetFps = 60) constructor {
    targetDelta = 1 / targetFps;
    accumulator = 0;
    alpha = 0;

    step = function() {
        return (delta_time / targetDelta) / 1_000_000;
    }
}
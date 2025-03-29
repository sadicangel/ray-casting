module sdl::timer;

extern fn ulong get_ticks() @extern("SDL_GetTicks");
extern fn void delay(uint ms) @extern("SDL_Delay");
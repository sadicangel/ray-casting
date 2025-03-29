module sdl;

extern fn char* get_error() @extern("SDL_GetError");

const uint INIT_AUDIO      = 0x00000010u;
const uint INIT_VIDEO      = 0x00000020u;
const uint INIT_JOYSTICK   = 0x00000200u;
const uint INIT_HAPTIC     = 0x00001000u;
const uint INIT_GAMEPAD    = 0x00002000u;
const uint INIT_EVENTS     = 0x00004000u;
const uint INIT_SENSOR     = 0x00008000u;
const uint INIT_CAMERA     = 0x00010000u;

extern fn bool init(uint flags) @extern("SDL_Init");
extern fn void quit() @extern("SDL_Quit");
module sdl::render;
import sdl::rect;

const int TEXTUREACCESS_STATIC = 0;
const int TEXTUREACCESS_STREAMING = 1;
const int TEXTUREACCESS_TARGET = 2;

const uint PIXELFORMAT_RGBA8888 = 0x16462004u;

extern fn void destroy_renderer(void *renderer) @extern("SDL_DestroyRenderer");
extern fn bool render_clear(void *renderer) @extern("SDL_RenderClear");
extern fn void* create_texture(void *renderer, uint format, int access, int width, int height) @extern("SDL_CreateTexture");
extern fn bool render_present(void *renderer) @extern("SDL_RenderPresent");
extern fn bool render_texture(void *renderer, void *texture, Rect(<float>) *srcrect, Rect(<float>) *dstrect) @extern("SDL_RenderTexture");
extern fn bool update_texture(void *texture, Rect(<int>) *rect, void *pixels, int pitch) @extern("SDL_UpdateTexture");

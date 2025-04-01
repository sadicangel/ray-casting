module ray_casting;
import std::io;
import std::core::mem;
import std::math;
import sdl;
import sdl::events;
import sdl::render;
import sdl::timer;
import sdl::video;

const int WINDOW_WIDTH = 512;
const int WINDOW_HEIGHT = 512;
const int MAP_WIDTH = 16;
const int MAP_HEIGHT = 16;
const String MAP_GRID = 
    `0000222222220000`
    `1              0`
    `1      11111   0`
    `1     0        0`
    `0     0  1110000`
    `0     3        0`
    `0   10000      0`
    `0   0   11100  0`
    `0   0   0      0`
    `0   0   1  00000`
    `0       1      0`
    `2       1      0`
    `0       0      0`
    `0 0000000      0`
    `0              0`
    `0002222222200000`;
const float FOV = math::PI / 3.0f;

struct Map {
    char[] grid;
    int width;
    int height;
}

struct Player {
    float x;
    float y;
    float a;
}

fn int main(String[] args)
{
    if(!sdl::init(sdl::INIT_VIDEO)) {
        io::printf("Failed to initialize SDL: %s\n", sdl::get_error());
        return 1;
    }
    defer sdl::quit();

    void* window = null;
    void* renderer = null;

    if(!video::create_window_and_renderer("Ray Casting", WINDOW_WIDTH, WINDOW_HEIGHT, 0, &window, &renderer)) {
        io::printf("Failed to create window and renderer: %s\n", sdl::get_error());
        return 1;
    }
    defer {
        render::destroy_renderer(renderer);
        video::destroy_window(window);
    }

    void* framebuffer = render::create_texture(renderer, render::PIXELFORMAT_RGBA8888, render::TEXTUREACCESS_STREAMING, WINDOW_WIDTH, WINDOW_HEIGHT);
    if(framebuffer == null) {
        io::printf("Failed to create framebuffer texture: %s\n", sdl::get_error());
        return 1;
    }
    defer render::destroy_texture(framebuffer);

    Spritesheet walls = load_spritesheet("resources/walls.png", 64, 64)!!;
    defer walls.free();

    Image worldImage = {
        .pixels = mem::new_array(Color, WINDOW_WIDTH * WINDOW_HEIGHT),
        .width = WINDOW_WIDTH,
        .height = WINDOW_HEIGHT,
        .bytes_per_pixel = BYTES_PER_PIXEL
    };

    Image mapImage = {
        .pixels = mem::new_array(Color, WINDOW_WIDTH * WINDOW_HEIGHT),
        .width = WINDOW_WIDTH,
        .height = WINDOW_HEIGHT,
        .bytes_per_pixel = BYTES_PER_PIXEL
    };

    Map map = {
        .grid = MAP_GRID,
        .width = MAP_WIDTH,
        .height = MAP_HEIGHT
    };

    Player player = {
        .x = 3.456,
        .y = 2.345,
        .a = 1.523,
    };

    Color[] random_colors = {
        {200, 50, 50, 255},   // Red
        {50, 200, 50, 255},   // Green
        {50, 50, 200, 255},   // Blue
        {200, 200, 50, 255},  // Yellow
        {200, 50, 200, 255},  // Magenta
        {50, 200, 200, 255},  // Cyan
    };

    Event event;
    while (1) {
        events::poll_event(&event);
        if (event.type == events::EVENT_QUIT) {
            break;
        }

        defer {
            render::update_texture(framebuffer, null, worldImage.pixels, worldImage.width * worldImage.bytes_per_pixel);
            render::render_clear(renderer);
            render::render_texture(renderer, framebuffer, null, null);
            render::render_present(renderer);
            // We probably want to use timer::get_ticks() to get the time since the last frame
            // and adjust the player position accordingly.
            timer::delay(1000 / 60); // 60 FPS
        }
    
        foreach(&pixel : worldImage.pixels) {
            *pixel = {255, 255, 255, 255};
        }
        foreach(&pixel : mapImage.pixels) {
            *pixel = {255, 255, 255, 255};
        }

        player.a += (2 / ((float)math::PI * 360f)) % 360f;

        int rect_width = mapImage.width / map.width;
        int rect_height = mapImage.height / map.height;
        for (int j = 0; j < map.height; ++j) {
            for (int i = 0; i < map.width; ++i) {
                if (map.grid[i + j * map.width] == ' ') continue;
                mapImage.draw_rectangle(i * rect_width, j * rect_height, rect_width, rect_height, {0, 255, 255, 255});
            }
        }

        for (int i = 0; i < mapImage.width; ++i) {
            float ray_angle = player.a - FOV / 2 + FOV * i / (float)mapImage.width;
            for (float t = 0; t < 20f; t += 0.05f) {
                float cx = player.x + t * math::cos(ray_angle);
                float cy = player.y + t * math::sin(ray_angle);
                
                int pix_x = (int)(cx * rect_width);
                int pix_y = (int)(cy * rect_height);

                mapImage.pixels[pix_x + pix_y * mapImage.width] = {160, 160, 160, 255};

                char type = map.grid[(int)cx + (int)cy * map.width];
                if (type != ' ') {
                    Color color = random_colors[(type - '0') % 6];
                    if (t > 0) {
                        int column_height = (int)(worldImage.width / (t * std::math::cos(ray_angle - player.a)));
                        worldImage.draw_rectangle(i, (worldImage.height - column_height) / 2, 1, column_height, color);
                    }
                    break;
                }
            }
        }

        Rect(<int>) wall = walls.get_sprite_rect(3)!!;
        for (int i = 0; i < wall.w; ++i) {
            for (int j = 0; j < wall.h; ++j) {
                worldImage.pixels[i + j * worldImage.width] =
                    walls.image.pixels[(wall.x + i) + (wall.y + j) * walls.image.width];
            }
        }
    }

    return 0;
}

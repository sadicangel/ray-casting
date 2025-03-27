module ray_casting;
import std::io;
import std::core::mem;
import std::math;

const int WINDOW_WIDTH = 512;
const int WINDOW_HEIGHT = 512;
const int MAP_WIDTH = 16;
const int MAP_HEIGHT = 16;
const String MAP_DATA = 
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

struct Map {
    char[] data;
    int width;
    int height;
}

struct Player {
    float x;
    float y;
}

fn int main(String[] args)
{
    Image image = {
        .pixels = mem::new_array(Color, WINDOW_WIDTH * WINDOW_HEIGHT),
        .width = WINDOW_WIDTH,
        .height = WINDOW_HEIGHT,
        .bytes_per_pixel = BYTES_PER_PIXEL
    };
    
    Map map = {
        .data = MAP_DATA,
        .width = MAP_WIDTH,
        .height = MAP_HEIGHT
    };

    Player player = {
        .x = 3.456,
        .y = 2.345
    };

    foreach(i, &pixel : image.pixels) {
        *pixel = {
            (char)(255 * math::max(0.0f, math::min(1.0f, (float)(i % WINDOW_WIDTH) / WINDOW_WIDTH))),
            (char)(255 * math::max(0.0f, math::min(1.0f, (float)(i / WINDOW_HEIGHT) / WINDOW_HEIGHT))),
            0x00,
            0xFF
        };
    }

    int rect_width = image.width / map.width;
    int rect_height = image.height / map.height;
    for (int j = 0; j < map.height; ++j) {
        for (int i = 0; i<map.width; ++i) {
            if (map.data[i + j * map.width] == ' ') continue;
            image.draw_rectangle(i * rect_width, j * rect_height, rect_width, rect_height, {0, 255, 255, 255});
        }
    }

    image.draw_rectangle((int)std::math::floor(player.x * rect_width), (int)std::math::floor(player.y * rect_height), 5, 5, {255, 255, 255, 255});
    
    if(catch excuse = image.save("output.png")) {
        return 1;
    }

    return 0;
}

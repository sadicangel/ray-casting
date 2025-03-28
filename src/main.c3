module ray_casting;
import std::io;
import std::core::mem;
import std::math;

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

    int rect_width = mapImage.width / map.width;
    int rect_height = mapImage.height / map.height;
    for (int j = 0; j < map.height; ++j) {
        for (int i = 0; i<map.width; ++i) {
            if (map.grid[i + j * map.width] == ' ') continue;
            mapImage.draw_rectangle(i * rect_width, j * rect_height, rect_width, rect_height, {0, 255, 255, 255});
        }
    }

    int lastIndex = -1;
    for (int i = 0; i < mapImage.width; ++i) {
        float angle = player.a - FOV / 2 + FOV * i / (float)mapImage.width;
        for (float t = 0; t < 20f; t += 0.05f) {
            float cx = player.x + t * math::cos(angle);
            float cy = player.y + t * math::sin(angle);
            
            int pix_x = (int)(cx * rect_width);
            int pix_y = (int)(cy * rect_height);
            
            mapImage.pixels[pix_x + pix_y * mapImage.width] = {160, 160, 160, 255};

            if (map.grid[(int)cx + (int)cy * map.width] != ' ') {
                if (t > 0) {
                    int column_height = (int)(worldImage.width / t);
                    worldImage.draw_rectangle(i, (worldImage.height - column_height) / 2, 1, column_height, {0, 255, 255, 255});
                }
                break;
            }
        }
    }
    
    if (catch excuse = mapImage.save("map.png")) {
        return 1;
    }

    if (catch excuse = worldImage.save("world.png")) {
        return 1;
    }

    return 0;
}

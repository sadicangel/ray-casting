module ray_casting;
import std::io;
import sdl::rect;

struct Spritesheet {
    Image image;
    int sprite_width;
    int sprite_height;
    int sprite_count;
}

fault SpritesheetResult {
    FILE_LOAD_ERROR,
    UNSUPPORTED_FORMAT,
    SPRITE_INDEX_OUT_OF_BOUNDS,
}

fn void Spritesheet.free(Spritesheet* self) {
    stbi_image_free(self.image.pixels);
}

fn Rect(<int>)! Spritesheet.get_sprite_rect(Spritesheet* self, int index) {
    if (index < 0 || index >= self.sprite_count) {
        io::printf("Sprite index out of bounds: %d\n", index);
        return SpritesheetResult.SPRITE_INDEX_OUT_OF_BOUNDS?;
    }

    int sprites_per_row = self.image.width / self.sprite_width;
    int x = (index % sprites_per_row) * self.sprite_width;
    int y = (index / sprites_per_row) * self.sprite_height;

    return {
        .x = x,
        .y = y,
        .w = self.sprite_width,
        .h = self.sprite_height
    };
}

fn Spritesheet! load_spritesheet(String filename, int sprite_width, int sprite_height) {
    int width, height, bytes_per_pixel;
    char* data = stbi_load(filename, &width, &height, &bytes_per_pixel, 0);
    if (data == null) {
        io::printf("Failed to load texture: %s\n", filename);
        return SpritesheetResult.FILE_LOAD_ERROR?;
    }
    defer stbi_image_free(data);

    if(bytes_per_pixel != BYTES_PER_PIXEL) {
        io::printf("Image format not supported: %d bytes per pixel\n", bytes_per_pixel);
        return SpritesheetResult.UNSUPPORTED_FORMAT?;
    }

    Color[] rgba_pixels = mem::new_array(Color, (usz)(width * height));
    for (int j = 0; j < height; j++) {
        for (int i=0; i < width; i++) {
            char r = data[(i + j * width) * 4 + 0];
            char g = data[(i + j * width) * 4 + 1];
            char b = data[(i + j * width) * 4 + 2];
            char a = data[(i + j * width) * 4 + 3];
            rgba_pixels[i + j * width] = {r, g, b, a};
        }
    }

    Image img = {
        .pixels = rgba_pixels,
        .width = width,
        .height = height,
        .bytes_per_pixel = bytes_per_pixel
    };

    if(img.width % sprite_width != 0 || img.height % sprite_height != 0) {
        io::printf("Image dimensions are not a multiple of sprite size\n");
        return SpritesheetResult.UNSUPPORTED_FORMAT?;
    }

    return Spritesheet {
        .image = img,
        .sprite_width = sprite_width,
        .sprite_height = sprite_height,
        .sprite_count = (img.width / sprite_width) * (img.height / sprite_height)
    };
}
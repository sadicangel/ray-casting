module ray_casting;
import std::io;

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

fn Image! Spritesheet.get_sprite(Spritesheet* self, int index) {
    if (index < 0 || index >= self.sprite_count) {
        io::printf("Sprite index out of bounds: %d\n", index);
        return SpritesheetResult.SPRITE_INDEX_OUT_OF_BOUNDS?;
    }

    int sprites_per_row = self.image.width / self.sprite_width;
    int x = (index % sprites_per_row) * self.sprite_width;
    int y = (index / sprites_per_row) * self.sprite_height;

    Image sprite = {
        .pixels = self.image.pixels[((y * self.image.width + x) * self.image.bytes_per_pixel)..],
        .width = self.sprite_width,
        .height = self.sprite_height,
        .bytes_per_pixel = self.image.bytes_per_pixel
    };

    return sprite;
}

fn Spritesheet! load_spritesheet(String filename, int sprite_width, int sprite_height) {
    int width, height, bytes_per_pixel;
    char* data = stbi_load(filename, &width, &height, &bytes_per_pixel, 0);
    if (data == null) {
        io::printf("Failed to load texture: %s\n", filename);
        return SpritesheetResult.FILE_LOAD_ERROR?;
    }

    defer catch stbi_image_free(data);

    if(bytes_per_pixel != BYTES_PER_PIXEL) {
        io::printf("Image format not supported: %d bytes per pixel\n", bytes_per_pixel);
        return SpritesheetResult.UNSUPPORTED_FORMAT?;
    }

    Image img = {
        .pixels = *(Color[]*)&data,
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
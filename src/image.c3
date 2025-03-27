module ray_casting;
import std::io;
import std::core::mem;
import std::math;

extern fn int stbi_write_png(char* filename, int x, int y, int comp, void* data, int stride_bytes);

const int BYTES_PER_PIXEL = 4;

def Color = char[<BYTES_PER_PIXEL>];

fault ImageResult {
    FILE_WRITE_ERROR,
}

struct Image {
    Color[] pixels;
    int width;
    int height;
    int bytes_per_pixel;
}

fn void! Image.save(Image* self, String filename)
{
    if (stbi_write_png(filename, self.width, self.height, self.bytes_per_pixel, self.pixels, self.width * self.bytes_per_pixel) == 0) {
        io::printf("Failed to write image to file.");
        return ImageResult.FILE_WRITE_ERROR?;
    }

    io::printf("Image saved to %s\n", filename);
}

fn void Image.draw_rectangle(Image* self, int x, int y, int width, int height, Color color)
{
    for (int i = 0; i < width; ++i) {
        for (int j = 0; j < height; ++j) {
            int cx = x + i;
            int cy = y + j;
            self.pixels[cx + cy * self.width] = color;
        }
    }
}
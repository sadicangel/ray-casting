module ray_casting;
import std::io;
import std::core::mem;
import std::math;

extern fn int stbi_write_png(char* filename, int x, int y, int comp, void* data, int stride_bytes);

const String IMAGE_NAME = "output.png";
const int IMAGE_WIDTH = 1024;
const int IMAGE_HEIGHT = 768;
const int BYTES_PER_PIXEL = 4;

def Color = char[<BYTES_PER_PIXEL>];

fault StbResult {
    WRITE_ERROR
} 

fn void! save_image(Color* image)
{
    if (stbi_write_png(IMAGE_NAME, IMAGE_WIDTH, IMAGE_HEIGHT, BYTES_PER_PIXEL, image, IMAGE_WIDTH * BYTES_PER_PIXEL) == 0) {
        io::printf("Failed to write image to file.");
        return StbResult.WRITE_ERROR?;
    }
}

fn int main(String[] args)
{
    Color[] image = mem::new_array(Color, IMAGE_WIDTH * IMAGE_HEIGHT);
    foreach(i, &pixel : image) {
        *pixel = {
            (char)(255 * math::max(0.0f, math::min(1.0f, (float)(i % IMAGE_WIDTH) / IMAGE_WIDTH))),
            (char)(255 * math::max(0.0f, math::min(1.0f, (float)(i / IMAGE_HEIGHT) / IMAGE_HEIGHT))),
            0x00,
            0xFF
        };
    }
    
    if(catch excuse = save_image(image)) {
        io::printf("Error: %s\n", excuse);
        return 1;
    }

    io::printf("Image saved to %s\n", IMAGE_NAME);

    return 0;
}

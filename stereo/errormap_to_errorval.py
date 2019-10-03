import sys
import numpy as np
from PIL import Image



def main():
    if len(sys.argv) != 2:
        print("ERROR: Usage - pyhton3 {} <error-colormap-image>".format(sys.argv[0]))
        sys.exit()

    image = Image.open(sys.argv[1])
    img_pixels = image.convert('RGB').load()
    img_size = image.size
    width = img_size[0]
    height = img_size[1]

    ### WHY /3.0 ???
    # cols = [[ 0/3.0,       0.1875/3.0,  49,  54, 149],
    #      [0.1875/3.0,  0.375/3.0,   69, 117, 180],
    #      [0.375/3.0,   0.75/3.0,   116, 173, 209],
    #      [0.75/3.0,    1.5/3.0,    171, 217, 233],
    #      [1.5/3.0,     3/3.0,      224, 243, 248],
    #      [3/3.0,       6/3.0,      254, 224, 144],
    #     [6/3.0,      12/3.0,      253, 174,  97],
    #     [12/3.0,      24/3.0,      244, 109,  67],
    #     [24/3.0,      48/3.0,      215,  48,  39],
    #     [48/3.0,     np.inf,      165,   0,  38 ]]
    # cols[:,[3,5]] = cols[:,[3,5]]/255

    error_vals = {
        (49,  54, 149): (0, 0.1875),
        (69, 117, 180): (0.1875, 0.375),
        (116, 173, 209): (0.375, 0.75),
        (171, 217, 233): (0.75, 1.5),
        (224, 243, 248): (1.5, 3),
        (254, 224, 144): (3, 6),
        (253, 174,  97): (6, 12),
        (244, 109,  67): (12, 24),
        (215,  48,  39): (24, 48),
        (165,   0,  38): (48, 255),
        (0,0,0): (0,0)
    }

    result_error = [None] * (width*height)

    for x in range(height):
        for y in range(width):
            rgb = img_pixels[y,x]

            err = error_vals.get(rgb)
            if err != None:
                result_error[(height * x) + y] = err
            else:
                error_vals[rgb] = (0,0)
                result_error[(height * x) + y] = (0,0)


if __name__ == "__main__":
    main()

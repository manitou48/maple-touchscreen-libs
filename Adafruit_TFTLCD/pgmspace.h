#include <libmaple.h>

typedef const unsigned char prog_uchar;
#define pgm_read_byte_near(x) (*(prog_uchar*)x)
#define pgm_read_byte(x) (*(prog_uchar*)x)

#define pgm_read_word(x) (*(prog_uchar*)x)

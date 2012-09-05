/***********************************
This is a our graphics core library, for all our displays. 
We'll be adapting all the
existing libaries to use this core to make updating, support 
and upgrading easier!

Adafruit invests time and resources providing this open source code, 
please support Adafruit and open-source hardware by purchasing 
products from Adafruit!

Written by Limor Fried/Ladyada  for Adafruit Industries.  
BSD license, check license.txt for more information
All text above must be included in any redistribution
****************************************/

#ifndef _ADAFRUIT_GFX_H
#define _ADAFRUIT_GFX_H


#include <libmaple.h>
#include "Print.h"
#include "WProgram.h"


#define swap(a, b) { int t = a; a = b; b = t; }

class Adafruit_GFX : public Print {
 public:

  //Adafruit_GFX();
  // i have no idea why we have to formally call the constructor. kinda sux
  void constructor(int w, int h);

  // this must be defined by the subclass
  virtual void drawPixel(int x, int y, unsigned int color);
  virtual void invertDisplay(boolean i);

  // these are 'generic' drawing functions, so we can share them!
  virtual void drawLine(int x0, int y0, int x1, int y1, 
		unsigned int color);
  virtual void drawFastVLine(int x, int y, int h, unsigned int color);
  virtual void drawFastHLine(int x, int y, int w, unsigned int color);
  virtual void drawRect(int x, int y, int w, int h, 
		unsigned int color);
  virtual void fillRect(int x, int y, int w, int h, 
		unsigned int color);
  virtual void fillScreen(unsigned int color);

  void drawCircle(int x0, int y0, int r, unsigned int color);
  void drawCircleHelper(int x0, int y0,
			int r, unsigned char cornername, unsigned int color);
  void fillCircle(int x0, int y0, int r, unsigned int color);
  void fillCircleHelper(int x0, int y0, int r,
		      unsigned char cornername, int delta, unsigned int color);

  void drawTriangle(int x0, int y0, int x1, int y1,
		    int x2, int y2, unsigned int color);
  void fillTriangle(int x0, int y0, int x1, int y1,
		    int x2, int y2, unsigned int color);
  void drawRoundRect(int x0, int y0, int w, int h,
		     int radius, unsigned int color);
  void fillRoundRect(int x0, int y0, int w, int h,
		     int radius, unsigned int color);

  void drawBitmap(int x, int y, 
		  const unsigned char *bitmap, int w, int h,
		  unsigned int color);
  void drawChar(int x, int y, unsigned char c,
		unsigned int color, unsigned int bg, unsigned char size);

  virtual void   write(unsigned char);

  void setCursor(int x, int y);
  void setTextColor(unsigned int c);
  void setTextColor(unsigned int c, unsigned int bg);
  void setTextSize(unsigned char s);
  void setTextWrap(boolean w);

  int height(void);
  int width(void);

  void setRotation(unsigned char r);
  unsigned char getRotation(void);

 protected:
  int  WIDTH, HEIGHT;   // this is the 'raw' display w/h - never changes
  int  _width, _height; // dependent on rotation
  int  cursor_x, cursor_y;
  unsigned int textcolor, textbgcolor;
  unsigned char  textsize;
  unsigned char  rotation;
  boolean  wrap; // If set, 'wrap' text at right edge of display
};

#endif
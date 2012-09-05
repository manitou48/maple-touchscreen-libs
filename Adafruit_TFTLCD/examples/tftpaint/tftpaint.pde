#include <stdint.h>
#include "Adafruit_GFX.h"    // Core graphics library
#include "Adafruit_TFTLCD.h" // Hardware-specific library
#include "TouchScreen.h"


#define YP 18  // must be an analog pin
#define XM 17  // must be an analog pin
#define YM 9   // can be a digital pin
#define XP 8   // can be a digital pin

#define TS_MINX 635
#define TS_MINY 309
#define TS_MAXX 3600
#define TS_MAXY 3700

// For better pressure precision, we need to know the resistance
// between X+ and X- Use any multimeter to read it
// For the one we're using, its 300 ohms across the X plate
TouchScreen ts = TouchScreen(XP, YP, XM, YM, 361);

#define LCD_CS 18
#define LCD_CD 17
#define LCD_WR 16
#define LCD_RD 15 
// optional
#define LCD_RESET 14

// Color definitions
#define	BLACK           0x0000
#define	BLUE            0x001F
#define	RED             0xF800
#define	GREEN           0x07E0
#define CYAN            0x07FF
#define MAGENTA         0xF81F
#define YELLOW          0xFFE0 
#define WHITE           0xFFFF



//Adafruit_TFTLCD tft(LCD_CS, LCD_CD, LCD_WR, LCD_RD, LCD_RESET);
Adafruit_TFTLCD tft;

#define BOXSIZE 40
#define PENRADIUS 3
int oldcolor, currentcolor;

void setup(void) {
  SerialUSB.println("Paint!");
  
  tft.reset();
  
  uint16_t identifier = tft.readRegister(0x0);
  if (identifier == 0x9325) {
    SerialUSB.println("Found ILI9325");
  } else if (identifier == 0x9328) {
    SerialUSB.println("Found ILI9328");
  } else if (identifier == 0x7575) {
    SerialUSB.println("Found HX8347G");
  } else {
    SerialUSB.print("Unknown driver chip ");
    SerialUSB.println(identifier, HEX);
    while (1);
  }

  tft.begin(identifier); 
  tft.fillScreen(BLACK);
  
  tft.fillRect(0, 0, BOXSIZE, BOXSIZE, RED);
  tft.fillRect(BOXSIZE, 0, BOXSIZE, BOXSIZE, YELLOW);
  tft.fillRect(BOXSIZE*2, 0, BOXSIZE, BOXSIZE, GREEN);
  tft.fillRect(BOXSIZE*3, 0, BOXSIZE, BOXSIZE, CYAN);
  tft.fillRect(BOXSIZE*4, 0, BOXSIZE, BOXSIZE, BLUE);
  tft.fillRect(BOXSIZE*5, 0, BOXSIZE, BOXSIZE, MAGENTA);
 // tft.fillRect(BOXSIZE*6, 0, BOXSIZE, BOXSIZE, WHITE);
 
 tft.drawRect(0, 0, BOXSIZE, BOXSIZE, WHITE);
 currentcolor = RED;
 
  pinMode(13, OUTPUT);   // LED
}



#define MINPRESSURE 10
#define MAXPRESSURE 1000



void loop()
{
  Point p = ts.getPoint();

  // if you're sharing pins, you'll need to fix the directions of the touchscreen pins!
  //pinMode(XP, OUTPUT);
  pinMode(XM, OUTPUT);
  pinMode(YP, OUTPUT);
  //pinMode(YM, OUTPUT);

  // we have some minimum pressure we consider 'valid'
  // pressure of 0 means no pressing!

  if (p.z > MINPRESSURE && p.z < MAXPRESSURE) {
    /*
    SerialUSB.print("X = "); SerialUSB.print(p.x);
    SerialUSB.print("\tY = "); SerialUSB.print(p.y);
    SerialUSB.print("\tPressure = "); SerialUSB.println(p.z);
    */
    
    digitalWrite(13, HIGH);    // LED on, pen down
    if (p.y < (TS_MINY-5)) {
      SerialUSB.println("erase");
     // press the bottom of the screen to erase 
      tft.fillRect(0, BOXSIZE, tft.width(), tft.height()-BOXSIZE, BLACK);
      
    }
    // turn from 0->1023 to tft.width
    p.x = map(p.x, TS_MINX, TS_MAXX, tft.width(), 0);
    p.y = map(p.y, TS_MINY, TS_MAXY, tft.height(), 0);
    /*
    SerialUSB.print("("); SerialUSB.print(p.x);
    SerialUSB.print(", "); SerialUSB.print(p.y);
    SerialUSB.println(")");
    */
    if (p.y < BOXSIZE) {
       oldcolor = currentcolor;
 
  
       if (p.x < BOXSIZE) { 
         currentcolor = RED; 
         tft.drawRect(0, 0, BOXSIZE, BOXSIZE, WHITE);
       } 
       else if (p.x < BOXSIZE*2) {
         currentcolor = YELLOW; 
         tft.drawRect(BOXSIZE, 0, BOXSIZE, BOXSIZE, WHITE);
       }
       else if (p.x < BOXSIZE*3) {
         currentcolor = GREEN; 
         tft.drawRect(BOXSIZE*2, 0, BOXSIZE, BOXSIZE, WHITE);
       }
       else if (p.x < BOXSIZE*4) {
         currentcolor = CYAN; 
         tft.drawRect(BOXSIZE*3, 0, BOXSIZE, BOXSIZE, WHITE);
       }
       else if (p.x < BOXSIZE*5) {
         currentcolor = BLUE; 
         tft.drawRect(BOXSIZE*4, 0, BOXSIZE, BOXSIZE, WHITE);
       }
       else if (p.x < BOXSIZE*6) {
         currentcolor = MAGENTA; 
         tft.drawRect(BOXSIZE*5, 0, BOXSIZE, BOXSIZE, WHITE);
       }
       
       if (oldcolor != currentcolor) {
          if (oldcolor == RED) tft.fillRect(0, 0, BOXSIZE, BOXSIZE, RED);
          if (oldcolor == YELLOW) tft.fillRect(BOXSIZE, 0, BOXSIZE, BOXSIZE, YELLOW);
          if (oldcolor == GREEN) tft.fillRect(BOXSIZE*2, 0, BOXSIZE, BOXSIZE, GREEN);
          if (oldcolor == CYAN) tft.fillRect(BOXSIZE*3, 0, BOXSIZE, BOXSIZE, CYAN);
          if (oldcolor == BLUE) tft.fillRect(BOXSIZE*4, 0, BOXSIZE, BOXSIZE, BLUE);
          if (oldcolor == MAGENTA) tft.fillRect(BOXSIZE*5, 0, BOXSIZE, BOXSIZE, MAGENTA);
       }
    }
    if (((p.y-PENRADIUS) > BOXSIZE) && ((p.y+PENRADIUS) < tft.height())) {
      tft.fillCircle(p.x, p.y, PENRADIUS, currentcolor);
    }
  } else digitalWrite(13, LOW); 		// pen up LED off
}

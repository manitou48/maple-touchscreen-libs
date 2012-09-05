#include <stdint.h>
#include <Adafruit_GFX.h>    // Core graphics library
#include <Adafruit_TFTLCD.h> // Hardware-specific library


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

void setup(void) {
    while (!SerialUSB.available()){
		SerialUSB.println("hit key to proceed");
		delay(1000);
	}
    SerialUSB.read();
  SerialUSB.println("8 Bit LCD test!");
  
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

  SerialUSB.println("This is a test of the rotation capabilities of the TFT library!");
  SerialUSB.println("Press <SEND> (or type a character) to advance");
}

void loop(void) {
//  rotatePixel();   // hard to see
  rotateText();
  rotateLine();
  rotateFastline();
  rotateDrawrect();
  rotateFillrect();
  rotateDrawcircle();
  rotateFillcircle();
}

void rotateText() {
  for (uint8_t i=0; i<4; i++) {
    tft.fillScreen(BLACK);
    SerialUSB.println(tft.getRotation(), DEC);

    tft.setCursor(0, 30);
    tft.setTextColor(RED);  
    tft.setTextSize(1);
    tft.println("Hello World!");
    tft.setTextColor(YELLOW);
    tft.setTextSize(2);
    tft.println("Hello World!");
    tft.setTextColor(GREEN);
    tft.setTextSize(3);
    tft.println("Hello World!");
    tft.setTextColor(BLUE);
    tft.setTextSize(4);
    tft.print(1234.567);

    while (!SerialUSB.available());
    SerialUSB.read();
  
    tft.setRotation(tft.getRotation()+1);
  }
}

void rotateFillcircle(void) {
  for (uint8_t i=0; i<4; i++) {
    tft.fillScreen(BLACK);
    SerialUSB.println(tft.getRotation(), DEC);
  
    tft.fillCircle(10, 30, 10, YELLOW);
 
    while (!SerialUSB.available());
    SerialUSB.read();
  
    tft.setRotation(tft.getRotation()+1);
  }
}

void rotateDrawcircle(void) {
  for (uint8_t i=0; i<4; i++) {
    tft.fillScreen(BLACK);
    SerialUSB.println(tft.getRotation(), DEC);

    tft.drawCircle(10, 30, 10, YELLOW);
 
    while (!SerialUSB.available());
    SerialUSB.read();
  
    tft.setRotation(tft.getRotation()+1);
  }
}

void rotateFillrect(void) {
  for (uint8_t i=0; i<4; i++) {
    tft.fillScreen(BLACK);
    SerialUSB.println(tft.getRotation(), DEC);
  
    tft.fillRect(10, 20, 10, 20, GREEN);
 
    while (!SerialUSB.available());
    SerialUSB.read(); 
  
    tft.setRotation(tft.getRotation()+1);
  }
}


void rotateDrawrect(void) {
  for (uint8_t i=0; i<4; i++) {
    tft.fillScreen(BLACK);
    SerialUSB.println(tft.getRotation(), DEC);

  
    tft.drawRect(10, 20, 10, 20, GREEN);
 
    while (!SerialUSB.available());
    SerialUSB.read();
  
    tft.setRotation(tft.getRotation()+1);
  }
}


void rotateFastline(void) {
  for (uint8_t i=0; i<4; i++) {
    tft.fillScreen(BLACK);
    SerialUSB.println(tft.getRotation(), DEC);
  
    tft.drawFastHLine(0, 20, tft.width(), RED);
    tft.drawFastVLine(20, 0, tft.height(), BLUE);
  
    while (!SerialUSB.available());
    SerialUSB.read();
  
    tft.setRotation(tft.getRotation()+1);
  }
}


void rotateLine(void) {
  for (uint8_t i=0; i<4; i++) {
    tft.fillScreen(BLACK);
    SerialUSB.println(tft.getRotation(), DEC);

    tft.drawLine(tft.width()/2, tft.height()/2, 0, 0, RED);
    while (!SerialUSB.available());
    SerialUSB.read(); 
  
    tft.setRotation(tft.getRotation()+1);
  }
}

void rotatePixel(void) {
  for (uint8_t i=0; i<4; i++) {
    tft.fillScreen(BLACK);
    SerialUSB.println(tft.getRotation(), DEC);

    tft.drawPixel(10,20, RED);
    while (!SerialUSB.available());
    SerialUSB.read();
  
    tft.setRotation(tft.getRotation()+1);
  }
}

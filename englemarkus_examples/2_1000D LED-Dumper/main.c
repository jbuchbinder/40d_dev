#include "crc16.h"

#define DELAY_SYNC  400
#define DELAY_SPACE 100
#define DELAY0      100
#define DELAY1      200

#define LED_RED     0xC02200E0
#define LED_BLUE    0xC02200E8

#define STARTADRESSE   0xFFF80000
#define ANZAHL_BLOECKE 512  // nicht 500!
#define BLOCKLAENGE    1024

// Mist, da ist scheinbar ein Rechenfehler passiert... wir machen das ganze
// Dumpen nochmal...

// Zwischenschritte bei 512 Blöcken a 1024 Bytes (also 512 kb-Dateien):
// "0xFF800000 - 0xFF880000"
// "0xFF880000 - 0xFF900000"
// "0xFF900000 - 0xFF980000"
// "0xFF980000 - 0xFFA00000"
// "0xFFA00000 - 0xFFA80000"
// "0xFFA80000 - 0xFFB00000"
// "0xFFB00000 - 0xFFB80000"
// "0xFFB80000 - 0xFFC00000"
// "0xFFC00000 - 0xFFC80000"
// "0xFFC80000 - 0xFFD00000"
// "0xFFD00000 - 0xFFD80000"
// "0xFFD80000 - 0xFFE00000"
// "0xFFE00000 - 0xFFE80000"
// "0xFFE80000 - 0xFFF00000"
// "0xFFF00000 - 0xFFF80000"
// "0xFFF80000 - 0x100000000"  // wobei dann das letzte praktisch das 0. ist?

// Schaltet die blaue LED, die zum Blinken benutzt wird, ein.
void led_on() {
  *((volatile long*)LED_BLUE) = 0x46;
}

// Schaltet die blaue LED aus.
void led_off() {
  *((volatile long*)LED_BLUE) = 0x44;
}

// Schaltet die rote LED, die den Fortschritt anzeigt, um.
void toggle_red() {
  static unsigned char an = 0;
  volatile long* led = (void*)LED_RED;
  
  if (an == 0) {
    *led = 0x46;
    an = 1;
  } else {
    *led = 0x44;
    an = 0;
  }
}

// Verzögert um value.
void delay(int value) {
  for (int i = 0; i < value; i++) {
    asm ("nop\n");
    asm ("nop\n");
  }
}

// Blinkt ein Byte raus.
void send_byte(unsigned char b) {
  delay(DELAY_SYNC);

  for (int i = 0; i <= 7; i++) {
    led_on();
  
    if (b & (1 << i))
      delay(DELAY1);
    else
      delay(DELAY0);
  
    led_off();
  
    delay(DELAY_SPACE);
  }
}

int main() {
  // Erstmal eine kleine Pause...
  delay(155500);

  // Der String "0123456789\r\n" wird 300x gesendet...
  for (int i = 0; i < 300; i++) {
    send_byte('0');
    send_byte('1');
    send_byte('2');
    send_byte('3');
    send_byte('4');
    send_byte('5');
    send_byte('6');
    send_byte('7');
    send_byte('8');
    send_byte('9');
    send_byte('\r');
    send_byte('\n');
  }

  // Die Adresse, an der das Rausblinken beginnen soll.
  unsigned char *p = (void*)STARTADRESSE;

  for (int i = 0; i < ANZAHL_BLOECKE; i++) {
    // Die rote Status-LED umschalten.
    toggle_red();

    // Die Bytes 0x0A 0x55 0xAA 0x50 markieren den Anfang eines 1k-Blocks.
    send_byte(0x0A);
    send_byte(0x55);
    send_byte(0xAA);
    send_byte(0x50);

    // Als nächstes kommt die Adresse des Blocks.
    int t = (int)p;
    send_byte(t >> 0);
    send_byte(t >> 8);
    send_byte(t >> 16);
    send_byte(t >> 24);

    // Wir berechnen die Prüfsumme des kompletten Blocks.
    long crc = crc16(0, p, BLOCKLAENGE);

    // Sendet die einzelnen Bytes des aktuellen Blocks.
    for (int j = 0; j < BLOCKLAENGE; j++) {
      send_byte(*p++);
    }

  	// Sendet die CRC-Summe, die zum aktuellen Block gehört.
    send_byte(crc);
    send_byte(crc >> 8);
    send_byte(crc);
    send_byte(crc >> 8);
  }
        
  while (1) ;
}


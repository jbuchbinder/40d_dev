int main() {
  // Das ganze ist etwas verwirrend... was passiert, wenn man ein Byte an
  // einen Long Pointer schreibt? Dann sind doch die ersten drei Bytes am
  // Pointer Null, und erst pointer+3 ist dann der eigentliche Wert des Bytes?
  // Aber das hängt ja auch wieder von der Endianness ab?
  // Kann es also sein, dass p gleich dem Byte ist, und drei darauffolgende
  // 0 sind? 0x46 0x00 0x00 0x00 ?
  // Irgendwie macht das mit der Schleife nämlich keinen Sinn sonst!
  // Wenn man einen Byte Pointer nimmt, und an 0xC02200E0 schreibt, leuchtet
  // die rote LED... wenn man an 0xC02200E1 schreibt, dann auch ???
  
  // 0xC02200E0: Rote Card Access-LED
  // 0xC02200E8: Blaue Druck-LED
  
  // abgesucht: 0x00 - 0x200
  // Kann man auch die große LED finden? Sieht schlecht aus
  // irgendwo zwischen 0x200 und 0x300 rebootet die Kamera, wenn man rein-
  // schreibt... danach ist auch nichts mehr.
  
  for (int i = 0xC0220000; i <= 0xC02200FF; i++) {
    *((long*)((void*)i)) = 0x46;
  }

  while (1) ;
}


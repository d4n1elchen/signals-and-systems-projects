int oriPin = A0;
/* int ampPin = A1; */

int origin = 0;
/* int amped = 0; */

long start_time;

int btnPin = 4;
int btnPlotPin = 5;

void setup() {
  Serial.begin(115200);
  pinMode(btnPin, INPUT);
  pinMode(btnPlotPin, INPUT);
}

void loop() {
  if(digitalRead(btnPin)) {
    start_time = millis();
    while(digitalRead(btnPin)) {
      long time = millis() - start_time;
      origin = analogRead(oriPin);
      /* amped = analogRead(ampPin); */
      Serial.print(time);
      Serial.print(" ");
      Serial.println(volt(origin));
      /* Serial.print(" "); */
      /* Serial.println(volt(amped)); */
    }
  }
  if(digitalRead(btnPlotPin)) {
    while(digitalRead(btnPlotPin)) {
      origin = analogRead(oriPin);
      /* amped = analogRead(ampPin); */
      Serial.println(volt(origin));
      /* Serial.print(" "); */
      /* Serial.println(volt(amped)); */
    }
  }
  /* delay(10); */
}

float volt(int val) {
  return val/1023.0 * 5.0;
}

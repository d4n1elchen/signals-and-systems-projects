int outPin = A0;
int inPin = A1;

int input = 0;
int output = 0;

long start_time;

int btnPin = 4;

void setup() {
  Serial.begin(115200);
  pinMode(btnPin, INPUT);
}

void loop() {
  if(digitalRead(btnPin)) {
    start_time = millis();
    while(digitalRead(btnPin)) {
      long time = millis() - start_time;
      input = analogRead(inPin);
      output = analogRead(outPin);
      Serial.print(time);
      Serial.print(" ");
      Serial.print(volt(input));
      Serial.print(" ");
      Serial.println(volt(output));
    }
  }
  /* delay(10); */
}

float volt(int val) {
  return val/1023.0 * 5.0;
}

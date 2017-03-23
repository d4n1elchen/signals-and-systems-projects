int outPin = A0;
int inPin = A1;

int input = 0;
int output = 0;

int start_time;

void setup() {
  Serial.begin(115200);
  start_time = millis();
}

void loop() {
  time = millis() - start_time;
  input = analogRead(inPin);
  output = analogRead(outPin);
  Serial.print(time);
  Serial.print(" ");
  Serial.print(volt(input));
  Serial.print(" ");
  Serial.println(volt(output));
  /* delay(10); */
}

float volt(int val) {
  return val/1023.0 * 5.0;
}

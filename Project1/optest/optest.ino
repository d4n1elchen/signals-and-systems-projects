int outPin = A0;
int inPin = A1;

int input = 0;
int output = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  input = analogRead(inPin);
  output = analogRead(outPin);
  Serial.print(volt(input));
  Serial.print(" ");
  Serial.println(volt(output));
  /* delay(10); */
}

float volt(int val) {
  return val/1023.0 * 5.0;
}

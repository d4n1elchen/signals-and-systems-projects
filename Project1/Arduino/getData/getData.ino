#define STOP 0
#define START 1

int oriPin = A0;
/* int ampPin = A1; */

int origin = 0;
/* int amped = 0; */

long start_time;

int btnPin = 4;
int btnPlotPin = 5;

int status = STOP;

void setup() {
  Serial.begin(115200);
  pinMode(btnPin, INPUT);
  pinMode(btnPlotPin, INPUT);
}

void loop() {
  /* if(digitalRead(btnPin)) { */
  /*   while(digitalRead(btnPin)) { */
  /*     long time = micros(); */
  /*     origin = analogRead(oriPin); */
  /*     /1* amped = analogRead(ampPin); *1/ */
  /*     Serial.print(time); */
  /*     Serial.print(" "); */
  /*     Serial.println(volt(origin)); */
  /*     /1* Serial.print(" "); *1/ */
  /*     /1* Serial.println(volt(amped)); *1/ */
  /*   } */
  /* } */
  /* if(digitalRead(btnPlotPin)) { */
  /*   while(digitalRead(btnPlotPin)) { */
  /*     origin = analogRead(oriPin); */
  /*     /1* amped = analogRead(ampPin); *1/ */
  /*     Serial.println(volt(origin)); */
  /*     /1* Serial.print(" "); *1/ */
  /*     /1* Serial.println(volt(amped)); *1/ */
  /*   } */
  /* } */
  if(Serial.available() > 0) {
    String r = Serial.readString();
    if(r=="START") {
      status = START;
      start_time = micros();
    } else if(r=="STOP") {
      status = STOP;
    }
  }
  switch(status) {
    case START:
      origin = analogRead(oriPin);
      Serial.print("# ");
      Serial.print(micros()-start_time);
      Serial.print(" ");
      Serial.println(volt(origin));
      break;
  }
  /*     /1* Serial.print(" "); *1/ */
  /* delay(10); */
}

float volt(int val) {
  return val/1023.0 * 5.0;
}

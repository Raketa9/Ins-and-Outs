int firstSensor = 0;    
int secondSensor = 0;   
int thirdSensor = 0;    
int inByte = 0;         


void setup() {
  Serial.begin(9600); 
while (!Serial) {

    ; 

  }

  pinMode(4, INPUT);   

  establishContact();  
}


void loop() {


  if (Serial.available() > 0) {

    // get incoming byte:

    inByte = Serial.read();

    // read first analog input, divide by 4 to make the range 0-255:

    firstSensor = analogRead(A0) / 4;

    // delay 10ms to let the ADC recover:

    delay(10);

    // read second analog input, divide by 4 to make the range 0-255:

    secondSensor = analogRead(A1) / 4;

    // read switch, map it to 0 or 255L

    thirdSensor = map(digitalRead(8), 0, 1, 0, 255);

    // send sensor values:

    Serial.write(firstSensor);

    Serial.write(secondSensor);

    Serial.write(thirdSensor);

  }
}

void establishContact() {

  while (Serial.available() <= 0) {

    Serial.print('A');   // send a capital A

    delay(300);

  }
}

#define BUZZER 9
#define LDR 0
 
void setup()
{
  Serial.begin(9600);
}
 
void loop()
{
  // Obtenemos el valor de la entrada analógica de 0 a 1023
  int valor = analogRead(LDR);
 
  // Obtenemos la frecuencia en función del voltaje que entra
  // Este voltaje dependerá de la resitencia LDR y de la luz que incida sobre ella
  int frecuencia = 400 + (valor / 2);
 
  // Utilizamos la función tone para reproducir el sonido en el pin donde
  // tengamos conectado el buzzer y la frecuencia que queramos
  tone(BUZZER, frecuencia);
}

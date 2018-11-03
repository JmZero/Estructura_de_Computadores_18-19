# Práctica 2 - Programación Ensamblador x86-64 Linux


### 1. Sumar N enteros sin signo de 32 bits sobre dos registros de 32 bits usando uno de ellos como acumulador de acarreos (N≈16)
En este ejercicio se nos pide que utilicemos otro registro de 32 bits para almacenar el acarreo que se nos produce al realizar la suma en el primer registro. De esta forma con la concatenación de ambos registros tendremos un registro único de 64 bits (EDX:EAX).

Como se pide en el ejercicio, utilizaremos JNC e INC para saltar a otra rutina y para aumentar el contador de nuestro bucle.

[Código](https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/Codigo/media.s)

Resultados:
- En primer lugar probaremos con la secuencia de 16 valores **0x10000000** que en primera instancia de nuestro código no producía acarreo.
<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/img/media1.png" title="media.png"> </p>
- En segundo lugar cambiaremos este valor por **0xffffffff** que es el mayor valor de 32 bits que produce acarreo.
<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/img/media1.1.png" title="media1.png"> </p>
Como hemos podido ver en ambos resultados se ha conseguido subsanar el problema del acarreo.

### 2. Sumar N enteros sin signo de 32 bits sobre dos registros de 32 bits mediante extensión con ceros (N≈16)
En este ejercicio se nos pide modificar el anterior de tal manera que distingamos entre una parte más significativa y una menos significativa de manera que empecemos sumando las partes mas significativas y luego las menos significativas.

En este caso en lugar de utilizar JNC utilizaremos la orden ADC que sumará el acarreo (en el caso de que hubiera) en el registro EDX.

[Código](https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/Codigo/media2.s)

Resultados:
En este caso hemos realizado una bateria de test de manera que no tengamos que cambiar ningun valor manuelmente y se nos muestren todos los resultados de golpe.

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/img/media2.png" title="media2.png"> </p>

En los resultados veremos 2 errores, estos son los dados en el test 5 y 8. En el test 5 se debe a que estamos trabajando con enteros sin signo, por lo que el resultado siempre se nos mostrará como positivo. En el caso del test 8 no se pude guardar todo el valor dentro de un registro, por lo que se procederá truncarlo.

### 3. Sumar N enteros con signo de 32 bits sobre dos registros de 32 bits (mediante extensión de signo, naturalmente) (N≈16)
En este ejercicio trabajaremos con enteros con signo para subsanar los errores que se dan al trabajar con enteros negativos. Para solucionar esto utilizaremos la orden CLTD para extender EAX porque queremos trabajar con 2 registros, EDX y EAX de manera que nuestro valor se guardaría en el par de registros EDX:EAX.
Para llevar esto a cabo trabajaremos con otros 2 registros auxiliares sobre los que iremos realizando la suma.

[Código](https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/Codigo/media3.s)

Resultados:
Se ha cambiado la bateria de test por otra nueva.

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/img/media3.1.png" title="media3.1.png"> </p>

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/img/media3.2.png" title="media3.2.png"> </p>

En este caso los test 14 y 19 mostrarán errores debido a errores de interpretación o representación.

### 4. Media y resto de N enteros con signo de 32 bits calculada usando registros de 32 bits (N≈16)
Modificaremos el ejercicio anterior para calcular la media y el resto de la lista de números. Para ello una vez calculada la suma utilizaremos IDIV pasando como parámetro el registro que guarda el tamaño de la lista.

[Código](https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/Codigo/media4.s)

Resultados:
Se ha cambiado la bateria de test por otra nueva.

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/img/media4.1.png" title="media4.1.png"> </p>

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/img/media4.2.png" title="media4.2.png"> </p>

Debido a lo nombrado en el ejercicio anterior, los test 7 y 9 presentarán los mismos errores.

### 5. Media y resto de N enteros calculada en 32 y en 64 bits (N≈16)
Como ya se tiene creada la media en el ejercicio anterior para 32 bits, en este ejercicio solo se realiza la media en 64 bits para facilitar mejor la comprensión y ahorrarnos el crear una nueva subrutina.

[Código](https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica2/Codigo/media5.s)

**El ejercicio presenta errores y no imprime el resulto al final, por lo que no se podrán mostrar ejemplos de la salida**

### Diario de trabajo
- Semana 1-7 Octubre: Trabajar el tutorial de la práctica.
- Lunes 8 Ocubre: Ejercicio 1.
- Martes 9 Octubre: Ejercicio 2.
- Mércoles 10 Octubre: Solucionar dudas en clase y modificar los ejercicios ya realizados.
- Jueves 11 Octubre: Ejercicios 3, 4.
- Viernes 12 Octubre: Ejercicio 5 (no funciona correctamente).

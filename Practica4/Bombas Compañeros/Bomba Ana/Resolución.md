# Práctica 4: Modificación de bombas.

## Resolución de la bomba de Ana Maria Romero Delgado

**Contraseña:** ubdpadkk --> (despues del cifrado) tacobell

**Código:** 40230 --> (despues del cifrado) 31956

**Contraseña Modificada:** bbbbaaaa --> (despues del cifrado) aaaabbbb

**Código modificado:** 31956 --> (despues del cifrado) 21845

### Descubrir las claves
Para poder averiguar la contraseña pondremos un break point en **< main+119 >** que es donde se realiza la comprobación de entre la contraseña real y la que se ha introducido.

Como podemos observar antes de dicha comprobación se llama a una función **cambiarPassword** que supondremos que modificará la password que introducida.

En primer lugar introduciremos una contraseña cualquiera y esperaremos para ejecutar la orden `print(char[10])password` que nos dará como resultado la contraseña que andamos buscando. En este caso, la contraseña que buscamos es `tacobell`.

Procederemos a probar de nuevo, esta vez introduciendo la contraseña que hemos obtenido y una vez en el break point consultaremos los valores de los registros **rsi** y **rdi**.

```
p(char*)$rsi	# Contiene la contraseña (tacobell)
p(char*)$rdi	# Contiene la contraseña introducida
```

Los resultados que se obtienen son los siguientes:

```
(gdb) print(char*)$rsi
$1 = 0x601068 <password> "tacobell\n"

(gdb) print(char*)$rdi
$1 = 0x7fffffffdbf0 "s`bncfmm\n"
```

Como se ha supuesto la función **cambiarPassword** realiza una modificación a la contraseña introducida. En este caso a los primeros cuatro valores de la la contraseña se les esta disminuyendo su valor en 1, es decir, en caso de tener una b esta se sustituirá por una a. Para los segundos cuatro valores de la contraseña se kes está aumentando su valor en 1, es decir, en caso de tener una a se sustituirá por una b.
Todo esto lo averiguamos mirando el patron que sigue entre la contraseña introducida **tacobell** y la obtenida despues de la función **s`bncfmm**

En este caso, la contraseña a introducir es **ubdpadkk**

Para continuar, despues de la función **strncmp** modificaremos el registro eax para poder evitar llamar a la función **boom**.

```
set $eax=0
ni
ni
```

Ahora tendremos que saltar la explosión por superar el tiempo de la siguiente forma:

```
br *main+158
cont
set $eax=0
ni
ni
```

En este punto, para poder averiguar el código pondremos un break point en **< main+254 >**. En primer lugar introduciremos un código cualquiera y esperaremos para ejecutar la orden `print(int)passcode` que nos dará como resultado el código que andamos buscando. En este caso, el código que buscamos es `30119`.

Procederemos a probar de nuevo, esta vez introduciendo el código que hemos obtenido y una vez en el break point consultaremos el valor del registro **eax**.

```
p(int)$eax	# Contiene la contraseña introducida
```

El resultado que se obtienen es el siguiente:

```
(gdb) print(int)$eax
$3 = 20008
```
Como se puede ver, el código ha sido modificado de alguna forma. En este caso al numero introducido se le ha restado 10111.
Todo esto lo averiguamos mirando el patron que sigue entre el código introducido **30119** y la obtenido despues **20008**

En este caso, el código a introducir es **40230**

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica4/Bombas%20Compa%C3%B1eros/Bomba%20Ana/img/1.png" title="1.png"> </p>

## Modificación de la bomba

Para modificar la bomba se hará uso de **ghex**

En el caso de la contraseña, iremos a la opción Edit > Find > escribiremos tacobell en el lado derecho y buscaremos.
Ahora modificaremos **tacobell** por **aaaabbbb** en la derecha para que la contraseña a introducir pase a se **bbbbaaaa**.

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica4/Bombas%20Compa%C3%B1eros/Bomba%20Ana/img/2.png" title="2.png"> </p>

En el caso del cógido, convertiremos el valor **30119** a hexadecimal, que es **75A7** e iremos a la opción Edit > Find > escribiremos **A775** en el lado izquierdo y buscaremos (esto de debe a que el número está en little endian).
Ahora modificaremos **A775** por **5555** en la izquierda para que el código a introducir pase a ser **31956**.
<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica4/Bombas%20Compa%C3%B1eros/Bomba%20Ana/img/3.png" title="3.png"> </p>

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica4/Bombas%20Compa%C3%B1eros/Bomba%20Ana/img/4.png" title="4.png"> </p>

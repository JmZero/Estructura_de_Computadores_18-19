# Práctica 4: Modificación de bombas.

## Resolución de la bomba de Enrique Moreno Carmona

**Contraseña:** rdmcmnnckdr --> (despues del cifrado) sendnoodle

**Código:** 1800 --> (despues del cifrado) 420

**Contraseña Modificada:** aaaaaaaaaaa --> (despues del cifrado) bbbbbbbbbbb

**Código modificado:** 22280 --> (despues del cifrado) 20900

### Descubrir las claves
Para poder averiguar la contraseña pondremos un break point en **< main+119 >** que es donde se realiza la comprobación entre la contraseña real y la que se ha introducido.

Como podemos observar antes de dicha comprobación se llama a una función **transform**, que supondremos que modificará la password introducida.

En primer lugar introduciremos una contraseña cualquiera y esperaremos para ejecutar la orden `print(char[10])password`, que nos dará como resultado la contraseña que andamos buscando. En este caso, la contraseña que buscamos es `tacobell`.

Procederemos a probar de nuevo, esta vez introduciendo la contraseña que hemos obtenido y una vez en el break point consultaremos los valores de los registros **rsi** y **rdi**.

```
p(char*)$rsi	# Contiene la contraseña (tacobell)
p(char*)$rdi	# Contiene la contraseña introducida
```

Los resultados que se obtienen son los siguientes:

```
(gdb) print(char*)$rsi
$1 = 0x601068 <password> "sendnoodles\n"

(gdb) print(char*)$rdi
$1 = 0x7fffffffdb90 "tfoeoppemft\n"
```

Como se ha supuesto, la función **cambiarPassword** realiza una modificación a la contraseña introducida. En este caso a los primeros cuatro valores de la contraseña se les está disminuyendo su valor en 1, es decir, en caso de tener una b ésta se sustituirá por una a. Para los segundos cuatro valores de la contraseña se les está aumentando su valor en 1, es decir, en caso de tener una a se sustituirá por una b.
Todo esto lo averiguamos mirando el patrón que hay entre la contraseña introducida **tacobell** y la obtenida despues de la función **s`bncfmm**.

En este caso, la contraseña a introducir es **ubdpadkk**.

Para continuar, después de la función **strncmp** modificaremos el registro eax para poder evitar llamar a la función **boom**.

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

En este punto, para poder averiguar el código pondremos un break point en **< main+254 >**. En primer lugar introduciremos un código cualquiera y esperaremos para ejecutar la orden `print(int)passcode`, que nos dará como resultado el código que andamos buscando. En este caso, el código que buscamos es `420`.

Procederemos a probar de nuevo, esta vez introduciendo el código que hemos obtenido y una vez en el break point consultaremos el valor del registro **eax**.

```
p(int)$eax	# Contiene la contraseña introducida
```

El resultado que se obtienen es el siguiente:

```
(gdb) print(int)$eax
$3s = -960
```
Como se puede ver, el código ha sido modificado de alguna forma. En este caso, al número introducido se le ha restado 10111.
Todo esto lo averiguamos mirando el patrón que hay entre el código introducido **420** y el obtenido después **-960**.

En este caso, el código a introducir es **1800**.

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica4/Bombas%20Compa%C3%B1eros/Bomba%20Enrique/img/1.png" title="1.png"> </p>

## Modificación de la bomba

Para modificar la bomba se hará uso de **ghex**.

En el caso de la contraseña, iremos a la opción Edit > Find > escribiremos tacobell en el lado derecho y buscaremos.
Ahora modificaremos **tacobell** por **aaaabbbb** en la derecha para que la contraseña a introducir sea **bbbbaaaa**.

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica4/Bombas%20Compa%C3%B1eros/Bomba%20Enrique/img/2.png" title="2.png"> </p>

En el caso del código, convertiremos el valor **420** a hexadecimal, que es **1A4** e iremos a la opción Edit > Find > escribiremos **A401** en el lado izquierdo y buscaremos (esto de debe a que el número está en little endian).
Ahora modificaremos **A401** por **A451** en la izquierda para que el código a introducir pase a ser **20900**.
<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica4/Bombas%20Compa%C3%B1eros/Bomba%20Enrique/img/3.png" title="3.png"> </p>

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica4/Bombas%20Compa%C3%B1eros/Bomba%20Enrique/img/4.png" title="4.png"> </p>

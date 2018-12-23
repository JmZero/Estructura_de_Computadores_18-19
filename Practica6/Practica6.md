# Practica 6 - Cache

En esta práctica se lleva a cabo el cálculo del tamaño de linea de la caché y el tamaño de la propia caché del ordenador desde el que se estan haciendo las pruebas.

En primer lugar, tendremos que averiguar el tamaño de línea de caché. Para ello se usará la orden `make info`. Como se puede observar, el tamaño de línea de caché es de **64 B**.

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica6/img/makeinfo.png" title="makeinfo.png"> </p>

Esto tambien podremos verlo al buscar información de nuestro procesador en **cpu-world**. Para ello antes tendremos que obtener el modelo del procesador del ordenador mediante el comando `lscpu`.

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica6/img/lscpu.png" title="lscpu.png"> </p>

<p align="center"> <img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica6/img/cpu-world.png" title="cpu-world.png"> </p>

## Line.cc
Para calcular el tamaño de linea, se hará uso del siguiente código donde se ha añadido la linea `bytes [i] ^= 1;`:

[Código](https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica6/src/line.cc)

Haciendo uso del archivo make, se han generado la siguiente gráfica:

<img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica6/img/lineFast.png" title="lineFast.png"> </p>

Los datos de esta gráfica se corresponden con la velocidad de transpaso de información por la linea conforme aumenta el tamaño de esta.
Como se puede ver, hasta que alcanza un tamaño de linea de 64B la velocidad de cada operación se mantiene más o menos estable hasta llegar a ese punto, de donde podremos deducir que el tamaño de linea es de 64B. Esto se debe a que cuanto más aumenta el tamaño de la línea, mayor es la cantidad de información que puede pasar por ella, y por tanto la velocidad de transmisión se verá disminuida.

## Size.cc
Para calcular el tamaño de caché, se hará uso del siguiente código donde se ha añadido la linea `bytes [(i*64) & (size-1)] ^= 1;`:

[Código](https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica6/src/size.cc)

Haciendo uso del archivo make, se ha generado la siente gráfica:

<img src="https://github.com/JmZero/Estructura_de_Computadores_18-19/blob/master/Practica6/img/sizeFast.png" title="sizeFast.png"> </p>

Los datos de esta gráfica se corresponden con la velocidad de procesamiento de la información dependiendo del nivel de la caché.
Como se puede ver, hasta que alcanza un tamaño de 32KB se habrá pasado del nivel L1 de la caché al nivel L2, dado que se llena la caché. De la misma manera occurrirá cuando se llena la cache L2, saltará al nivel L3 aumentando el tiempo que tardará cuando alcance un tamaño de 2MB.
Como se puede ver en la imagen obtenida de cpu-world, los niveles de caché se corresponderan hasta 32K con el tamaño del nivel L1. De la misma forma, de ese punto a 256K se encontraría en el nivel L2 de caché. Por último, desde el punto anterior entre 2M y 4M se encontrará dentro del nivel L3 de la caché.

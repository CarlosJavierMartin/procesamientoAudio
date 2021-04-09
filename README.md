# procesamientoVideo

Autor: Carlos Javier Martín Perdomo

Descripción: Para esta practica he decidido crear una juego de memoria. Se tiene una interfaz con las instrucciones del juego y un teclado. Se dispone de varios niveles de dificultad asi como de distintos formatos de sonido. Cada vez que se enciende una tecla, esta emite un sonido caracteristico de cada tecla. La freceuncia de este sonido viene determinadapor una ecuacion improvisada que tiene como parametros las posiciones inicial y final de los ejes "x" e "y" ademas de tener en cuenta un numero asignado a cada tecla. Siendo la tecla de mas arriba a la izquierda arriba la 1 y la de mas a la derecha abajo la 16.

![ecuacion](https://latex.codecogs.com/svg.image?F(x,xFin,y,yFin,n)&space;=&space;\frac{(xFin&space;-&space;x)&space;*&space;n&space;-&space;yFin&space;-&space;y}{0.5*n})

Decisiones de código:
  - Se ha reutilizado el codigo visto en clase.
  - Se ha creado una clase myKey que representa las teclas del panel.
  
Resultado:

![error](https://github.com/CarlosJavierMartin/procesamientoAudio/blob/master/pa.gif?raw=true)

Acciones Realizadas
 - Se prueban todas las opciones
 - Se muestra una derrota
 - Se muestra una victoria

Referencias:
  - Recursos de programación:
    - https://processing.org/reference/
  - Libreria video de processing
  - Para la creacion del gif esta vez se ha usado una de las caracteristicas de la Xbox Game Bar que permite grabar ventanas: https://www.microsoft.com/es-es/p/xbox-game-bar/9nzkpstsnw4p?activetab=pivot:overviewtab
  - Para la transformacion de video a gif se ha usado la siguiente web: https://ezgif.com/video-to-gif
  - Para la ecuacion he usado un generador de ecuaciones en imagenes via URL: http://latex.codecogs.com/

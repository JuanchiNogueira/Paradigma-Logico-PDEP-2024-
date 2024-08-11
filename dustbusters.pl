%https://docs.google.com/document/d/1GBORNTd2fujNy0Zs6v7AKXxRmC9wVICX2Y-pr7d1PwE/edit#heading=h.tah786xadto6


%Informacion que me dan
herramientasRequeridas(ordenarCuarto, [[aspiradora(100),escoba], trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

%Punto1
tieneHerramienta(egon,aspiradora(200)).
tieneHerramienta(egon,trapeador).
tieneHerramienta(peter,trapeador).
tieneHerramienta(winston,varitaNeutrones).

%Punto2

tieneRequerida(Integrante,Herramienta):-
    tieneHerramienta(Integrante,Herramienta).

tieneRequerida(Integrante,aspiradora(PotenciaMinima)):-
    tieneHerramienta(Integrante,aspiradora(Potencia)),
    between(0,Potencia,PotenciaMinima).

%Punto3

puedeHacer(Integrante,Tarea):-
    herramientasRequeridas(Tarea,_),
    tieneHerramienta(Integrante,varitaNeutrones).

puedeHacer(Integrante,Tarea):-
    tieneHerramienta(Integrante,_),
    requiereHerramienta(Tarea,_),
    forall(requiereHerramienta(Tarea,Herramienta),tieneRequerida(Integrante,Herramienta)).

requiereHerramienta(Tarea,Herramienta):-
    herramientasRequeridas(Tarea,ListaHerramientas),
    member(Herramienta,ListaHerramientas).

%Punto 4

cobroPedido(Cliente,Tareas,PrecioTotal):-
    tareaPedida(Cliente,_,_),
    precioTareas(Cliente,Tareas,PrecioTotal).

precioTareas(Cliente,Tareas,PrecioTotal):-
    findall(Tareas,calcularPrecio(Cliente,_,Precio),Precios),
    sum_list(Precios,PrecioTotal).

calcularPrecio(Cliente,Tarea,Precio):-
    tareaPedida(Cliente,Tarea,Metros),
    precio(Tarea,PrecioXmetro),
    Precio is Metros * PrecioXmetro.

%Punto 5

aceptoPedido(Integrante,Cliente):-
    tareaPedida(Tarea,Cliente,_),
    puedeHacer(Integrante,Tarea),
    dispuestoAceptar(Integrante,Cliente).

dispuestoAceptar(ray,Cliente):-
    not(tareaPedida(limpiarTecho,Cliente,_)).

dispuestoAceptar(winston,Cliente):-
    cobroPedido(Cliente,_,Pago),
    Pago >= 500.

dispuestoAceptar(egon,Cliente):-
    tareaPedida(Tarea,Cliente,_),
    not(tareaCompleja(Tarea)).

dispuestoAceptar(peter,_).

tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea,Herramientas),
    lenght(Herramientas)>=2.

/*
Por qué para este punto no bastaba sólo con agregar un nuevo 
hecho?
Con nuestra definición de puedeHacerTarea verificabamos con un 
forall que una persona posea todas las herramientas que requería
una tarea; pero sólo ligabamos la tarea. Entonces Prolog hubiera
matcheado con ambos hechos que encontraba, y nos hubiera devuelto
las herramientas requeridas presentes en ambos hechos.
Una posible solución era, dentro de puedeHacerTarea, también ligar
las herramientasRequeridas antes del forall, y así asegurarnos que
el predicado matcheara con una única tarea a la vez.
Cual es la desventaja de esto? Para cada nueva herramienta remplazable
deberíamos contemplar todos los nuevos hechos a generar para que 
esta solución siga funcionando como queremos.
Se puede hacer? En este caso sí, pero con el tiempo se volvería costosa.
La alternativa que planteamos en esta solución es agrupar en una lista
las herramientas remplazables, y agregar una nueva definición a 
satisfaceNecesidad, que era el predicado que usabamos para tratar
directamente con las herramientas, que trate polimorficamente tanto
a nuestros hechos sin herramientas remplazables, como a aquellos que 
sí las tienen. También se podría haber planteado con un functor en vez
de lista.
Cual es la ventaja? Cada vez que aparezca una nueva herramienta
remplazable, bastará sólo con agregarla a la lista de herramientas
remplazables, y no deberá modificarse el resto de la solución.
Notas importantes:
I) Este enunciado pedía que todos los predicados fueran inversibles
Recordemos que un predicado es inversible cuando 
no necesitás pasar el parámetro resuelto (un individuo concreto), 
sino que podés pasar una incógnita (variable sin unificar).
Así podemos hacer tanto consultas individuales como existenciales.
II) No siempre es conveniente trabajar con listas, no abusar de su uso.
	En general las listas son útiles sólo para contar o sumar muchas cosas
	que están juntas.
III) Para usar findall es importante saber que está compuesto por 3 cosas:
		1. Qué quiero encontrar
		2. Qué predicado voy a usar para encontrarlo
		3. Donde voy a poner lo que encontré
IV) Todo lo que se hace con forall podría también hacerse usando not.
*/





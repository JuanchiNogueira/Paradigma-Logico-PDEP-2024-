% https://docs.google.com/document/d/1RNgFMlSqOKiwe9SEi1U2cQjCmdFfWNflqycSfp7Qa-w/edit#heading=h.8z5fk89ui0rg


atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,viernes,9,15).

atiende(lucas,martes,10,20).

atiende(juanC,sabados,18,22).
atiende(juanC,domingos,18,22).

atiende(juanFdS,jueves,10,20).
atiende(juanFdS,viernes,12,20).

atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).

atiende(martu,miercoles,23,24).

%Punto 1

atiende(vale,Dia,HorarioInicio,HorarioFinal):-
    atiende(dodain,Dia,HorarioInicio,HorarioFinal).

atiende(vale,Dia,HorarioInicio,HorarioFinal):-
    atiende(juanC,Dia,HorarioInicio,HorarioFinal).
    
%No hace falta agregar nada para el caso de leoC y Maiu (principio de universo cerrado)

%Punto 2
quienAtiende(Persona,Dia,Hora):-
    atiende(Persona,Dia,HoraInicio,HorarioFinal),
    between(HoraInicio, HorarioFinal, Hora).
    
%Punto 3

foreverAlone(Persona,Dia,Hora):-
    quienAtiende(Persona,Dia,Hora),
    not((quienAtiende(Persona1,Dia,Hora),Persona1 \= Persona)).

%Punto 4

posibilidadesAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona, quienAtiende(Persona, Dia, _)), PersonasPosibles),
    combinar(PersonasPosibles, Personas).
  
  combinar([], []).
  combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
  combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).
  

% Qué conceptos en conjunto resuelven este requerimiento
    % - findall como herramienta para poder generar un conjunto de soluciones que satisfacen un predicado
    % - mecanismo de backtracking de Prolog permite encontrar todas las soluciones posibles

%Punto 5

venta(dodain,fecha(lunes,10,agosto),[golosinas(1200),cigarrillos(jockey),golosinas(50)]).
venta(dodain,fecha(miercoles,12,agosto),[bebidas(true,8),bebidas(true,1),golosinas(10)]).

venta(martu,fecha(miercoles,12,agosto),[golosinas(1000),cigarrillos(chesterfield),cigarrillos(colorado),cigarrillos(parisiennes)]).

venta(lucas,fecha(martes,11,agosto),[golosinas(600)]).
venta(lucas,fecha(martes,18,agosto),[bebidas(false,2),cigarrillos(derby)]).

personaSuertuda(Persona):-
    vendedora(Persona),
    forall(venta(Persona, _, [Venta|_]), ventaImportante(Venta)).
  
  vendedora(Persona):-venta(Persona, _, _).
  
ventaImportante(golosinas(Precio)):-Precio > 100.
ventaImportante(cigarrillos(Marcas)):-length(Marcas, Cantidad), Cantidad > 2.
ventaImportante(bebidas(true, _)).
ventaImportante(bebidas(_, Cantidad)):-Cantidad > 5.






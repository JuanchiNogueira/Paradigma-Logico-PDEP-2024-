persona(nina,joven,22,1.60).
persona(marcos,niño,8,1.32).
persona(osvaldo,adolescente,13,1.29).

tieneAtraccion(parqueDeLaCosta,trenFantasma).
tieneAtraccion(parqueDeLaCosta,montaniaRusa).
tieneAtraccion(parqueDeLaCosta,maquinaTiquetera).
tieneAtraccion(parqueAcuatico,toboganGigante).
tieneAtraccion(parqueAcuatico,rioLento).
tieneAtraccion(parqueAcuatico,piscinaDeOlas).

requisito(trenFantasma,edad(12)).
requisito(montaniaRusa,altura(1.3)).
requisito(toboganGigante,altura(1.5)).
requisito(piscinaDeOlas,edad(5)).

puedeSubir(Persona,Atraccion):-
    persona(Persona,_,_,_),
    tieneAtraccion(_,Atraccion),
    requisito(Atraccion,Requisito),
    cumpleRequisito(Requisito,Persona).

cumpleRequisito(edad(Minima),Persona):- persona(Persona,_,Edad,_),Edad>=Minima.
cumpleRequisito(altura(Minima),Persona):- persona(Persona,_,_,Altura),Altura>=Minima.
 
esParaElle(Persona,Parque):-
    persona(Persona,_,_,_),
    tieneAtraccion(Parque,_),
    forall(tieneAtraccion(Parque,Atraccion),puedeSubir(Persona,Atraccion)).

malaIdea(persona(_,GrupoEtario,_,_),Parque):-
    tieneAtraccion(Parque,_),
    not(hayUnaAtraccionParaTodes(GrupoEtario,Parque)).

hayUnaAtraccionParaTodes(Grupo,Parque):-
    tieneAtraccion(Parque,Atraccion),
    forall(Grupo,puedeSubir(Persona,Atraccion)).

%---------

programaLogico(Programa):-
    enElMismoParque(Programa),
    sinRepetidos(Programa).

enElMismoParque(Programa):-
    tieneAtraccion(Parque,_),
    forall(member(Actraccion,Programa),member(Atraccion,atracciones(Parque))).

atracciones(Parque):-
    tieneAtraccion(Parque,_),
    findall(Parque,tieneAtraccion(Parque,Atraccion),Atracciones).

sinRepetidos([]).
sinRepetidos([Cabeza|Cola]):-
    not(member(Cabeza,Cola)),
    sinRepetidos(Cola).

hastaAca(_,[],[]).
hastaAca(P,[X|_],[]):- not(puedeSubir(P,X)).
hastaAca(P,[X|XS],[X|YS]):- puedeSubir(P,X),hastaAca(P,XS,YS).

/*
puedeSubirPasaporte(Persona,Atraccion):-
    puedeSubir(Persona,Atraccion),
    tienePasaporte(Persona,Pasaporte),
    habilita(Pasaporte,Atraccion).

habilita(flex(Credito,Atraccion),Atraccion):-
    juegoPremium(Atraccion).
habilita(flex(Credito,_),Atraccion):-
    habilita(basico(Credito),Atraccion).

juegoComun(trenFantasma,5).
juegoComun(maquinaTiquetera,2).
juegoComun(rioLento,3).
juegoComun(piscinaDeOlas,4).

juegoPremium(montaniaRusa).
juegoPremium(toboganGigante).

La verdad no se entiende nada este parcial
*/
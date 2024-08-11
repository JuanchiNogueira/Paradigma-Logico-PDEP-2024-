%https://docs.google.com/document/d/1xbXPZnhwyK5FSHR_oaXU4esfkTd2S-jf3rH1XLw864M/edit
%modelaje

canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever,5)).

novedoso(Cantante):- 
    sabeAlMenosDosCanciones(Cantante),
    tiempoTotalCanciones(Cantante, Tiempo),
    Tiempo < 15.
    
sabeAlMenosDosCanciones(Cantante):-
        canta(Cantante, UnaCancion),
        canta(Cantante, OtraCancion),
        UnaCancion \= OtraCancion.
    
tiempoTotalCanciones(Cantante, TiempoTotal):-
    findall(TiempoCancion, tiempoDeCancion(Cantante, TiempoCancion), Tiempos), sumlist(Tiempos,TiempoTotal).
    
tiempoDeCancion(Cantante,TiempoCancion):-  
          canta(Cantante,Cancion),
          tiempo(Cancion,TiempoCancion).
    
tiempo(cancion(_, Tiempo),Tiempo).

 %Punto 2

 vocaloid(Cantante):-
    canta(Cantante,_).

cantanteAcelerado(Cantante):-
    vocaloid(Cantante),
    not((tiempoDeCancion(Cantante,Tiempo),Tiempo>4)).

cumpleCantidadCanciones(Cantante,Numero):-
    findall(Cantante,canta(Cantante,cancion(Cancion,_)),Canciones),
    length(Canciones) > Numero.


concierto(mikuExpo,2000,gigante(2,6)).
concierto(magicalMirai,3000,gigante(3,10)).
concierto(vockalektVisions,1000,mediano(9)).
concierto(mikuFest,100,pequenio(4)).

participar(Cantante, Concierto):-
    vocaloid(Cantante),
    Cantante \= hatsuneMiku,
    concierto(Concierto,_,Requisitos),
    cumpleRequisitos(Cantante,Requisitos).

cumpleRequisitos(Cantante,gigante(CantCanciones,TiempoMinimo)):-
    cumpleCantidadCanciones(Cantante,CantCanciones),
    tiempoTotalCanciones(Cantante,Duracion),Duracion>=TiempoMinimo.

cumpleRequisitos(Cantante,mediano(TiempoMinimo)):-
    tiempoTotalCanciones(Cantante,Duracion),Duracion>=TiempoMinimo.

cumpleRequisitos(Cantante,pequenio(TiempoMinimo)):-
    canta(Cantante,Cancion),
    tiempo(Cancion,Tiempo),
    Tiempo>=TiempoMinimo.

famaConciertos(Cantante,FamaGanada):-
    vocaloid(Cantante),
    findall(Cantante,participar(Cantante,concierto(_,Fama,_)),NivelFama),
    sum_list(NivelFama,FamaGanada).

cantidadCanciones(Cantante,Numero):-
    vocaloid(Cantante),
    findall(Cantante,canta(Cantante,Cancion),Canciones),
    Numero is lenght(Canciones).

famaTotal(Cantante,NivelFama):-
    vocaloid(Cantante),
    famaConciertos(Cantante,FamaGanada),
    cantidadCanciones(Cantante,Numero),
    NivelFama is FamaGanada * Numero.

vocaloidMasFamoso(Cantante):-
    famaTotal(Cantante,NivelFamosisimo),
    forall(famaTotal(_,Nivel),NivelFamosisimo>=Nivel).

conoce(megurineLuka,hatsuneMiku).
conoce(megurineLuka,gumi).
conoce(gumi,seeU).
conoce(seeU,kaito).


tocaSolo(Cantante,Concierto):-
    participar(Cantante,Concierto).
    not(conocido(Cantante,OtroCantante,participar(OtroCantante,Concierto))).

conocido(Cantante,OtroCantante):-
    conoce(Cantante,OtroCantante).

conocido(Cantante,OtroCantante):-
    conoce(Cantante,Conocido),
    conoce(Conocido,OtroCantante).

%Simplemente habria que agregar sus requisitos en la funcion Cumple requisitos, esto
%se debe al concepto de polimorfismo que nos permite dar un tratamiento en particular a cada uno de los conciertos en la cabeza de la clausula

cancion(bailanSinCesar, [pabloIlabaca, rodrigoSalinas], 10600177).
cancion(yoOpino, [alvaroDiaz, carlosEspinoza, rodrigoSalinas], 5209110).
cancion(equilibrioEspiritual, [danielCastro, alvaroDiaz, pabloIlabaca, pedroPeirano, rodrigoSalinas], 12052254).
cancion(tangananicaTanganana, [danielCastro, pabloIlabaca, pedroPeirano], 5516191).
cancion(dienteBlanco, [danielCastro, pabloIlabaca, pedroPeirano], 5872927). 
cancion(lala, [pabloIlabaca, pedroPeirano], 5100530).
cancion(meCortaronMalElPelo, [danielCastro, alvaroDiaz, pabloIlabaca, rodrigoSalinas], 9428854).

rankingTop3(febrero, 1, lala).
rankingTop3(febrero, 2, tangananicaTanganana).
rankingTop3(febrero, 3, meCortaronMalElPelo).
rankingTop3(marzo, 1, meCortaronMalElPelo).
rankingTop3(marzo, 2, tangananicaTanganana).
rankingTop3(marzo, 3, lala).
rankingTop3(abril, 1, tangananicaTanganana).
rankingTop3(abril, 2, dienteBlanco).
rankingTop3(abril, 3, lala).
rankingTop3(abril, 3, equilibrioEspiritual).
rankingTop3(mayo, 1, meCortaronMalElPelo).
rankingTop3(mayo, 2, dienteBlanco).
rankingTop3(mayo, 2, lala).
rankingTop3(mayo, 3, equilibrioEspiritual).
rankingTop3(junio, 1, dienteBlanco).
rankingTop3(junio, 2, tangananicaTanganana).
rankingTop3(junio, 3, lala).

%Punto 1

cancionHit(Cancion):-
    cancion(Cancion,_,_),
    forall(rankingTop3(Mes,_,_),rankingTop3(Mes,_,Cancion)).

%Punto 2

noReconocida(Cancion):-
    cancion(Cancion,_,Visualizaciones),
    forall(rankingTop3(Mes,_,_),not(rankingTop3(Mes,_,Cancion))),
    Visualizaciones > 7000000.

%Punto 3
colaboradores(Artista1,Artista2):-
    cancion(Cancion,Artistas,_),
    member(Artista1,Artistas),
    member(Artista2,Artistas),
    Artista1 \= Artista2.

%Punto 4

trabajador(tulio,conductor(5)).
trabajador(bodoque,periodista(2,licenciatura)).
trabajador(bodoque,reportero(5,300)).
trabajador(juanin,conductor(0)).

%Punto 

sueldoTotal(Persona,SueldoTotal):-
    trabajador(Persona,_),
    findall(Sueldo,sueldoSegunTrabajo(Persona,Sueldo),Sueldos),
    sum_list(Sueldos,SueldoTotal).

sueldoSegunTrabajo(Persona,Sueldo):-
    trabajador(Persona,TipoTrabajo),
    sueldo(TipoTrabajo,Sueldo).

sueldo(conductor(Experiencia),Sueldo):-
    Sueldo is Experiencia*10000.

sueldo(reportero(Experiencia,Notas),Sueldo):-
    Sueldo is Experiencia*10000 + Notas*100.

sueldo(periodista(Experiencia,Titulo),Sueldo):-
    tieneTitulo(Titulo,Valor),
    Sueldo is Experiencia * 5000 * Valor.

tieneTitulo(licenciatura,1.2).
tieneTitulo(posgrado,1.35).

%Punto 6

%Panelista(Experiencia,Programas donde trabaja)
trabajador(renzo,panelista(10,3)).

sueldo(panelista(Experiencia,Programas),Sueldo):-
    Sueldo is Experiencia*20+Programas*90.

    

%---------------------------------------------------------------------------------------------------------------------
%	Objetivo: Resolver con el MEF el modelo no tan simple:
%
%			dC/dt = E*C'' - U*C' - k*C + f(t)*dirac(x-p), para x\in I=[0,L], t\in I=[0,t]
%
%	Con condiciones:
%
%			C(x,0) = 0
%			C'(0,t) = 0
%			C'(L,t) = 0.
%
%	Funciones externas:
%
%			MassAssembler1D                                                                            
%			StiffnessAssembler1D
%			LoadAssembler1D (Dirac version)
%
%	Datos entrada:
%			E	- Escalar, Coeficiente de difusividad
%			U	- Escalar, velocidad del fluido en el rio
%			k	- Escalar, razon temporal de "desintegracion" del contaminante 
%			L	- Escalar, longitud del intervalo espacial
%			Nx	- Entero, numero de nodos espaciales
%			T	- Escalar, longitud del intervalo temporal			
%			Nt	- Entero, numero de nodos temporales                                              
%			f	- Matlab anonimous function, forzamiento externo del modelo (contaminante)
%			p	- Float, punto donde se vierte contaminante p\in [0,L]
%
%	Datos de salida:
%
%			M	- Matriz (Nx x Nx), matriz de masa
%			A	- Matriz (Nx x Nx), matriz de rigidez
%			D	- Matriz (Nx x Nx), matriz de adveccion
%			b	- Vector (Nx x 1), vector de peso
%			x	- Vector (Nx x 1), coordenadas de los nodos de la malla \mathcal(I)
%			uh	- Matriz (Nx x 1,Nt), aproximacion del MEF a la solucion "u" en cada nodo
%
% Fecha elaboracion: 18/Oct/2018
% Ultima actualizacion: 18/Oct/2018
%---------------------------------------------------------------------------------------------------------------------
function ModelSolver1D()

% Incializacion de parametros
E = 0.1;	U = 0.5;	k = 0.5;
L = 10;		Nx = 20;
T = 10;		Nt = 10;

% Punto donde se añade el contaminante
p = L / 2;
dx = L / (Nx - 1);
x = 0:dx:L;

% Vector "temporal"
dt = T / (Nt - 1);
t = 0:dt:T;

f = @(t) cos(t);

% Calculo de las matrices necesarias para la solucion

M = MassAssembler(x);
A = StiffnessAssembler1D(x);
b = LoadAssembler1D(x,f,p);

b(n,1) = b(n,1) + gN;
u0 = 0;
uh = A\b;
plot(x,uh)

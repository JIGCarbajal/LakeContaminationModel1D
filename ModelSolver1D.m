%---------------------------------------------------------------------------------------------------------------------
%	Objetivo: Resolver el modelo:
%
%			        dC/dt = E*C'' - U*C' - k*C + f(t)*dirac(x-p), para x\in I=[0,L], t\in I=[0,t]
%
%	          Con condiciones:
%
%			        C(x,0) = 0
%			        C'(0,t) = d1
%			        C'(L,t) = d2.
%
%           Calculando la parte espacial de la solucion con MEF y la parte temporal
%           con el metodo de diferencias finitas usando euler hacia atras.
%
%	Funciones externas:
%
%			      MassAssembler1D                                                                            
%			      StiffnessAssembler1D
%			      LoadAssembler1D (Dirac version)
%           AdvectionAssembler1D
%
%	Datos entrada:
%			      E   - Escalar, Coeficiente de difusividad
%			      U 	- Escalar, velocidad del fluido en el rio
%			      k 	- Escalar, razon temporal de "desintegracion" del contaminante 
%			      L 	- Escalar, longitud del intervalo espacial
%			      Nx	- Entero, numero de nodos espaciales
%			      T 	- Escalar, longitud del intervalo temporal			
%			      Nt	- Entero, numero de nodos temporales                                              
%			      f 	- Matlab anonimous function, forzamiento externo del modelo (contaminante)
%			      p 	- Float, punto donde se vierte contaminante p\in [0,L]
%
%	Datos de salida:
%			      M	  - Matriz (Nx x Nx), matriz de masa
%			      A	  - Matriz (Nx x Nx), matriz de rigidez
%			      D	  - Matriz (Nx x Nx), matriz de adveccion
%			      b	  - Vector (Nx x 1), vector de peso
%			      x	  - Vector (Nx x 1), coordenadas de los nodos de la malla \mathcal(I)
%			      uh  - Matriz (Nx x Nt), aproximacion del MEF a la solucion "u" en cada nodo en cada instante
%
% Fecha elaboracion: 18/Oct/2018
% Ultima actualizacion: 20/Oct/2018
%---------------------------------------------------------------------------------------------------------------------
function [x, uh] = ModelSolver1D()
%===============================================================================
% Incializacion de parametros del modelo
%===============================================================================
E = 0.5;	U = 1;	k = 0.1;  % Parametros dinamicos del modelo
L = 10;		Nx = 200;         % Longitud y numero de nodos espaciales
T = 30;		Nt = 200;         % Longitud y numero de nodos temporales

d1 = 0;    d2 = 0;            % Condiciones de derivada en las fronteras 

f = @(t) 1 + sin(t) ;             % Funcion de forzamiento del contaminante
p = 4 * L / 8;              % Punto donde se añade el contaminante

%===============================================================================
% Calculo de constantes necesarias
%===============================================================================
% Vector "espacial"
dx = L / (Nx - 1);
x = 0:dx:L;

% Calculo del indice donde se encuentra la fuente del contaminante
ind = 0;
for i=1:Nx-1
	if(x(i) <= p)
		if(x(i+1) > p)
			ind = i;
			break;
		end
	end	
end

% Vector "temporal"
dt = T / (Nt - 1);
t = 0:dt:T;
%===============================================================================
% Calculo de las matrices necesarias para la solucion
%===============================================================================
M = MassAssembler1D(x);
A = StiffnessAssembler1D(x);
D = AdvectionAssembler1D(x);
% jaja Mad... xD

%===============================================================================
% Ciclo de calculo temporal para euler hacia atras
%===============================================================================
uh = zeros(Nx,Nt); % Condicion inicial de ceros
%uh(floor(end/4):floor(3*end/4),1) = 5.0; % Condicion inicial

for i=2:Nt
  b = LoadAssembler1D(x,ind,f,t(i));
  b(1) = -d1;
  b(end) = d2;
  R = E*A + U*D + k*M; 
  uh(:,i) = inv(M+dt*R)*(dt*b + M*uh(:,i-1));
end

figure(2)
[X,T] = meshgrid(x,t);
surfc(X',T',uh,'EdgeColor','interp')
xlabel('x_k');ylabel('t^n');zlabel('u^n_{h,k}')


end


%---------------------------------------------------------------------------------------------------------------------
%   Objetivo: Ensamblar el vector de peso b de la ecuacion diferencial ordinaria
%                       M \dot{\xi} + R \xi = b(t).
%           Las entradas de b estan dadas por las integrales
%                       \int_I f(t)\delta(x-p) \varphi_i dx, para i=1,...,n
%           para este caso todos los elementos de la integral se eliminan excepto cuando
%           el punto "p" se encuentra en el intevalo [x_i,x_i+1] para una i
%
%   Datos entrada:                                                                                                                               
%           x   - Vector, nodos de la malla
%           ind - Entero, Indice del nodo donde se encuentra el punto "p"
%           f   - Matlab anonimous function de t, funcion de forzamiento del contaminante
%           t   - flotante,  Instante donde se calculara el vector
%   Datos salida:
%           b   - Vector, Vector de peso en el instante "t"
% Fecha elaboracion: 18/oct/2016
% Ultima actualizacion: 20/oct/2016
%---------------------------------------------------------------------------------------------------------------------                   
function b = LoadAssembler1D(x,ind,f,t)
n=length(x);
b=zeros(n,1);

b(ind) = f(t);

end
%---------------------------------------------------------------------------------------------------------------------
%   Objetivo: Ensamblar la matriz de masa "M" para un sistema de "n" elementos. 
%             Las entradas de las submatrices "M^k" estan dadas por las integrales
%                
%                            | 2  1 |
%                      M^k = |      | h/6 ,   k = 1,...,n-1
%                            | 1  2 |
%
%   Datos entrada:                                                                                                                               
%           x   - Vector, nodos de la malla
%   Datos salida:
%           M   - Matriz, matriz de masa del sistema
% Fecha elaboracion: 18/oct/2016
% Ultima actualizacion: 20/oct/2016
%---------------------------------------------------------------------------------------------------------------------                   
function M = MassAssembler1D(x)
n=length(x); % # de nodos de la malla
M=zeros(n,n); % inicializamos la matriz de masa
for i=1:n-1
    h = (x(i+1) - x(i))/6;
    M(i,i) = M(i,i) + 2*h;
    M(i,i+1) = M(i,i+1) + 1*h;
    M(i+1,i) = M(i+1,i) + 1*h;
    M(i+1,i+1) = M(i+1,i+1) +2*h;
end
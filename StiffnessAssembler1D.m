%---------------------------------------------------------------------------------------------------------------------
%   Objetivo: Ensamblar la matriz de rigidez "A" para un sistema de "n" elementos. 
%             Las entradas de las submatrices "A^k" estan dadas por las integrales
%                
%                            | 1  -1 |
%                      A^k = |       | 1/h ,   k = 1,...,n-1
%                            |-1   1 |
%
%   Datos entrada:                                                                                                                               
%           x   - Vector, nodos de la malla
%   Datos salida:
%           A   - Matriz, matriz de rigidez del sistema
% Fecha elaboracion: 18/oct/2016
% Ultima actualizacion: 20/oct/2016
%---------------------------------------------------------------------------------------------------------------------                   
function A=StiffnessAssembler1D(x)
n=length(x); % # de elementos de la malla
A=sparse(n,n); % inicializacion la matriz de rigidez
for i=1:n-1
    h = x(i+1) - x(i);
    A(i,i) = A(i,i) + 1/h;
    A(i,i+1) = A(i,i+1) - 1/h;
    A(i+1,i) = A(i+1,i) - 1/h;
    A(i+1,i+1) = A(i+1,i+1) +1/h;
end
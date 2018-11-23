%---------------------------------------------------------------------------------------------------------------------
%   Objetivo: Ensamblar la matriz de adveccion "D" para un sistema de "n" elementos. 
%             Las entradas de las submatrices "D^k" estan dadas por las integrales
%                
%                            |-1   1 |
%                      D^k = |       | 1/2 ,   k = 1,...,n-1
%                            |-1   1 |
%
%   Datos entrada:                                                                                                                               
%           x   - Vector, nodos de la malla
%   Datos salida:
%           D   - Matriz, matriz de adveccion del sistema
% Fecha elaboracion: 18/oct/2016
% Ultima actualizacion: 28/oct/2016
%---------------------------------------------------------------------------------------------------------------------                   
function D = AdvectionAssembler1D(x)
n = length(x); % # de nodos de la malla
D = zeros(n,n); % inicializamos la matriz de masa
for i=1:n-1
    D(i,i) = D(i,i) - 1/2;
    D(i,i+1) = D(i,i+1) + 1/2;
    D(i+1,i) = D(i+1,i) - 1/2;
    D(i+1,i+1) = D(i+1,i+1) + 1/2;
end
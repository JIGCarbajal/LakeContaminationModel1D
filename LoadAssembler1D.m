%---------------------------------------------------------------------------------------------------------------------
% Objetivo: Ensamblar el vector de peso b del sistema de ecuaciones lineales
%                                                     A \xi = b.
%                   Las entradas de b estan dadas por las integrales
%                                  \int_I f \varphi_i dx, para i=1,...,n
%                   que son aproximadas por la regla del Trapecio para
%                   obtener
%                                               b_i = f(x_i)*h/2
%                   siendo h=x_{i+1} - x_i la longitud del intervalo i
%  Datos entrada:                                                                                                                               
%        x - Vector, nodos de la malla
%        f - Matlab anonimous function de x
% Datos salida:
%       b - Vector de peso
% Fecha elaboracion: 8/feb/2016
% Ultima actualizacion: 9/feb/2016
%---------------------------------------------------------------------------------------------------------------------                   
function b=LoadAssembler1D(x,f)
n=length(x)-1;
b=zeros(n+1,1);
for i=1:n
    h=x(i+1)-x(i);
    b(i) = b(i) + f(x(i))*h/2;
    b(i+1) = b(i+1) + f(x(i+1))*h/2;
end
    

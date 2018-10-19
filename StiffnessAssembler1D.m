function A=StiffnessAssembler1D(x)
n=length(x); % # de elementos de la malla
A=zeros(n,n); % inicializamos la matriz de rigidez
for i=1:n-1
    h = x(i+1) - x(i);
    A(i,i) = A(i,i) + 1/h;
    A(i,i+1) = A(i,i+1) - 1/h;
    A(i+1,i) = A(i+1,i) - 1/h;
    A(i+1,i+1) = A(i+1,i+1) +1/h;
end

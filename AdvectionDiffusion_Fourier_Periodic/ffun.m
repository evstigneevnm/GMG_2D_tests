function f = ffun( X, Y )
% FFUN  Forcing  f  of the given operator problem
%

%f = zeros(size(X));
f = -exp( -60.*X.*X ).*exp( -60.*Y.*Y );
[nx,ny] = size(X);

for j=1:nx
    for k=1:ny
        f(1,k)=0;
        f(nx,k)=0;
        f(j,1)=0;
        f(j,ny)=0;
    end
end
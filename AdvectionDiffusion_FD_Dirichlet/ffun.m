function f = ffun( X, Y )
% FFUN  Forcing  f  of the given operator problem
%

%f = zeros(size(X));
f = -10*exp( -260.*X.*X ).*exp( -260.*Y.*Y );
[nx,ny] = size(X);

for j=1:nx
    for k=1:ny
        f(1,k)=0;
        f(nx,k)=0;
        f(j,1)=0;
        f(j,ny)=0;
    end
end
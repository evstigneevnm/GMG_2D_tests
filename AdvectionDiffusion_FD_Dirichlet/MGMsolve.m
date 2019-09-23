function [ z_n, b, resid_n, tElapsed, flag_G ] = MGMsolve(Nx,Ny, IT_n, eps_n, smoother_n, mu, z_nl)
%test wrap for multigrid


if nargin==6
    z_n=zeros(Nx,Ny);    
else
    z_n=z_nl;
end

it=0;
zz=Nx-1;
while zz>6
    zz=zz/2;
    it=it+1;
end
%it=-1;
fprintf('multigrid levels: %i\n',it);

h=1.0/Nx;
ax=-0.2;ay=-0.2;
ii = 1:Nx; x = ax + (ii-1)*h;
jj = 1:Ny; y = ay + (jj-1)*h;
[X,Y] = ndgrid(x,y);	% like meshgrid but x index is first, y is second

%RHS
b = ffun( X, Y );

%number of MG iterations
IT=IT_n;
flag_G = 1;
resid_n(1,1) = norm(operator(1,z_n)-b);
tStart = tic;
for l=1:IT
    z_n = MGM(it, z_n, b, smoother_n, mu);
    resid_nl=sqrt(h*h)*norm(residual( z_n, b, mu ));
    resid_n = [resid_n; resid_nl];
    %fprintf('iteration %i with residual %e\n', l, resid_nl);
    
    if(resid_nl<eps_n)
        flag_G = 0;
        break;
    elseif(resid_nl > 100000.0)
        flag_G = 1;
        break;
    end
    
end
tElapsed = toc(tStart);

end


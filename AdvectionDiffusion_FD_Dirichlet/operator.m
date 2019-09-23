function [ z_new ] = operator(k, z_old)
%   Definition of multilevel operator function
%   should be edited for specific problem
    [Nx,Ny]=size(z_old);
    hx=1.0/Nx;
    hy=1.0/Ny;
    z_new=0.*z_old;
    %laplace operator

    for j=2:Nx-1
        for k=2:Ny-1
            z_new(j,k)=((z_old(j+1,k)-2*z_old(j,k)+z_old(j-1,k))/(hx^2)+(z_old(j,k+1)-2*z_old(j,k)+z_old(j,k-1))/(hy^2));
        end
    end

end


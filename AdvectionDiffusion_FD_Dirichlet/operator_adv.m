function [ z_new ] = operator_adv(~, z_old, mu)
%   Definition of multilevel operator function
%   should be edited for specific problem
    [Nx,Ny]=size(z_old);
    hx=1.0/Nx;
    hy=1.0/Ny;
    z_new=0.*z_old;
    
    [vel_x, vel_y] = velocity_field( Nx, Ny );

    for j=2:Nx-1
        for k=2:Ny-1
            adv_v = - advection_upwind_1( vel_x, vel_y, z_old, j, k, hx, hy );
            z_new(j,k)=adv_v+mu*( (z_old(j+1,k)-2*z_old(j,k)+z_old(j-1,k))/(hx^2)+(z_old(j,k+1)-2*z_old(j,k)+z_old(j,k-1))/(hy^2) );
        end
    end

end


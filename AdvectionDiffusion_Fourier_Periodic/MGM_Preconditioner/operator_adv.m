function [ z_new ] = operator_adv(~, z_old, mu)
%   Definition of multilevel operator function
%   should be edited for specific problem
    [Nx, Ny]=size(z_old);
    hx=2.*pi/Nx;
    hy=2.*pi/Ny;
    z_new=0.*z_old;
    %laplace operator
    
    [vel_x, vel_y] = velocity_field( Nx, Ny );

    for j=1:Nx
        for k=1:Ny
            [jp, kp] = periodic_indexing(Nx, Ny, j+1, k+1);
            [jm, km] = periodic_indexing(Nx, Ny, j-1, k-1);
            %adv_v = - advection_upwind_1( vel_x, vel_y, z_old, j, k, hx, hy );
            adv_v = - advection_SOU( vel_x, vel_y, z_old, j, k, hx, hy );
            %adv_v = - advection_QUICK( vel_x, vel_y, z_old, j, k, hx, hy );
            z_new(k, j)=adv_v+mu*( (z_old(k, jp)-2*z_old(k,j)+z_old(k,jm))/(hx^2)+(z_old(kp,j)-2*z_old(k,j)+z_old(km,j))/(hy^2) );
        end
    end

end


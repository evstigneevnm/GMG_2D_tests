function [ u_ext ] = plot_solution_vel( uE, h1)
% returns vector solution to physical space and plots it
    if nargin==1
        figure(1);
    else
        figure(h1);
    end
    
    u_hat=R2C(uE);
    [Nx,Ny]=size(u_hat);
    Kx = Nx; Ky=Ny;
    scale=Kx/Nx;
    
    u_hat_ext(1:Nx/2+1,1:Ny/2+1)=u_hat(1:Nx/2+1,1:Ny/2+1);
    u_hat_ext(1:Nx/2+1,Ky-Ny/2+2:Ky)=u_hat(1:Nx/2+1,Ny/2+2:Ny);
    u_hat_ext(Kx-Nx/2+2:Ky,Ky-Ny/2+2:Ky)=u_hat(Nx/2+2:Nx,Ny/2+2:Ny);
    u_hat_ext(Kx-Nx/2+2:Ky,1:Ny/2+1)=u_hat(Nx/2+2:Nx,1:Ny/2+1);
    u_ext=ifft2(scale.*scale.*u_hat_ext,'symmetric');
    %mesh(u_ext);
    
    [ vel_x, vel_y ] = velocity_field( Kx, Ky );
    
    
    contour(u_ext);
    hold on;
    quiver(vel_x,vel_y);
    hold off;
end


function [ u_ext ] = plot_solution( uE, Kx, Ky)
% returns vector solution to physical space and plots it

    u_hat=R2C(uE);
    [Nx,Ny]=size(u_hat);
    scale=Kx/Nx;
    
    u_hat_ext(1:Nx/2+1,1:Ny/2+1)=u_hat(1:Nx/2+1,1:Ny/2+1);
    u_hat_ext(1:Nx/2+1,Ky-Ny/2+2:Ky)=u_hat(1:Nx/2+1,Ny/2+2:Ny);
    u_hat_ext(Kx-Nx/2+2:Ky,Ky-Ny/2+2:Ky)=u_hat(Nx/2+2:Nx,Ny/2+2:Ny);
    u_hat_ext(Kx-Nx/2+2:Ky,1:Ny/2+1)=u_hat(Nx/2+2:Nx,1:Ny/2+1);
    u_ext=ifft2(scale.*scale.*u_hat_ext,'symmetric');
    
    [X,Y] = meshgrid(-pi:2*pi/(Kx-1):pi);
    mesh(X,Y, u_ext);
    %contour(u_ext);
    %surf(u_ext);
end


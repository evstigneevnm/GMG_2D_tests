function [ z_new ] = AD_linear_operator( z_old, alpha )
% Advectoin-Diffusion linear operator
% should be preconditioned via physical space multigrid preconditioner

    u_hat=R2C(z_old);
    [Nx,Ny] = size(u_hat);
    [ vel_x, vel_y ] = velocity_field(Nx, Ny); 
    
    
    [N,~]=size(u_hat);
    jj=[0:((N)/2-1) (-(N)/2):(-1)]';
    [KX,KY] = meshgrid(jj,jj);
    Kdiff = -(KX.^2 + KY.^2);
    Knabla_x = 1i.*KX;
    Knabla_y = 1i.*KY;    
    jj_mask = [(0:((Nx)/2-1))<2/3*Nx/2 abs((-(Nx)/2):(-1))<2/3*Nx/2]';
    kk_mask = [(0:((Ny)/2-1))<2/3*Ny/2 abs((-(Ny)/2):(-1))<2/3*Ny/2]';
    mask = kk_mask*jj_mask';

    
    u_x_hat=Knabla_x.*u_hat;%.*mask;
    u_y_hat=Knabla_y.*u_hat;%.*mask;
    u_x_ext=ifft2(u_x_hat,'symmetric');
    u_y_ext=ifft2(u_y_hat,'symmetric');

    w1_hat_ext=fft2(u_x_ext.*vel_x) + fft2(u_y_ext.*vel_y);

    dinum=(alpha.*Kdiff);
    b_hat=(-w1_hat_ext) + dinum.*u_hat;
    z_new=C2R(b_hat);
    
    
end



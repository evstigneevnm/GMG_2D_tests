function [ z_new ] = smoother_BiCGL(k,z_old,b,n1,mu)
%   Definition of multilevel smoother function
%   operator_vec should be edited for specific problem

    [Nx,Ny]=size(z_old);
    hx=1.0/Nx;
    hy=1.0/Ny;
    b_vec=array2vec(b);
    z_old_vec=array2vec(z_old);
    iterations=min(n1,Nx*Ny);
    
    %[z_new_vec, flag_G, relres_G, iter_G] =bicgstabl(@(x)operator_vec(k, x, Nx, Ny,mu), b_vec, 1.0e-9, iterations,[],[],z_old_vec);
    
    %z_old_s=zeros(Nx,Ny);
    
    [z_new_vec, flag_G, relres_G, iter_G] =bicgstabl(@(x)operator_vec(k, x, Nx, Ny, mu), b_vec, 1.0e-9, iterations,@(x)smoother_Jac_adv_vec(k,z_old,x,3,mu),[],z_old_vec);
    
    z_new=vec2array(z_new_vec, z_old);
    
end




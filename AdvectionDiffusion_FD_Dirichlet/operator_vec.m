function [ z_new_vec ] = operator_vec(k, z_old_vec, Nx, Ny, mu)
%   Definition of multilevel operator function 
%   in vector variant for Krylov  solvers
%   should be edited for specific problem

    
    hx=1.0/Nx;
    hy=1.0/Ny;
    u=zeros(Nx,Ny);
    u_o = vec2array(z_old_vec, u);
    
    u_n = operator_adv(k, u_o, mu);
    
    z_new_vec = array2vec(u_n);
    

end


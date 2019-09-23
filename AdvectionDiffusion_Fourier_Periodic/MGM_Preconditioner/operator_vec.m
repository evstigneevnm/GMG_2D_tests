function [ z_new_vec ] = operator_vec(k, z_old_vec, mu)
%   Definition of multilevel operator function 
%   in vector variant for Krylov  solvers
%   should be edited for specific problem

    
    z_old = R2Ph(z_old_vec);
    
    u_n = operator_adv(k, z_old, mu);
    
    [nx,ny]=size(u_n);
    z_new_vec = Ph2R(u_n);
    z_new_vec = z_new_vec - sum(z_new_vec)/(nx*ny);

end


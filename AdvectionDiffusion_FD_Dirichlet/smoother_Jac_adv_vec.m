function [ z_new_vec ] = smoother_Jac_adv_vec(k,z_old,b_vec,n1,mu)
%wrapper for vector operations in Jacobi method
%to be used as preconditioner

    
    b=vec2array(b_vec, z_old);
    
   
    z_new = smoother_Jac_adv(k,z_old,b,n1,mu);

    
    z_new_vec = array2vec(z_new);
end


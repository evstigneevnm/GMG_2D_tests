function [ z_new_vec ] = smoother_GS_adv_vec(k,z_old,b_vec,n1,mu)
%wrapper for vector operations in GS method
%to be used as preconditioner


    b=vec2array(b_vec, z_old);

    z_new = smoother_GS_adv_1(k,z_old,b,n1,mu);

    z_new_vec = array2vec(z_new);
end


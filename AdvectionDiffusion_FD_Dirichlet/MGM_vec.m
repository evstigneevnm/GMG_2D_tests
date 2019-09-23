function [ z_n_vec ] = MGM_vec( k, z, b_vec, smoother_n, mu )
% MGM vector wrapper for MGM
    b=vec2array(b_vec, z);
    
    if (strcmp(smoother_n,'none')==1)
        z_n_vec = b_vec;
    else
        z_n = MGM( k, z, b, smoother_n, mu);
        z_n_vec = array2vec(z_n);
    end
    

    

end


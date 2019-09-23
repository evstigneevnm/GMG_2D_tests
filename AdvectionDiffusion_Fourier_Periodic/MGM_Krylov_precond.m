function [z_n_vec] = MGM_Krylov_precond(z_vec, b_vec, smoother_n, mu, it )
% Krylov preconditioner with MGM preconditioner itself
    
    
    if (strcmp(smoother_n,'none')==1)
        z_n_vec = b_vec;
    else
        restarts = [];
        eps_n = 1.0e-7;
        iterations = 50;
        [z_n_vec, flag_G, rr_G, iter_G, rv_0] =gmres(@(x)operator_vec(0, x, mu), b_vec, restarts, eps_n, iterations, @(x)MGM_precond(z_vec, x, smoother_n, mu, it),[]);
        if(flag_G>0)
            disp(flag_G);
        else
            %disp(rr_G); disp(iter_G);
        end
        
     end
    
    
end


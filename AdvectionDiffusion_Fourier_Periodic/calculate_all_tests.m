


%possible solvers:;
% GMRES_K, GMRES_M, QMR_M, BICG, BICGL
%possible preconditioners:
% GS, Jacobi

eps = 1.0e-12;


sz_min = 7; %defined as 2^sz for sz in [sz_min, sz_max]
sz_max = 9;
R_min = 3;  %defined as 2^R for R in [R_min, R_max]
R_max = 4;

total_k = 1;
for sz_pow = sz_min:sz_max %4:8
    Nx = 2^sz_pow;
    Ny = 2^sz_pow;
    IT = min(500, Nx*Ny/2-2);
    
    for rey_power = R_min:R_max
        Rey = 10^rey_power;
        
        [ z_n, b, resid_n, tElapsed, flag_G] = KrylovMGMsolve(Nx, Ny, IT, eps, 1.0/Rey, 'GMRES_M', 'GS');
        if flag_G ~=0
            fprintf('faild at %i X %i, Rey = %i with flag = %i\n', Nx, Ny, Rey, flag_G);
        end
        r = final_residual( z_n, b, 1.0/Rey );
        fprintf('%i X %i, Rey = %i, residual norm = %e\n', Nx, Ny, Rey, sqrt(1./Nx.*1./Ny)*norm(r));
        DATA{sz_pow, rey_power} = {flag_G, Nx, Ny, Rey,tElapsed, sqrt(1./Nx.*1./Ny).*resid_n, z_n, b};
        total_k=total_k+1;
    end
    
    
end


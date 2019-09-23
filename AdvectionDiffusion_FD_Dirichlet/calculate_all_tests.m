

eps = 1.0e-8;


sz_min = 4;
sz_max = 9;
R_min = 3;
R_max = 4;

total_k = 1;
for sz_pow = sz_min:sz_max %4:8
    Nx = 2^sz_pow+1;
    Ny = 2^sz_pow+1;
    IT = round(min(500, Nx*Ny/2-2));
    
    for rey_power = R_min:R_max
        Rey = 10^rey_power;
        
        [ z_n, b, resid_n, tElapsed, flag_G] = KrylovMGMsolve(Nx, Ny, IT, eps, 'BICGL', 'GS', 1.0/Rey);
        %[ z_n, b, resid_n, tElapsed, flag_G ] = MGMsolve(Nx, Ny, IT, eps, 'GMRES', 1.0/Rey);
        if flag_G ~=0
            fprintf('faild at %i X %i, Rey = %i with flag = %i\n', Nx, Ny, Rey, flag_G);
        end
        r = residual( z_n, b, 1.0/Rey );
        fprintf('%i X %i, Rey = %i, residual norm = %e\n', Nx-1, Ny-1, Rey, sqrt(1./Nx.*1./Ny)*norm(r));
        DATA{sz_pow, rey_power} = {flag_G, Nx-1, Ny-1, Rey,tElapsed, sqrt(1./Nx.*1./Ny).*resid_n, z_n, b};
        total_k=total_k+1;
    end
    
    
end


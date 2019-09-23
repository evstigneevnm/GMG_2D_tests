function [ z_n, b, resid_n, tElapsed, flag_G] = KrylovMGMsolve(Nx,Ny,IT_n,eps_n, solver_n, smoother_n, mu, z_nl)
% test for Krylov methods prconditioned with MGM

    if nargin==7
        z_n=zeros(Nx,Ny);    
    else
        z_n=z_nl;
    end

    
    h=1.0/Nx;
    ax=-0.2;ay=-0.2;
    ii = 1:Nx; x = ax + (ii-1)*h;
    jj = 1:Ny; y = ay + (jj-1)*h;
    [X,Y] = ndgrid(x,y);	
    
    %RHS
    b = ffun( X, Y );

    %MGM levels
    MGM_levels=0;
    zz=Nx-1;
    while zz>6
        zz=zz/2;
        MGM_levels=MGM_levels+1;
    end
    %it=-1;
    fprintf('multigrid levels: %i\n',MGM_levels);

    
    %number of Krylov iterations
    iterations=IT_n;
    z_old_vec = array2vec(z_n);
    b_vec = array2vec(b);
    zer_arr = zeros(Nx, Ny);
    restarts = [];
    tStart = tic;
    switch solver_n
        case 'GMRES'
            [z_new_vec, flag_G, rr_G, iter_G, rv_0] =gmres(@(x)operator_vec(0, x, Nx, Ny, mu), b_vec, restarts, eps_n, iterations,@(x)MGM_vec(MGM_levels, zer_arr, x, smoother_n, mu ),[], z_old_vec);
        case 'BICG'
            [z_new_vec, flag_G, rr_G, iter_G, rv_0] =bicgstab(@(x)operator_vec(0, x, Nx, Ny, mu), b_vec, eps_n, iterations,@(x)MGM_vec(MGM_levels, zer_arr, x, smoother_n, mu  ),[], z_old_vec);
        case 'BICGL'
            [z_new_vec, flag_G, rr_G, iter_G, rv_0] =bicgstabl(@(x)operator_vec(0, x, Nx, Ny, mu), b_vec, eps_n, iterations,@(x)MGM_vec(MGM_levels, zer_arr, x, smoother_n, mu  ),[], z_old_vec);
        otherwise
            warning('There is no correct main solver!');
    end
    tElapsed = toc(tStart);
    resid_n = rv_0/norm(b_vec);
    z_n=vec2array(z_new_vec,z_n);
end


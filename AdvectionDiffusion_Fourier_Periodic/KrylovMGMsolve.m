function [ z_n, b, resid_n, tElapsed, flag_G] = KrylovMGMsolve(Nx, Ny, IT_n, eps_n, mu, solver_n, smoother_n, mgm_levels)
% test for Krylov methods preconditioned with MGM
    addpath('./MGM_Preconditioner');

    it=0;
    zz=Nx;
    while zz>=6
        zz=zz/2;
        it=it+1;
    end
    
    if nargin==8
        it = mgm_levels;   
    end
    fprintf('Number of preconditioner multigrid levels =  %i\n', it);


    %set RHS:
    bph=sin(2*pi*(1:Nx)/Nx)'*cos(2*pi*(1:Ny)/Ny);
%    h=1.0/Nx;
%    ax=-0.5;ay=-0.5;
%    ii = 1:Nx; x = ax + (ii-1)*h;
%    jj = 1:Ny; y = ay + (jj-1)*h;
%    [X,Y] = ndgrid(x,y);	
%    bph = ffun( X, Y );
    
%    bph = sin(2*pi*[1:Nx]./Nx)+cos(2*pi*[1:Ny]./Ny)';
    bh=fft2(bph);
    b=C2R(bh);
    
    %velcity field
    [ vel_x, vel_y ] = velocity_field( Nx, Ny );
    vel_x_E = Ph2R(vel_x);
    vel_y_E = Ph2R(vel_y);
    vel_x = R2Ph(vel_x_E);
    vel_y = R2Ph(vel_y_E);
    
    %number of Krylov iterations
    iterations=IT_n;
    zer_arr = zeros(Nx*Ny/2-2,1);
    restarts = [];
    tStart = tic;
    switch solver_n
        case 'GMRES_K'
            [z_n, flag_G, rr_G, iter_G, rv_0] =gmres(@(x)AD_linear_operator(x, mu), b, restarts, eps_n, iterations,@(x)MGM_Krylov_precond(zer_arr, x, smoother_n, mu, it ));
        case 'GMRES_M'
            [z_n, flag_G, rr_G, iter_G, rv_0] =gmres(@(x)AD_linear_operator(x, mu), b, restarts, eps_n, iterations,@(x) MGM_precond(zer_arr, x, smoother_n, mu, it ));
        case 'QMR_M'
            [z_n, flag_G, rr_G, iter_G, rv_0] =qmr(@(x)AD_linear_operator(x, mu), b, eps_n, iterations,@(x) MGM_precond(zer_arr, x, smoother_n, mu, it ));

         case 'BICG'
             [z_n, flag_G, rr_G, iter_G, rv_0] =bicgstab(@(x)AD_linear_operator(x, mu), b, eps_n, iterations,@(x)MGM_precond(zer_arr, x, smoother_n, mu, it ));
         case 'BICGL'
             [z_n, flag_G, rr_G, iter_G, rv_0] =bicgstabl(@(x)AD_linear_operator(x, mu), b, eps_n, iterations,@(x)MGM_precond(zer_arr, x, smoother_n, mu, it ));
        otherwise
            warning('There is no correct main solver!');
    end
    tElapsed = toc(tStart);
    resid_n = rv_0; %/norm(b)
end


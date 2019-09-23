function [A] = Form_Matrix_precond(Nx, Ny, mu)
% Forms matrix for abstrct linear operator
    
    N=(Nx*Ny/2-2);
    A=zeros(N,N);
    z_vec = zeros(N,1);
    for ll=1:N
        e0 = zeros(N,1);
        e0(ll,1)=1;
        %A(ll,:) = operator_vec(0, e0, mu);
        A(ll,:) = MGM_Krylov_precond(z_vec, e0, 'Jacobi', mu, 2 );
        
        fprintf('%.03f%%\r',ll/N*100.0);
    end


end


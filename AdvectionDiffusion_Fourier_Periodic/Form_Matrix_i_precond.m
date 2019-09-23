function [A] = Form_Matrix_i_precond(Nx, Ny, mu)
% Forms matrix for abstrct linear operator
    
    N=(Nx*Ny/2-2);
    A=zeros(N,N);
    z_vec = zeros(N,1);
    it=0;
    zz=Nx;
    while zz>4
        zz=zz/2;
        it=it+1;
    end    
    
    for ll=1:N
        e0 = zeros(N,1);
        e0(ll,1)=1;
        %A(ll,:) = MGM_Krylov_precond(z_vec, e0, 'GS', mu, it );
        A(ll,:) = MGM_precond(z_vec, e0, 'GS', mu, it );
        %A(ll,:) = MGM_precond(z_vec, e0, 'GS', mu, -1 );
        
        fprintf('%.03f%%\r',ll/N*100.0);
    end


end


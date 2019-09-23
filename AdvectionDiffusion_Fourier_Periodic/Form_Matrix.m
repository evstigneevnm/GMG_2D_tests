function [A] = Form_Matrix(Nx, Ny, mu)
% Forms matrix for abstrct linear operator
    [ vel_x, vel_y ] = velocity_field( Nx, Ny );
    
    N=(Nx*Ny/2-2);
    A=zeros(N,N);
    
    for ll=1:N
        e0 = zeros(N,1);
        e0(ll,1)=1;
        A(ll,:) = AD_linear_operator( e0, mu );
    end


end


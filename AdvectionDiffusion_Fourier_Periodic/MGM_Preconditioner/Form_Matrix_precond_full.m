function [A] = Form_Matrix_precond_full(Nx, Ny, mu)
% matrix of the full operator
    [ vel_x, vel_y ] = velocity_field( Nx, Ny );
    
    A = operator_adv_matrix(Nx, Ny, mu, vel_x, vel_y);

       


end


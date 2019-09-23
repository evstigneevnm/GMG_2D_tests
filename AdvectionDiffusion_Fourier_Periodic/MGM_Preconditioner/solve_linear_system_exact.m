function [z_new] = solve_linear_system_exact(~, ~, b, ~, mu)
% direct solver for the lowerst level

    [nx,ny]=size(b);
    
    
    A = operator_adv_matrix(nx, ny, mu);
    
    b_vec = zeros(nx*ny,1);
    for j=1:nx
        for k = 1:ny
            I = II(nx, ny, j, k);
            b_vec(I,1) = b(j,k);
        end
    end
    %b_vec = b_vec - sum(b_vec)./(nx*ny);
    
    %z_new_vec = A\b_vec;
    [z_new_vec,flag,~,~] = gmres(@(x)operator_vec(0, x, mu),b_vec,16,1.0e-12,16);
    if flag~=0
        fprintf('gmres on the lowest level failed to converge with the flag = %i', flag);
    end
    
    z_new = zeros(nx,ny);
    for j=1:nx
        for k = 1:ny
            I = II(nx, ny, j, k);
            z_new(j,k) = z_new_vec(I,1);
        end
    end   
    
end


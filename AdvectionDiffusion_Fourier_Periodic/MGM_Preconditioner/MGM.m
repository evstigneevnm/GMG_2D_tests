function [ z_n ] = MGM( k, z, b, smoother_n, mu )
%   general multigrid framework
%   Can be used in both GMG and AMG
%   ========================================================
%   requires definition of the following functions:
%       solution = smoother_exact(RHS)
%       residual = operator(level_number, solution_vector)
%       new_solution_vector = smoother(level_number, old_solusion_vector, RHS, number_of_iterations)
%       corse_vecrtor = restrictor(level_number, fine_vector)
%       fine_vector = prolongator(level_number, corse_vector)
    n1=2; % restriction smoothers
    n2=1; % number of inlined MGM cycles (W and F cycles).
    n3=3; % prolongation smoothers
    if(k==0)
        z_n=smoother_select_exact(smoother_n, 0, z, b, mu);
    elseif(k==-1)  %use the selected smoother with minimal iterations
        z_n=smoother_select( smoother_n, k, z, b, n1, mu);
    else
        n_i=n1;
        z_n1=smoother_select( smoother_n, k, z, b, n_i, mu);
        resid=residual(z_n1, b, mu);
        d=restrictor(resid);
        e_n2=0.*d; %zero array with the same size for (k-1) level
        for j=1:n2
            e_n2=MGM(k-1, e_n2, d, smoother_n, mu);
        end
        
        z_n3=z_n1-prolongator(e_n2);
        if(n3==0)
            z_n=z_n3;
        else
            z_n=smoother_select( smoother_n, k, z_n3, b, n3, mu);
        end
       
    end

    
end


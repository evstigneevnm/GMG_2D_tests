function [ z_n ] = smoother_select_exact( smoother_n, k, z, b, mu )
%Selection of particular smoother

    switch smoother_n
        case 'GS' 
            z_n=smoother_GS_adv_1(k, z, b, 100, mu);
        case 'Jacobi'
            z_n=smoother_Jac_adv(k, z, b, 100, mu);
        case 'GMRES'
            z_n=smoother_GMRES(k, z, b, 100, mu);          
        case 'BICG'
            z_n=smoother_BiCG(k, z, b, 100, mu);
        case 'BICGL'
            z_n=smoother_BiCGL(k, z, b, 100, mu);
        otherwise
            warning('Unexpected iterator_type.');
     end

end


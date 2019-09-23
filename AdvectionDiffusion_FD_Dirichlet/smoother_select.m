function [ z_n ] = smoother_select( smoother_n, k, z, b, n, mu )
%Selection of particular smoother

    switch smoother_n
        case 'GS' 
            z_n=smoother_GS_adv_1(k, z, b, n, mu);
        case 'Jacobi'
            %z_n=smoother_Jac(k, z, b, n);
            z_n=smoother_Jac_adv(k, z, b, n, mu);
        case 'GMRES'
            z_n=smoother_GMRES(k, z, b, n, mu);
        case 'BICG'
            z_n=smoother_BiCG(k, z, b, n, mu);    
        case 'BICGL'
            z_n=smoother_BiCGL(k, z, b, n, mu);             
        otherwise
            warning('Unexpected iterator_type.');
     end

end


function [ z_new ] = smoother_GS_adv_1(~, z_old, b, n1, mu)
% Gauss Seidel two swipes

    z_new=z_old;
    [nx,ny]=size(z_old);
    hx=2.*pi/nx;
    hy=2.*pi/ny;
    [vel_x, vel_y] = velocity_field( nx, ny );

    
    for l=1:n1
        
        for k=1:ny
            for j=1:nx
                [jp,kp] = periodic_indexing(nx,ny,j+1,k+1);
                [jm,km] = periodic_indexing(nx,ny,j-1,k-1);
                
                z_new = GS_single_step(j, k, jp, kp, jm, km, vel_x, vel_y, z_new, b, hx, hy, mu);
 
            end
        end

        for k=ny:-1:1
            for j=nx:-1:1
                [jp,kp] = periodic_indexing(nx,ny,j+1,k+1);
                [jm,km] = periodic_indexing(nx,ny,j-1,k-1);
                
                z_new = GS_single_step(j, k, jp, kp, jm, km, vel_x, vel_y, z_new, b, hx, hy, mu);            
            
            end
        end
        
    end
end

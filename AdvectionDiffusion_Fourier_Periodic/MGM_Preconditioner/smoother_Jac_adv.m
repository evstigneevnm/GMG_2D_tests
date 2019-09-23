function [ z_new ] = smoother_Jac_adv(~, z_old, b, n1, mu)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
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
                vw = 0.5*(vel_x(k,j)+vel_x(k,jm));
                ve = 0.5*(vel_x(k,j)+vel_x(k,jp));
                vn = 0.5*(vel_y(k,j)+vel_y(km,j));
                vs = 0.5*(vel_y(k,j)+vel_y(kp,j));
                vw_sp = 0.5*abs(sign(vw)+1);
                vw_sm = 0.5*abs(sign(vw)-1);
                ve_sp = 0.5*abs(sign(ve)+1);
                ve_sm = 0.5*abs(sign(ve)-1);
                vs_sp = 0.5*abs(sign(vs)+1);
                vs_sm = 0.5*abs(sign(vs)-1);
                vn_sp = 0.5*abs(sign(vn)+1);
                vn_sm = 0.5*abs(sign(vn)-1);
                                
                lhs = (vel_x(k,j)*ve_sp/hx-vel_x(k,j)*vw_sm/hx+vel_y(k,j)*vs_sp/hy-vel_y(k,j)*vn_sm/hy);
                lhs = lhs + 2*mu*(1.0/hx/hx+1.0/hy/hy);
                adv = -(vel_x(k,j)*ve_sm*z_old(k,jp)/hx-vel_x(k,j)*vw_sp*z_old(k,jm)/hx+vel_y(k,j)*vs_sm*z_old(kp,j)/hy-vel_y(k,j)*vn_sp*z_old(km,j)/hy );
                z_new(k,j) = (adv+mu*(z_old(k,jm)/hx/hx + z_old(k,jp)/hx/hx + z_old(km,j)/hy/hy + z_old(kp,j)/hy/hy) - b(k,j))/lhs;
            end
        end
        z_old=z_new;

    end
end
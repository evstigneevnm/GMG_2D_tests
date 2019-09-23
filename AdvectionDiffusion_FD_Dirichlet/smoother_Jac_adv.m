function [ z_new ] = smoother_Jac_adv(k,z_old,b,n1,mu)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
    z_new=z_old;
    [nx,ny]=size(z_old);
    hx=1/nx;
    hy=1/ny;
    
    [vel_x, vel_y] = velocity_field( nx, ny );

    for l=1:n1
        for j=2:ny-1
            for i=2:nx-1
                vw = 0.5*(vel_x(i,j)+vel_x(i-1,j));
                ve = 0.5*(vel_x(i,j)+vel_x(i+1,j));
                vn = 0.5*(vel_y(i,j)+vel_y(i,j-1));
                vs = 0.5*(vel_y(i,j)+vel_y(i,j+1));
                vw_sp = 0.5*abs(sign(vw)+1);
                vw_sm = 0.5*abs(sign(vw)-1);
                ve_sp = 0.5*abs(sign(ve)+1);
                ve_sm = 0.5*abs(sign(ve)-1);
                vs_sp = 0.5*abs(sign(vs)+1);
                vs_sm = 0.5*abs(sign(vs)-1);
                vn_sp = 0.5*abs(sign(vn)+1);
                vn_sm = 0.5*abs(sign(vn)-1);
                                
                lhs = (vel_x(i,j)*ve_sp/hx-vel_x(i,j)*vw_sm/hx+vel_y(i,j)*vs_sp/hy-vel_y(i,j)*vn_sm/hy);
                lhs = lhs + 2*mu*(1.0/hx/hx+1.0/hy/hy);
                adv = -(vel_x(i,j)*ve_sm*z_old(i+1,j)/hx-vel_x(i,j)*vw_sp*z_old(i-1,j)/hx+vel_y(i,j)*vs_sm*z_old(i,j+1)/hy-vel_y(i,j)*vn_sp*z_old(i,j-1)/hy );
                z_new(i,j) = (adv+mu*(z_old(i-1,j)/hx/hx + z_old(i+1,j)/hx/hx + z_old(i,j-1)/hy/hy + z_old(i,j+1)/hy/hy) - b(i,j))/lhs;
            end
        end
        z_old=z_new;

    end
end
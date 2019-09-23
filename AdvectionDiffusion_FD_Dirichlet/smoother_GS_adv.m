function [ z_new ] = smoother_GS_adv(k,z_old,b,n1,mu)
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
                vw_sp = 0.5*(vw+abs(vw));
                vw_sm = 0.5*(vw-abs(vw));
                ve_sp = 0.5*(ve+abs(ve));
                ve_sm = 0.5*(ve-abs(ve));
                vs_sp = 0.5*(vs+abs(vs));
                vs_sm = 0.5*(vs-abs(vs));
                vn_sp = 0.5*(vn+abs(vn));
                vn_sm = 0.5*(vn-abs(vn));
                                
                lhs = (ve_sp/hx-vw_sm/hx+vs_sp/hy-vn_sm/hy)+2*mu*(1.0/hx/hx+1.0/hy/hy);
                adv = -(ve_sm*z_new(i+1,j)/hx-vw_sp*z_new(i-1,j)/hx+vs_sm*z_new(i,j+1)/hy-vn_sp*z_new(i,j-1)/hy );
                z_new(i,j) = (adv+mu*(z_new(i-1,j) + z_new(i+1,j) + z_new(i,j-1) + z_new(i,j+1)) - b(i,j))/lhs;
            end
        end
        for j=ny-1:-1:2
            for i=nx-1:-1:2
                vw = 0.5*(vel_x(i,j)+vel_x(i-1,j));
                ve = 0.5*(vel_x(i,j)+vel_x(i+1,j));
                vn = 0.5*(vel_y(i,j)+vel_y(i,j-1));
                vs = 0.5*(vel_y(i,j)+vel_y(i,j+1));
                vw_sp = 0.5*(vw+abs(vw));
                vw_sm = 0.5*(vw-abs(vw));
                ve_sp = 0.5*(ve+abs(ve));
                ve_sm = 0.5*(ve-abs(ve));
                vs_sp = 0.5*(vs+abs(vs));
                vs_sm = 0.5*(vs-abs(vs));
                vn_sp = 0.5*(vn+abs(vn));
                vn_sm = 0.5*(vn-abs(vn));
                                
                lhs = (ve_sp/hx-vw_sm/hx+vs_sp/hy-vn_sm/hy)+2*mu*(1.0/hx/hx+1.0/hy/hy);
                adv = -(ve_sm*z_new(i+1,j)/hx-vw_sp*z_new(i-1,j)/hx+vs_sm*z_new(i,j+1)/hy-vn_sp*z_new(i,j-1)/hy );
                z_new(i,j) = (adv+mu*(z_new(i-1,j) + z_new(i+1,j) + z_new(i,j-1) + z_new(i,j+1)) - b(i,j))/lhs;
            end
        end
        
    end
end


function [ adv_u ] = advection_upwind( vel_x, vel_y, u, j, k, hx, hy )
%defines upwind advection for variable field 'vel'
    vel_w = 0.5*(vel_x(j,k)+vel_x(j-1,k));
    vel_e = 0.5*(vel_x(j,k)+vel_x(j+1,k));
    vel_n = 0.5*(vel_y(j,k)+vel_y(j,k-1));
    vel_s = 0.5*(vel_y(j,k)+vel_y(j,k+1));
    
    

    if vel_w<0
        adv_w = u(j,k);
    else
        adv_w = u(j-1,k);
    end
    
    if vel_e<0
        adv_e = u(j+1,k);
    else
        adv_e = u(j,k);
    end

    if vel_n<0
        adv_n = u(j,k);
    else
        adv_n = u(j,k-1);
    end
    
    if vel_s<0
        adv_s = u(j,k+1);
    else
        adv_s = u(j,k);
    end
    
    adv_u = vel_x(j,k)*(adv_e-adv_w)/hx + vel_y(j,k)*(adv_s-adv_n)/hy;
    %adv_u = (vel_e*adv_e-vel_w*adv_w)/hx + (vel_s*adv_s-vel_n*adv_n)/hy;

    
end


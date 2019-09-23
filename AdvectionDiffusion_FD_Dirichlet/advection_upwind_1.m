function [ adv_u ] = advection_upwind_1( vel_x, vel_y, u, j, k, hx, hy )
%defines upwind advection for variable field 'vel'
    vw = 0.5*(vel_x(j,k)+vel_x(j-1,k));
    ve = 0.5*(vel_x(j,k)+vel_x(j+1,k));
    vn = 0.5*(vel_y(j,k)+vel_y(j,k-1));
    vs = 0.5*(vel_y(j,k)+vel_y(j,k+1));
%    
%    vw_sp = 0.5*(vw+abs(vw));
%    vw_sm = 0.5*(vw-abs(vw));
%    ve_sp = 0.5*(ve+abs(ve));
%    ve_sm = 0.5*(ve-abs(ve));
%    vs_sp = 0.5*(vs+abs(vs));
%    vs_sm = 0.5*(vs-abs(vs));
%    vn_sp = 0.5*(vn+abs(vn));
%    vn_sm = 0.5*(vn-abs(vn));    

    vw_sp = 0.5*abs(sign(vw)+1);
    vw_sm = 0.5*abs(sign(vw)-1);
    ve_sp = 0.5*abs(sign(ve)+1);
    ve_sm = 0.5*abs(sign(ve)-1);
    vs_sp = 0.5*abs(sign(vs)+1);
    vs_sm = 0.5*abs(sign(vs)-1);
    vn_sp = 0.5*abs(sign(vn)+1);
    vn_sm = 0.5*abs(sign(vn)-1);      
    
    
    ue = ve_sp*u(j,k)+ve_sm*u(j+1,k);
    uw = vw_sp*u(j-1,k)+vw_sm*u(j,k);
    us = vs_sp*u(j,k)+vs_sm*u(j,k+1);
    un = vn_sp*u(j,k-1)+vn_sm*u(j,k);
    
    adv_u = vel_x(j,k)*(ue-uw)/hx + vel_y(j,k)*(us-un)/hy;
    %adv_u = (ue-uw)/hx + (us-un)/hy;

    
end

